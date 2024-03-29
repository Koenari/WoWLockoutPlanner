--  Lockout Planner AddOn for WoW-Retail Copyright (C) 2024  Koenari
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

-- This file is loaded from "LockoutPlanner.toc
LOP = {}
LOP.DB = {}
LOP.DB.WB = {}

function LOP.DB.isPArtOfAddOn(id, wantedAddOn)
	if(wantedAddOn == "all") then return true end
	return (LOP.DB.AddonData[id] == wantedAddOn)
end

function LOP.DB.isOfType(id, wantedType)
	if(wantedType == "all") then return true end
	return (LOP.DB.TypeData[id] == wantedType)
end

function LOP.DB.getAddon(id)
	if LOP.DB.AddonData[id] ~= nil then
		return LOP.DB.AddonData[id]
	end
	return "unknown"
end

function LOP.DB.getType(id)
	if LOP.DB.TypeData[id] ~= nil then
		return LOP.DB.TypeData[id]
	end
	return "unknown"
end

function LOP.DB.getName(id)
	if LOP.DB.NameData[id] ~= nil then
		return LOP.DB.NameData[id]
	end
	return "unknown"
end

function LOP.DB.getID(name)
	returnValue =  LOP.DB.IDData[name]
	if returnValue == nil then
		return 0
	end
	return returnValue
end

-- World Bosses
function LOP.DB.WB.isPArtOfAddOn(id, wantedAddOn)
	if(wantedAddOn == "all") then return true end
	return (LOP.DB.WB.AddonData[id] == wantedAddOn)
end

function LOP.DB.WB.isOfType(id, wantedType)
	if(wantedType == "all" or wantedType == "wb") then return true end
	return false
end

function LOP.DB.WB.getType(id)
	return "wb"
end

function LOP.DB.WB.getAddon(id)
	return LOP.DB.WB.AddonData[id]
end

function LOP.DB.WB.getName(id)
	return LOP.DB.WB.NameData[id]
end

function LOP.DB.WB.getID(name)
	returnValue =  LOP.DB.WB.IDData[name]
	if returnValue == nil then
		return 0
	end
	return returnValue
end