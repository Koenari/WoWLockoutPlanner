--  Lockout Planner AddOn for WoW-Retail Copyright (C) 2020  Patrick Hahn (Koenari)
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
LOP.allowedCommands = {}
LOP.allowedInstanceTypes = {}
LOP.allowedAddOns = {}
local L = MyLocalizationTable;
--Helper Functions-------------------------------------------------
function printf(s,...)
	print(s:format(...));
end
function LOP.printMessage(msg,...)
	local message = msg:format(...);
    if IsInGroup() then
        SendChatMessage(message, "PARTY");
    else
        print(message);
    end
end

function LOP.log(msg)
    table.insert(LOP.internalLog, msg);
	print(msg);
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
    if      shortName == "bfa"  then return "Battle for Azeroth"
    elseif  shortName == "all"  then return "All AddOns"
    elseif  shortName == "classic"  then return "Classic"
    elseif  shortName == "bc"  then return "Burning Crusade"
    elseif  shortName == "wotlk"  then return "Wrath of the Lich King"
    elseif  shortName == "cata"  then return "Cataclysm"
    elseif  shortName == "mop"  then return "Mists of Pandaria"
    elseif  shortName == "wod"  then return "Warlords of Draenor"
    elseif  shortName == "legion"  then return "Legion"
    end
    return "Unknown AddOn: " .. shortName
end

function LOP.getPrintableInstanceType(instanceType)
    if      instanceType == "raid"      then return "Raids"
    elseif  instanceType == "dungeon"   then return "Dungeon"
    elseif  instanceType == "all"       then return "All Types"
    end
    return L["Unknown Type"] ..": " .. shortName
end

function LOP.Set(list)
	local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function LOP.isPartOfSet(entry, set)
	return (set[entry] == true)
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
        if  argv[1] == "help" then
            return "help", instanceType, addonType
        elseif  argv[1] == "show" then
            command = "show"
		elseif  argv[1] == "planned" then
            command = "planned"
		elseif  argv[1] == "add" then
            return "add", string.sub(msg,5,-1), addonType
		elseif  argv[1] == "remove" then
            return "remove", string.sub(msg,8,-1), addonType
		elseif  argv[1] == "opt" then
            return "opt", instanceType, addonType
        elseif  argv[1] == "log" then
            return "log", instanceType, addonType
        else
            command = "help"
        end
    end
    --parse InstanceType
    if argv[2] ~= nil then
         
        if argv[2] == "raid" or argv[2] == "r" or argv[2] == "raids" then
            instanceType = "raid"
        elseif argv[2] == "dungeon" or argv[2] == "d" or argv[2] == "mythic" or argv[2] == "m" or argv[2] == "m0" then
            instanceType = "dungeon"
        elseif argv[2] == "all" or argv[2] == "a" or argv[2] == "everything" or argv[2] == "any" then
            instanceType = "all"
        else
            return "help", instanceType, addonType
        end
    end
    
    --parse addon type
    if argv[3] ~= nil then
        if argv[3] == "bfa" or argv[3] == "current" or argv[3] == "latest" then
            addonType = "bfa"
        elseif argv[3] == "all" or argv[3] == "a" or argv[3] == "any" then
            addonType = "all"
        elseif argv[3] == "classic" or argv[3] ==  "wow" or argv[3] == "c" then
            addonType = "classic"
        elseif argv[3] == "bc" then
            addonType = "bc"
        elseif argv[3] == "wotlk" or argv[3] == "lk" or argv[3] == "lichking" then
            addonType = "wotlk"
        elseif argv[3] == "cata" or argv[3] == "cataclysm" then
            addonType = "cata"
        elseif argv[3] == "mop" or argv[3] == "pandaria" then
            addonType = "mop"
        elseif argv[3] == "wod" or argv[3] == "draenor" then
            addonType = "wod"
        elseif argv[3] == "legion" or argv[3] == "l" then
            addonType = "legion"
        else
            return "help", instanceType, addonType
        end
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
	if(arg_lopDefaultCommand ~= nil) then
		if LOP.isPartOfSet(arg_lopDefaultCommand, LOP.allowedCommands) then
			lopDefaultCommand = arg_lopDefaultCommand
		else
			printf(L["LOP: %s is not a valid command. Option is ignored"],arg_lopDefaultCommand);
		end
	end
	if(arg_lopDefaultInstanceType ~= nil) then
		if LOP.isPartOfSet(arg_lopDefaultInstanceType, LOP.allowedInstanceTypes) then
			lopDefaultInstanceType = arg_lopDefaultInstanceType
		else
			printf(L["LOP: %s is not a valid instance type. Option is ignored"],arg_lopDefaultInstanceType)
		end
	end
		if(arg_lopDefaultAddon ~= nil) then
		if LOP.isPartOfSet(arg_lopDefaultAddon, LOP.allowedAddOns) then
			lopDefaultAddon = arg_lopDefaultAddon
		else
			print(L["LOP: %s is not a valid addon. Option is ignored"],arg_lopDefaultAddon)
		end
	end
end
--Functionality----------------------------------------------------
function LOP.PrintSavedInstances(wantedType, wantedAddon)
    instances = GetNumSavedInstances();
    if instances > 0 then
        LOP.printMessage("== %s (%s / %s) ==",L["Saved Instances"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
        
        for instanceIdx = 1, instances do
            name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIdx);
            if locked == true and LOP.isInstanceType(wantedType, isRaid) and LOP.DB.isPArtOfAddOn(LOP.DB.getID(name), wantedAddon) then
                LOP.printInstance(name, difficultyName, encounterProgress, numEncounters); 
            end
        end
    end
end
function LOP.showOptionsDialog()
    lopOptionsFrame:Show();
end
function LOP.printInstance(name,difficulty, encProgress, maxEnc)
    LOP.printMessage("%s (%s): %s / %s", name, difficultyName, encounterProgress, numEncounters);
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
	LOP.printMessage("== %s (%s / %s) ==",L["Planned Instances"],LOP.getPrintableInstanceType(wantedType),LOP.getPrintableAddonName(wantedAddon));
	for v in pairs(lopPlannedLockouts) do
		if LOP.DB.isPArtOfAddOn(v, wantedAddon) and LOP.DB.isOfType(v,wantedType) then
			if savedInstances[v] ~= nil then
				name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(savedInstances[v]);
				if locked then
					if (numEncounters == encounterProgress) then
						color = "|c0055ee55";
					else
						color = "|c00eeee55";
					end
				
					LOP.printMessage("%s%s (%s - %s) Done: %s [%s/%s] |r",
						color,
						LOP.DB.getName(v),
						LOP.getPrintableAddonName(LOP.DB.getAddon(v)), 
						LOP.getPrintableInstanceType(LOP.DB.getType(v)),
						difficultyName,
						encounterProgress,
						numEncounters					
						)
				else
					LOP.printMessage("|c00ee5555%s (%s - %s)",LOP.DB.getName(v), LOP.getPrintableAddonName(LOP.DB.getAddon(v)), LOP.getPrintableInstanceType(LOP.DB.getType(v)))
				end
			end
		end
	end
end
function LOP.addPlannnedInstance(name)
	local id = LOP.DB.getID(name)
	if(id > 0) then
		lopPlannedLockouts[id] = id
		print(string.format(L["|c0055ee55<LOP> %s has been added to your planned instances"], name))
	else
		print(string.format(L["|c00ee5555<LOP> %s is not a valid instance name"], name))
	end
end
function LOP.deletePlannnedInstance(name)
	local id = LOP.DB.getID(name)
	if(id > 0) then
		lopPlannedLockouts[id] = nil
		print(string.format(L["|c0055ee55<LOP> %s has been removed from your planned instances"], name))
	else
		print(string.format(L["|c00ee5555<LOP> %s is not a valid instance name"], name))
	end
end
function LOP.printHelp()
	print("<LOP> Available Slash commands")
	print("<LOP> ------------------------------")
	print("<LOP> /lo show <instanceType> <addOn>: prints your instance locks with specified type belonging to specified addon")
	print([[<LOP> available <instanceTypes>: "raid", "dungeon", "all"]])
	print([[<LOP> available <addOns>: "all","classic","bc","wotlk","cata","mop","wod","legion","bfa"]])
	print("<LOP> /lo planned <instanceType> <addOn>: prints a list of all your planned instance lockouts and shows which are done")
	print("<LOP> /lo add <instance Name>: adds the instance with given name to the list of planned instances")
	print("<LOP> /lo remove <instance Name>: removes the instance with given name from the list of planned instances")
	print("<LOP> /lo help: prints this message")
	print("<LOP> /lo: executes command specified in options")
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
		LOP.initializeAllowedLists();
        LOP.registerCommand();
		LOP.initDB();
        self:UnregisterEvent("ADDON_LOADED");
    end
end

function LOP.initDB()
	for i=0,2500 do
		v = LOP.DB.NameData[i]
		if v ~= nil then
			LOP.DB.IDData[v] = i
		end
	end
end

function LOP.registerCommand()
    SLASH_LOCKOUTPLANNER2 = '/lop';
    SLASH_LOCKOUTPLANNER1 = '/lo';
    SlashCmdList['LOCKOUTPLANNER'] = LOP.HandleSlash;
    LOP.log("AddOn Loaded");
end

function LOP.initializeCVars()
    LOP.log("Init CVars")
	if(lopDefaultCommand == nil) then 
		lopDefaultCommand = "show";
	end
	if(lopDefaultInstanceType == nil) then 
		lopDefaultInstanceType = "all";
	end
	if(lopDefaultAddon == nil) then 
		lopDefaultAddon = "all";
	end
	if(lopPlannedLockouts == nil) then 
		lopPlannedLockouts = {};
	end

end

function LOP.initializeAllowedLists()
	LOP.allowedCommands			= LOP.Set{"show","opt","help","log", "planned", "add-planned", "remove-planned"}
	LOP.allowedInstanceTypes	= LOP.Set{"raid", "dungeon", "all"}
	LOP.allowedAddOns			= LOP.Set{"all","classic","bc","wotlk","cata","mop","wod","legion","bfa"}
end
--Executed Code------------------------------------
LOP.mainFrame = CreateFrame("FRAME", "MyInstanceLocks");
LOP.mainFrame:RegisterEvent("ADDON_LOADED");
LOP.mainFrame:SetScript("OnEvent", LOP.OnEvent);