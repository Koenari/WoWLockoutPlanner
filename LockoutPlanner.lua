--  Lockout Planner AddOn for WoW-Retail Copyright (C) 2025 Koenari
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--   You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.

-- This file is loaded from "LockoutPlanner.toc"
LOP.internalLog = {}
local L = MyLocalizationTable;
--Helper Functions-------------------------------------------------
function printf(s,...)
	print(s:format(...));
end
function LOP.printMessage(msg,...)
	local message = msg:format(...);
    if IsInGroup() and lopWantsToBroadcast then
        SendChatMessage(message, "PARTY");
    else
        print(message);
    end
end

function LOP.log(msg)
    table.insert(LOP.internalLog, msg);
end

function LOP.isPartOfAddon(name, addon)
    if addon == "all" then return true end
    return LOP.Database[name] == addon
end

function LOP.isInstanceType(wantedType, instanceIsRaid)
    if      wantedType == "raid"    then return instanceIsRaid
    elseif  wantedType == "dungeon" then return not instanceIsRaid
    end
    return true;
end

function LOP.getPrintableAddonName(shortName)
	local addon = LOP.knownAddOns[shortName]
	if addon ~= nil then return addon.name end
    return L["Unknown AddOn"] .. ": " .. shortName
end

function LOP.getPrintableInstanceType(shortName)
    local instanceType = LOP.knownInstanceTypes[shortName]
	if instanceType ~= nil then return instanceType.name end
    return L["Unknown Type"] ..": " .. shortName
end

function LOP.findKeyForAlternatives(searchTerm, dict)
	if searchTerm == nil then return false, "" end
	for key,value in next, dict do
		local tempCommand = nil
		if key == searchTerm then return true,key end
		for _, alt in ipairs(value.alternatives) do
			if alt == searchTerm then return true,key end
		end
		if tempCommand ~= nil then
			command = tempCommand
			commandFound = true
			break
		end
	end
	return false,""
end

--Command Handling-------------------------------------------------
function LOP.parseArguments(msg)
    argv = {}
    string.gsub(msg, "(%a+)", function (w)
      table.insert(argv, string.lower(w))
    end)
    command, instanceType, addonType = LOP.getDefaultArguments();
    --parse commands
    if argv[1] ~= nil then
		local found, tempCommand = LOP.findKeyForAlternatives(argv[1], LOP.knownCommands)
		if found then command = tempCommand else command = "help" end
		--early returning commands that use different argument structures
		if command == "help" or command == "log" or command == "opt" then
			return command, instanceType, addonType
		elseif command == "add" or command == "remove" then
			return command, string.sub(msg,string.len(argv[1])+2,-1), addonType
		end
    end

    --parse InstanceType
    if argv[2] ~= nil then
        local found, tempType = LOP.findKeyForAlternatives(argv[2], LOP.knownInstanceTypes)
		--print help on parse error
		if not found then return "help", instanceType, addonType end
		instanceType = tempType
    end

    --parse AddOn type
    if argv[3] ~= nil then
		local found, tempAddon = LOP.findKeyForAlternatives(argv[3], LOP.knownAddOns)
		--print help on parse error
		if not found then return "help", instanceType, addonType end
		addonType = tempAddon

    end
    return command, instanceType, addonType
end

function LOP.HandleSlash(args)
    cmd, instanceType, addonType = LOP.parseArguments(args);
    if cmd == "opt" then
        LOP.showOptionsDialog();
    elseif cmd == "show" then
        LOP.PrintSavedInstances(instanceType, addonType);
	elseif cmd == "planned" then
		LOP.printPlannedInstances(instanceType, addonType);
    elseif cmd == "remove" then
        LOP.deletePlannnedInstance(instanceType);
	elseif cmd == "add" then
        LOP.addPlannnedInstance(instanceType);
	elseif cmd == "log" then
        LOP.printLog();
    else
        LOP.printHelp();
    end
end

function LOP.getDefaultArguments()
    return lopDefaultCommand, lopDefaultInstanceType, lopDefaultAddon
end

function LOP.setDefaultArguments(arg_lopDefaultCommand, arg_lopDefaultInstanceType, arg_lopDefaultAddon)
	local foundCommand, tempCommand = LOP.findKeyForAlternatives(arg_lopDefaultCommand, LOP.knownCommands)
	if foundCommand then
		lopDefaultCommand = tempCommand
	else
		printf(L["LOP: %s is not a valid command. Option is ignored"],arg_lopDefaultCommand);
	end
	local foundInstance, tempInstance = LOP.findKeyForAlternatives(arg_lopDefaultInstanceType, LOP.knownInstanceTypes)
	if foundInstance then
		lopDefaultInstanceType = tempInstance
	else
		printf(L["LOP: %s is not a valid instance type. Option is ignored"],arg_lopDefaultInstanceType)
	end
	local foundAddon, tempAddon = LOP.findKeyForAlternatives(arg_lopDefaultAddon, LOP.knownAddOns)
	if foundAddon then
		lopDefaultAddon = tempAddon
	else
		print(L["LOP: %s is not a valid AddOn. Option is ignored"],arg_lopDefaultAddon)
	end
end

--Functionality----------------------------------------------------
function LOP.PrintSavedInstances(wantedType, wantedAddon)
    instances = GetNumSavedInstances();
    if instances > 0 and wantedType ~= "wb" then
        LOP.printMessage("== %s (%s / %s) ==",L["Saved Instances"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
        for instanceIdx = 1, instances do
            name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIdx);
            if locked == true and LOP.isInstanceType(wantedType, isRaid) and LOP.DB.isPArtOfAddOn(LOP.DB.getID(name), wantedAddon) then
                LOP.printInstance(GetSavedInstanceChatLink(instanceIdx), difficultyName, encounterProgress, numEncounters); 
            end
        end
    end
	if (wantedType == "wb" or wantedType == "all") then
		numBosses = GetNumSavedWorldBosses()
		LOP.printMessage("== %s (%s / %s) ==",L["Saved World Bosses"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
		if numBosses > 0 then
			for bossIdx = 1, numBosses do
				name, worldBossID, reset = GetSavedWorldBossInfo(bossIdx)
				if reset > 0 then
					resetSec = reset % 60
					reset = ((reset - resetSec)/60)
					resetMin = reset % 60
					reset = ((reset - resetMin)/60)
					resetHour = reset % 24
					reset = ((reset - resetHour)/24)
					resetDays = reset
					LOP.printWorldBoss(name, resetDays, resetHour, resetMin)
				end
			end
		else
			LOP.printMessage(L["No World Boss locks present"])
		end
	end
end
function LOP.showOptionsDialog()
    lopOptionsFrame:Show();
end
function LOP.printInstance(name,difficulty, encProgress, maxEnc)
    LOP.printMessage("%s (%s): %s / %s", name, difficultyName, encounterProgress, maxEnc);
end
function LOP.printWorldBoss(name, days, hours, minutes)
	LOP.printMessage("%s - %d %02d:%02d ", name, days, hours, minutes)
end
function LOP.printPlannedInstances(wantedType, wantedAddon)
	local savedInstances = {};
	instances = GetNumSavedInstances();
    if instances > 0 then
		for instanceIdx = 1, instances do
			name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIdx);
			savedInstances[LOP.DB.getID(name)] = instanceIdx;
		end
	end
	if wantedType ~= "wb" then
		printf("== %s (%s / %s) ==",L["Planned Instances"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
		for _, v in pairs(lopPlannedLockouts) do
			if LOP.DB.isPArtOfAddOn(v, wantedAddon) and LOP.DB.isOfType(v,wantedType) then
				if savedInstances[v] ~= nil then
					name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(savedInstances[v]);
					if locked then
						if (numEncounters == encounterProgress) then
							color = "|c0055ee55";
						else
							color = "|c00eeee55";
						end
				
						printf("%s%s (%s - %s) %s: %s [%s/%s] |r",
							color,
							GetSavedInstanceChatLink(savedInstances[v]),
							LOP.getPrintableAddonName(LOP.DB.getAddon(v)), 
							LOP.getPrintableInstanceType(LOP.DB.getType(v)),
							L["Done"],
							difficultyName,
							encounterProgress,
							numEncounters
							)
					else
						printf("|c00ee5555%s (%s - %s)",LOP.DB.getName(v), LOP.getPrintableAddonName(LOP.DB.getAddon(v)), LOP.getPrintableInstanceType(LOP.DB.getType(v)))
					end
				else 
					printf("|c00ee5555%s (%s - %s)",LOP.DB.getName(v), LOP.getPrintableAddonName(LOP.DB.getAddon(v)), LOP.getPrintableInstanceType(LOP.DB.getType(v)))
				end
			end
		end
	end
	if (wantedType == "all" or wantedType == "wb") then
		printf("== %s (%s / %s) ==",L["Planned Bosses"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
		local savedBosses = {};
		numBosses = GetNumSavedWorldBosses();
		if numBosses > 0 then
			for bossIdx = 1, numBosses do
				name, worldBossID, reset = GetSavedWorldBossInfo(bossIdx);
				savedBosses[LOP.DB.WB.getID(name)] = bossIdx;
			end
		end
		for v in pairs(lopPlannedBossLockouts) do
			if LOP.DB.WB.isPArtOfAddOn(v, wantedAddon) then
				if savedBosses[v] ~= nil then
					name, worldBossID, reset = GetSavedWorldBossInfo(savedBosses[v]);
					if reset > 0 then
						printf("%s%s (%s - %s) %s |r",
							"|c0055ee55",
							LOP.DB.WB.getName(v),
							LOP.getPrintableAddonName(LOP.DB.WB.getAddon(v)), 
							LOP.getPrintableInstanceType(LOP.DB.WB.getType(v)),
							L["Done"]
							)
					else
						printf("|c00ee5555%s (%s - %s)",LOP.DB.WB.getName(v), LOP.getPrintableAddonName(LOP.DB.WB.getAddon(v)), LOP.getPrintableInstanceType("wb"))
					end
				else 
					printf("|c00ee5555%s (%s - %s)",LOP.DB.WB.getName(v), LOP.getPrintableAddonName(LOP.DB.WB.getAddon(v)), LOP.getPrintableInstanceType("wb"))
				end
			end
		end
	end
end

function LOP.addPlannnedInstance(name)
	local instanceId = LOP.DB.getID(name)
	local bossID = LOP.DB.WB.getID(name)
	if(instanceId > 0) then
		lopPlannedLockouts[instanceId] = instanceId
		printf(L["%s<LOP> %s has been added to your planned instances"],"|c0055ee55", name)
	elseif bossID > 0 then
		lopPlannedBossLockouts[bossID] = bossID
		printf(L["%s<LOP> %s has been added to your planned world bosses"], "|c0055ee55", name)
	else
		printf(L["%s<LOP> %s is not a valid instance or world boss name"],"|c00ee5555", name)
	end
end

function LOP.deletePlannnedInstance(name)
	local instanceId = LOP.DB.getID(name)
	local bossID = LOP.DB.WB.getID(name)
	if(instanceId > 0) then
		lopPlannedLockouts[instanceId] = nil
		printf(L["%s<LOP> %s has been removed from your planned instances"],"|c0055ee55", name)
	elseif bossID > 0 then
		lopPlannedBossLockouts[bossID] = nil
		printf(L["%s<LOP> %s has been removed from your planned world bosses"],"|c0055ee55", name)
	else
		print(L["%s<LOP> %s is not a valid instance or world boss name"],"|c00ee5555", name)
	end
end

function LOP.printHelp()
	local availInstances = ""
	for key,_ in pairs(LOP.knownInstanceTypes) do
		availInstances = availInstances .. key .. ", "
	end
	availInstances = string.sub(availInstances,1,-3)
	local availAddons = ""
	for key,_ in pairs(LOP.knownAddOns) do
		availAddons = availAddons .. key .. ", "
	end
	availAddons = string.sub(availAddons,1,-3)
	printf(L["<LOP> Available commands"])
	print("<LOP> ------------------------------")
	printf("<LOP> /lo show <instanceType> <addOn>: %s", L["prints your instance locks with specified type belonging to specified addon"])
	printf([[<LOP> %s <instanceTypes>: %s]], L["available"], availInstances)

	printf([[<LOP> %s <addOns>: %s]], L["available"], availAddons)
	printf("<LOP> /lo planned <instanceType> <addOn>: %s", L["prints a list of all your planned instance lockouts and shows which are done"])
	printf("<LOP> /lo add <name>: %s", L["adds the instance or world boss with given name to the list of planned lockouts"])
	printf("<LOP> /lo remove <name>: %s", L["removes the instance or world boss with given name from the list of planned lockouts"])
	printf("<LOP> /lo help: %s", L["prints this message"])
	printf("<LOP> /lo: %s", L["executes command specified in options"])
	print("<LOP> ------------------------------")
end


function LOP.printLog()
    print("LOP Log start -----------------------")
    for i,v in ipairs(LOP.internalLog) do
        if v ~= nil then print(i,": ",v)
        else print(i,": tried to log nil")
        end
    end
    print("LOP Log end -----------------------")
end


-- Setup Functions-------------------------------------------------
function LOP.OnEvent(self, event, ...)
    if event == "ADDON_LOADED" and ... == "LockoutPlanner" then
        LOP.initializeCVars();
        LOP.registerCommand();
		LOP.initDB();
        self:UnregisterEvent("ADDON_LOADED");
    end
end

function LOP.initDB()
	if (lopSavedVars["DBRev"] == nil) then
		lopSavedVars["DBRev"] = 0
	end
	if (lopSavedVars["WBDBRev"] == nil) then
		lopSavedVars["WBDBRev"] = 0
	end
	LOP.DB.IDData = lopDBIDData
	LOP.DB.WB.IDData = lopDBWbIDData
	if lopSavedVars["DBRev"] < LOP.DB.revision or lopSavedVars["DBLocale"] ~= GetLocale() then
		LOP.DB.IDData = {}
		for i=0,10000 do
			v = LOP.DB.NameData[i]
			if v ~= nil then
				LOP.DB.IDData[v] = i
			end
		end
		lopSavedVars["DBRev"] = LOP.DB.revision
		lopDBIDData = LOP.DB.IDData
	end
	if lopSavedVars["WBDBRev"] < LOP.DB.WB.revision or lopSavedVars["DBLocale"] ~= GetLocale() then
		LOP.DB.WB.IDData = {}
		for i=0,150000 do
			v = LOP.DB.WB.NameData[i]
			if v ~= nil then
				LOP.DB.WB.IDData[v] = i
			end
		end
		lopSavedVars["WBDBRev"] = LOP.DB.WB.revision
		lopDBWbIDData = LOP.DB.WB.IDData
	end
	lopSavedVars["DBLocale"] = GetLocale()
end

function LOP.registerCommand()
    SLASH_LOCKOUTPLANNER2 = '/lop';
    SLASH_LOCKOUTPLANNER1 = '/lo';
    SlashCmdList['LOCKOUTPLANNER'] = LOP.HandleSlash;
    LOP.log("AddOn Loaded");
end

function LOP.initializeCVars()
    LOP.log("Init CVars")
	if(lopDefaultCommand == nil) then lopDefaultCommand = "show" end
	if(lopDefaultInstanceType == nil) then lopDefaultInstanceType = "all" end
	if(lopDefaultAddon == nil) then lopDefaultAddon = "all" end
	if(lopPlannedLockouts == nil) then lopPlannedLockouts = {} end
	if (lopPlannedBossLockouts == nil) then lopPlannedBossLockouts = {} end
	if(lopWantsToBroadcast == nil) then lopWantsToBroadcast = true end
	if(lopSavedVars == nil) then lopSavedVars = {} end
	if(lopDBIDData == nil) then lopDBIDData = {} end
	if(lopDBWbIDData == nil) then lopDBWbIDData = {} end
end

--Executed Code------------------------------------
LOP.mainFrame = CreateFrame("FRAME", "MyInstanceLocks");
LOP.mainFrame:RegisterEvent("ADDON_LOADED");
LOP.mainFrame:SetScript("OnEvent", LOP.OnEvent);