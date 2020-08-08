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
LOP = {}
LOP.internalLog = {}
LOP.allowedCommands = {}
LOP.allowedInstanceTypes = {}
LOP.allowedAddOns = {}
--Helper Functions-------------------------------------------------
function LOP.printMessage(msg)
    if IsInGroup() then
        SendChatMessage(msg, "PARTY");
    else
        print(msg);
    end
end

function LOP.log(msg)
    table.insert(LOP.internalLog, msg)
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
    return "Unknown Type: " .. shortName
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
        elseif  argv[1] == "log" then
            return "log", instanceType, addonType
        else
            command = "show"
            argv[3] = argv[2]
            argv[2] = argv[1]
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
    
    if cmd == "show" then
        LOP.PrintSavedInstances(instanceType, addonType);
    elseif cmd == "log" then
        LOP.printLog();
    else
        LOP.printHelp();
    end
end
function LOP.getDefaultArguments()
    return milDefaultCommand, milDefaultInstanceType, milDefaultAddon
end
function LOP.setDefaultArguments(arg_milDefaultCommand, arg_milDefaultInstanceType, arg_milDefaultAddon)
	if(arg_milDefaultCommand ~= nil) then
		if LOP.isPartOfSet(arg_milDefaultCommand, LOP.allowedCommands) then
			milDefaultCommand = arg_milDefaultCommand
		else
			print("MIL: " .. arg_milDefaultCommand .. " is not a valid command. Option is ignored")
		end
	end
	if(arg_milDefaultInstanceType ~= nil) then
		if LOP.isPartOfSet(arg_milDefaultInstanceType, LOP.allowedInstanceTypes) then
			milDefaultInstanceType = arg_milDefaultInstanceType
		else
			print("MIL: " .. arg_milDefaultInstanceType .. " is not a valid instance type. Option is ignored")
		end
	end
		if(arg_milDefaultAddon ~= nil) then
		if LOP.isPartOfSet(arg_milDefaultAddon, LOP.allowedAddOns) then
			milDefaultAddon = arg_milDefaultAddon
		else
			print("MIL: " .. arg_milDefaultAddon .. " is not a valid addon. Option is ignored")
		end
	end

end
--Functionality----------------------------------------------------
function LOP.PrintSavedInstances(wantedType, wantedAddon)
    instances = GetNumSavedInstances();
    if instances > 0 then
        LOP.printMessage("== Saved Instances (" .. LOP.getPrintableInstanceType(wantedType) .. " / " .. LOP.getPrintableAddonName(wantedAddon) .. ") ==");
        
        for instanceIdx = 1, instances do
            name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIdx);
            if locked == true and LOP.isInstanceType(wantedType, isRaid) and LOP.isPartOfAddon(name, wantedAddon) then
                LOP.printInstance(name, difficultyName, encounterProgress, numEncounters); 
            end
        end
    end
end
function LOP.printInstance(name,difficulty, encProgress, maxEnc)
    message = string.format("%s (%s): %s / %s", name, difficultyName, encounterProgress, numEncounters);
    LOP.printMessage(message);                
end
function LOP.printHelp()
	print("<MIL> Available Slash commands")
	print("<MIL> ------------------------------")
	print("<MIL> /lo show <instanceType> <addOn>: prints your instance locks with specified type belonging to specified addon")
	print([[<MIL> available <instanceTypes>: "raid", "dungeon", "all"]])
	print([[<MIL> available <addOns>: "all","classic","bc","wotlk","cata","mop","wod","legion","bfa"]])
	print("<MIL> /lo help: prints this message")
	print("<MIL> /lo: executes command specified in options")
end

function LOP.showOptionsDialog()
    milOptionsFrame:Show();
end

function LOP.printLog()
    print("MIL Log start -----------------------")
    for i,v in ipairs(LOP.internalLog) do
        if v ~= nil then print(i,": ",v)
        else print(i,": tried to log nil")
        end
    end
    
    print("MIL Log end -----------------------")
end


-- Setup Functions-------------------------------------------------
function LOP.OnEvent(self, event, ...)
    if event == "ADDON_LOADED" and ... == "MyInstanceLocks" then
        if(milDefaultCommand == nil) then
            LOP.initializeCVars();
        end
		LOP.initializeAllowedLists();
        LOP.registerCommand();
        self:UnregisterEvent("ADDON_LOADED");
    end
end

function LOP.registerCommand()
    SLASH_MYLOCKOUTS1 = '/lockouts';
    SLASH_MYLOCKOUTS1 = '/lo';
    SlashCmdList['MYLOCKOUTS'] = LOP.HandleSlash;
    LOP.log("AddOn Loaded");
end

function LOP.initializeCVars()
    LOP.log("Init CVars")
    milDefaultCommand = "show";
    milDefaultInstanceType = "all";
    milDefaultAddon = "all";

end

function LOP.initializeAllowedLists()
	LOP.allowedCommands			= LOP.Set{"show","opt","help","log"}
	LOP.allowedInstanceTypes	= LOP.Set{"raid", "dungeon", "all"}
	LOP.allowedAddOns			= LOP.Set{"all","classic","bc","wotlk","cata","mop","wod","legion","bfa"}
end
--Executed Code------------------------------------
LOP.mainFrame = CreateFrame("FRAME", "MyInstanceLocks");
LOP.mainFrame:RegisterEvent("ADDON_LOADED");
LOP.mainFrame:SetScript("OnEvent", LOP.OnEvent);