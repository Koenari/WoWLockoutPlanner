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
--    along with this program.  If not, see <http://www.gnu.org/licenses/>

LOP.knownCommands = {
	["show"] = {
		alternatives = {}
	},
	["opt"] = {
		alternatives = {"options","config"}
	},
	["help"] = {
		alternatives = {}
	},
	["log"] = {
		alternatives = {}
	},
	["planned"] = {
		alternatives = {}
	},
	["add"] = {
		alternatives = {"add-planned"}
	},
	["remove"] = {
		alternatives = {"remove-planned"}
	}
}
LOP.knownInstanceTypes = {
	["raid"] = {
		name = "Raid",
		alternatives = {"r","raids"}
	},
	["dungeon"] = {
		name = "Dungeon",
		alternatives = {"d","mythic","m","m0"}
	},
	["wb"] = {
		name = "World Boss",
		alternatives = {"boss", "worldboss"}
	},
	["all"] = {
		name = "All Types",
		alternatives = {"a","any","everything"}
	}
}
	

LOP.knownAddOns =	{
	["all"] = {
		name = "All AddOns",
		alternatives = {"a","any","everything"}
	},
	["classic"] = {
		name = "Classic",
		alternatives = {"wow","c"}
	},
	["bc"] = {
		name = "Burning Crusade",
		alternatives = {}
	},
	["wotlk"] = {
		name = "Wrath of the Lich King",
		alternatives = {"lichking"}
	},
	["cata"] = {
		name = "Cataclysm",
		alternatives = {"cataclysm"}
	},
	["mop"] = {
		name = "Mists of Pandaria",
		alternatives = {"pandaria"}
	},
	["wod"] = {
		name = "Warlords of Draenor",
		alternatives = {"draenor"}
	},
	["legion"] = {
		name = "Legion",
		alternatives = {"lg","leg"}
	},
	["bfa"] = {
		name = "Battle for Azeroth",
		alternatives = {}
	},
	["sl"] = {
		name = "Shadowlands",
		alternatives = {"shadowlands"}
	},
	["df"] = {
		name = "Dragonflight",
		alternatives = {"dragonflight"}
	},
	["tww"] = {
		name = "The War Within",
		alternatives = {"warwithin","cur","current","latest"}
	},
	["mn"] = {
		name = "Midnight",
		alternatives = {"midnight","beta"}
	},
}