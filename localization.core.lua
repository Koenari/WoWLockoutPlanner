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
local addonName, L = ...; -- Let's use the private table passed to every .lua file to store our locale
local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
	if not(GetLocale() == "enUS") then
		print("Localization error: String '",key,"' is missing for locale '",GetLocale(),"'!");
	end
 return key;
end
MyLocalizationTable = setmetatable(L, {__index=defaultFunc});