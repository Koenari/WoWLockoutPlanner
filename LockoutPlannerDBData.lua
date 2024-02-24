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
local L = MyLocalizationTable;

-- Increase this on every change to rebuild stuff
LOP.DB.revision = 5

--Will be filled out dynamically
LOP.DB.IDData = {}



LOP.DB.AddonData = {}
LOP.DB.AddonData[0] = "unknown"
LOP.DB.AddonData[48] = "classic"
LOP.DB.AddonData[230] = "classic"
LOP.DB.AddonData[229] = "classic"
LOP.DB.AddonData[429] = "classic"
LOP.DB.AddonData[90] = "classic"
LOP.DB.AddonData[349] = "classic"
LOP.DB.AddonData[389] = "classic"
LOP.DB.AddonData[129] = "classic"
LOP.DB.AddonData[47] = "classic"
LOP.DB.AddonData[1001] = "classic"
LOP.DB.AddonData[1004] = "classic"
LOP.DB.AddonData[1007] = "classic"
LOP.DB.AddonData[33] = "classic"
LOP.DB.AddonData[329] = "classic"
LOP.DB.AddonData[36] = "classic"
LOP.DB.AddonData[34] = "classic"
LOP.DB.AddonData[109] = "classic"
LOP.DB.AddonData[70] = "classic"
LOP.DB.AddonData[43] = "classic"
LOP.DB.AddonData[209] = "classic"
LOP.DB.AddonData[558] = "bc"
LOP.DB.AddonData[543] = "bc"
LOP.DB.AddonData[585] = "bc"
LOP.DB.AddonData[557] = "bc"
LOP.DB.AddonData[560] = "bc"
LOP.DB.AddonData[556] = "bc"
LOP.DB.AddonData[555] = "bc"
LOP.DB.AddonData[552] = "bc"
LOP.DB.AddonData[269] = "bc"
LOP.DB.AddonData[542] = "bc"
LOP.DB.AddonData[553] = "bc"
LOP.DB.AddonData[554] = "bc"
LOP.DB.AddonData[540] = "bc"
LOP.DB.AddonData[547] = "bc"
LOP.DB.AddonData[545] = "bc"
LOP.DB.AddonData[546] = "bc"
LOP.DB.AddonData[619] = "wotlk"
LOP.DB.AddonData[601] = "wotlk"
LOP.DB.AddonData[600] = "wotlk"
LOP.DB.AddonData[604] = "wotlk"
LOP.DB.AddonData[602] = "wotlk"
LOP.DB.AddonData[668] = "wotlk"
LOP.DB.AddonData[599] = "wotlk"
LOP.DB.AddonData[658] = "wotlk"
LOP.DB.AddonData[595] = "wotlk"
LOP.DB.AddonData[632] = "wotlk"
LOP.DB.AddonData[576] = "wotlk"
LOP.DB.AddonData[578] = "wotlk"
LOP.DB.AddonData[608] = "wotlk"
LOP.DB.AddonData[650] = "wotlk"
LOP.DB.AddonData[574] = "wotlk"
LOP.DB.AddonData[575] = "wotlk"
LOP.DB.AddonData[645] = "cata"
LOP.DB.AddonData[938] = "cata"
LOP.DB.AddonData[670] = "cata"
LOP.DB.AddonData[644] = "cata"
LOP.DB.AddonData[940] = "cata"
LOP.DB.AddonData[755] = "cata"
LOP.DB.AddonData[725] = "cata"
LOP.DB.AddonData[657] = "cata"
LOP.DB.AddonData[643] = "cata"
LOP.DB.AddonData[939] = "cata"
LOP.DB.AddonData[568] = "cata"
LOP.DB.AddonData[859] = "cata"
LOP.DB.AddonData[962] = "mop"
LOP.DB.AddonData[994] = "mop"
LOP.DB.AddonData[959] = "mop"
LOP.DB.AddonData[1011] = "mop"
LOP.DB.AddonData[961] = "mop"
LOP.DB.AddonData[960] = "mop"
LOP.DB.AddonData[1182] = "wod"
LOP.DB.AddonData[1175] = "wod"
LOP.DB.AddonData[1208] = "wod"
LOP.DB.AddonData[1195] = "wod"
LOP.DB.AddonData[1176] = "wod"
LOP.DB.AddonData[1209] = "wod"
LOP.DB.AddonData[1279] = "wod"
LOP.DB.AddonData[1358] = "wod"
LOP.DB.AddonData[1501] = "legion"
LOP.DB.AddonData[1677] = "legion"
LOP.DB.AddonData[1571] = "legion"
LOP.DB.AddonData[1466] = "legion"
LOP.DB.AddonData[1456] = "legion"
LOP.DB.AddonData[1477] = "legion"
LOP.DB.AddonData[1492] = "legion"
LOP.DB.AddonData[1458] = "legion"
LOP.DB.AddonData[1651] = "legion"
LOP.DB.AddonData[1753] = "legion"
LOP.DB.AddonData[1516] = "legion"
LOP.DB.AddonData[1493] = "legion"
LOP.DB.AddonData[1544] = "legion"
LOP.DB.AddonData[1763] = "bfa"
LOP.DB.AddonData[1754] = "bfa"
LOP.DB.AddonData[1762] = "bfa"
LOP.DB.AddonData[1864] = "bfa"
LOP.DB.AddonData[1822] = "bfa"
LOP.DB.AddonData[1877] = "bfa"
LOP.DB.AddonData[1594] = "bfa"
LOP.DB.AddonData[1841] = "bfa"
LOP.DB.AddonData[1771] = "bfa"
LOP.DB.AddonData[1862] = "bfa"
LOP.DB.AddonData[2097] = "bfa"
LOP.DB.AddonData[469] = "classic"
LOP.DB.AddonData[409] = "classic"
LOP.DB.AddonData[509] = "classic"
LOP.DB.AddonData[531] = "classic"
LOP.DB.AddonData[564] = "bc"
LOP.DB.AddonData[565] = "bc"
LOP.DB.AddonData[534] = "bc"
LOP.DB.AddonData[532] = "bc"
LOP.DB.AddonData[544] = "bc"
LOP.DB.AddonData[548] = "bc"
LOP.DB.AddonData[580] = "bc"
LOP.DB.AddonData[550] = "bc"
LOP.DB.AddonData[631] = "wotlk"
LOP.DB.AddonData[533] = "wotlk"
LOP.DB.AddonData[249] = "wotlk"
LOP.DB.AddonData[616] = "wotlk"
LOP.DB.AddonData[615] = "wotlk"
LOP.DB.AddonData[724] = "wotlk"
LOP.DB.AddonData[649] = "wotlk"
LOP.DB.AddonData[603] = "wotlk"
LOP.DB.AddonData[624] = "wotlk"
LOP.DB.AddonData[757] = "cata"
LOP.DB.AddonData[669] = "cata"
LOP.DB.AddonData[967] = "cata"
LOP.DB.AddonData[720] = "cata"
LOP.DB.AddonData[671] = "cata"
LOP.DB.AddonData[754] = "cata"
LOP.DB.AddonData[1009] = "mop"
LOP.DB.AddonData[1008] = "mop"
LOP.DB.AddonData[1136] = "mop"
LOP.DB.AddonData[996] = "mop"
LOP.DB.AddonData[1098] = "mop"
LOP.DB.AddonData[1228] = "wod"
LOP.DB.AddonData[1205] = "wod"
LOP.DB.AddonData[1448] = "wod"
LOP.DB.AddonData[1520] = "legion"
LOP.DB.AddonData[1648] = "legion"
LOP.DB.AddonData[1530] = "legion"
LOP.DB.AddonData[1676] = "legion"
LOP.DB.AddonData[1712] = "legion"
LOP.DB.AddonData[1861] = "bfa"
LOP.DB.AddonData[2070] = "bfa"
LOP.DB.AddonData[2096] = "bfa"
LOP.DB.AddonData[2164] = "bfa"
LOP.DB.AddonData[2217] = "bfa"
LOP.DB.AddonData[2284] = "sl"
LOP.DB.AddonData[2285] = "sl"
LOP.DB.AddonData[2286] = "sl"
LOP.DB.AddonData[2287] = "sl"
LOP.DB.AddonData[2289] = "sl"
LOP.DB.AddonData[2290] = "sl"
LOP.DB.AddonData[2291] = "sl"
LOP.DB.AddonData[2293] = "sl"
LOP.DB.AddonData[2296] = "sl"
LOP.DB.AddonData[2441] = "sl"
LOP.DB.AddonData[2450] = "sl"
LOP.DB.AddonData[2481] = "sl"
LOP.DB.AddonData[2526] = "df"
LOP.DB.AddonData[2520] = "df"
LOP.DB.AddonData[2527] = "df"
LOP.DB.AddonData[2519] = "df"
LOP.DB.AddonData[2521] = "df"
LOP.DB.AddonData[2515] = "df"
LOP.DB.AddonData[2516] = "df"
LOP.DB.AddonData[2451] = "df"
LOP.DB.AddonData[2574] = "df"
LOP.DB.AddonData[2522] = "df"
LOP.DB.AddonData[2569] = "df"

LOP.DB.TypeData = {}
LOP.DB.TypeData[0] = "unknown"
LOP.DB.TypeData[48] = "dungeon"
LOP.DB.TypeData[230] = "dungeon"
LOP.DB.TypeData[229] = "dungeon"
LOP.DB.TypeData[429] = "dungeon"
LOP.DB.TypeData[90] = "dungeon"
LOP.DB.TypeData[349] = "dungeon"
LOP.DB.TypeData[389] = "dungeon"
LOP.DB.TypeData[129] = "dungeon"
LOP.DB.TypeData[47] = "dungeon"
LOP.DB.TypeData[1001] = "dungeon"
LOP.DB.TypeData[1004] = "dungeon"
LOP.DB.TypeData[1007] = "dungeon"
LOP.DB.TypeData[33] = "dungeon"
LOP.DB.TypeData[329] = "dungeon"
LOP.DB.TypeData[36] = "dungeon"
LOP.DB.TypeData[34] = "dungeon"
LOP.DB.TypeData[109] = "dungeon"
LOP.DB.TypeData[70] = "dungeon"
LOP.DB.TypeData[43] = "dungeon"
LOP.DB.TypeData[209] = "dungeon"
LOP.DB.TypeData[558] = "dungeon"
LOP.DB.TypeData[543] = "dungeon"
LOP.DB.TypeData[585] = "dungeon"
LOP.DB.TypeData[557] = "dungeon"
LOP.DB.TypeData[560] = "dungeon"
LOP.DB.TypeData[556] = "dungeon"
LOP.DB.TypeData[555] = "dungeon"
LOP.DB.TypeData[552] = "dungeon"
LOP.DB.TypeData[269] = "dungeon"
LOP.DB.TypeData[542] = "dungeon"
LOP.DB.TypeData[553] = "dungeon"
LOP.DB.TypeData[554] = "dungeon"
LOP.DB.TypeData[540] = "dungeon"
LOP.DB.TypeData[547] = "dungeon"
LOP.DB.TypeData[545] = "dungeon"
LOP.DB.TypeData[546] = "dungeon"
LOP.DB.TypeData[619] = "dungeon"
LOP.DB.TypeData[601] = "dungeon"
LOP.DB.TypeData[600] = "dungeon"
LOP.DB.TypeData[604] = "dungeon"
LOP.DB.TypeData[602] = "dungeon"
LOP.DB.TypeData[668] = "dungeon"
LOP.DB.TypeData[599] = "dungeon"
LOP.DB.TypeData[658] = "dungeon"
LOP.DB.TypeData[595] = "dungeon"
LOP.DB.TypeData[632] = "dungeon"
LOP.DB.TypeData[576] = "dungeon"
LOP.DB.TypeData[578] = "dungeon"
LOP.DB.TypeData[608] = "dungeon"
LOP.DB.TypeData[650] = "dungeon"
LOP.DB.TypeData[574] = "dungeon"
LOP.DB.TypeData[575] = "dungeon"
LOP.DB.TypeData[645] = "dungeon"
LOP.DB.TypeData[938] = "dungeon"
LOP.DB.TypeData[670] = "dungeon"
LOP.DB.TypeData[644] = "dungeon"
LOP.DB.TypeData[940] = "dungeon"
LOP.DB.TypeData[755] = "dungeon"
LOP.DB.TypeData[725] = "dungeon"
LOP.DB.TypeData[657] = "dungeon"
LOP.DB.TypeData[643] = "dungeon"
LOP.DB.TypeData[939] = "dungeon"
LOP.DB.TypeData[568] = "dungeon"
LOP.DB.TypeData[859] = "dungeon"
LOP.DB.TypeData[962] = "dungeon"
LOP.DB.TypeData[994] = "dungeon"
LOP.DB.TypeData[959] = "dungeon"
LOP.DB.TypeData[1011] = "dungeon"
LOP.DB.TypeData[961] = "dungeon"
LOP.DB.TypeData[960] = "dungeon"
LOP.DB.TypeData[1182] = "dungeon"
LOP.DB.TypeData[1175] = "dungeon"
LOP.DB.TypeData[1208] = "dungeon"
LOP.DB.TypeData[1195] = "dungeon"
LOP.DB.TypeData[1176] = "dungeon"
LOP.DB.TypeData[1209] = "dungeon"
LOP.DB.TypeData[1279] = "dungeon"
LOP.DB.TypeData[1358] = "dungeon"
LOP.DB.TypeData[1501] = "dungeon"
LOP.DB.TypeData[1677] = "dungeon"
LOP.DB.TypeData[1571] = "dungeon"
LOP.DB.TypeData[1466] = "dungeon"
LOP.DB.TypeData[1456] = "dungeon"
LOP.DB.TypeData[1477] = "dungeon"
LOP.DB.TypeData[1492] = "dungeon"
LOP.DB.TypeData[1458] = "dungeon"
LOP.DB.TypeData[1651] = "dungeon"
LOP.DB.TypeData[1753] = "dungeon"
LOP.DB.TypeData[1516] = "dungeon"
LOP.DB.TypeData[1493] = "dungeon"
LOP.DB.TypeData[1544] = "dungeon"
LOP.DB.TypeData[1763] = "dungeon"
LOP.DB.TypeData[1754] = "dungeon"
LOP.DB.TypeData[1762] = "dungeon"
LOP.DB.TypeData[1864] = "dungeon"
LOP.DB.TypeData[1822] = "dungeon"
LOP.DB.TypeData[1877] = "dungeon"
LOP.DB.TypeData[1594] = "dungeon"
LOP.DB.TypeData[1841] = "dungeon"
LOP.DB.TypeData[1771] = "dungeon"
LOP.DB.TypeData[1862] = "dungeon"
LOP.DB.TypeData[2097] = "dungeon"
LOP.DB.TypeData[469] = "raid"
LOP.DB.TypeData[409] = "raid"
LOP.DB.TypeData[509] = "raid"
LOP.DB.TypeData[531] = "raid"
LOP.DB.TypeData[564] = "raid"
LOP.DB.TypeData[565] = "raid"
LOP.DB.TypeData[534] = "raid"
LOP.DB.TypeData[532] = "raid"
LOP.DB.TypeData[544] = "raid"
LOP.DB.TypeData[548] = "raid"
LOP.DB.TypeData[580] = "raid"
LOP.DB.TypeData[550] = "raid"
LOP.DB.TypeData[631] = "raid"
LOP.DB.TypeData[533] = "raid"
LOP.DB.TypeData[249] = "raid"
LOP.DB.TypeData[616] = "raid"
LOP.DB.TypeData[615] = "raid"
LOP.DB.TypeData[724] = "raid"
LOP.DB.TypeData[649] = "raid"
LOP.DB.TypeData[603] = "raid"
LOP.DB.TypeData[624] = "raid"
LOP.DB.TypeData[757] = "raid"
LOP.DB.TypeData[669] = "raid"
LOP.DB.TypeData[967] = "raid"
LOP.DB.TypeData[720] = "raid"
LOP.DB.TypeData[671] = "raid"
LOP.DB.TypeData[754] = "raid"
LOP.DB.TypeData[1009] = "raid"
LOP.DB.TypeData[1008] = "raid"
LOP.DB.TypeData[1136] = "raid"
LOP.DB.TypeData[996] = "raid"
LOP.DB.TypeData[1098] = "raid"
LOP.DB.TypeData[1228] = "raid"
LOP.DB.TypeData[1205] = "raid"
LOP.DB.TypeData[1448] = "raid"
LOP.DB.TypeData[1520] = "raid"
LOP.DB.TypeData[1648] = "raid"
LOP.DB.TypeData[1530] = "raid"
LOP.DB.TypeData[1676] = "raid"
LOP.DB.TypeData[1712] = "raid"
LOP.DB.TypeData[1861] = "raid"
LOP.DB.TypeData[2070] = "raid"
LOP.DB.TypeData[2096] = "raid"
LOP.DB.TypeData[2164] = "raid"
LOP.DB.TypeData[2217] = "raid"
LOP.DB.TypeData[2284] = "dungeon"
LOP.DB.TypeData[2285] = "dungeon"
LOP.DB.TypeData[2286] = "dungeon"
LOP.DB.TypeData[2287] = "dungeon"
LOP.DB.TypeData[2289] = "dungeon"
LOP.DB.TypeData[2290] = "dungeon"
LOP.DB.TypeData[2291] = "dungeon"
LOP.DB.TypeData[2293] = "dungeon"
LOP.DB.TypeData[2296] = "raid"
LOP.DB.TypeData[2441] = "dungeon"
LOP.DB.TypeData[2450] = "raid"
LOP.DB.TypeData[2481] = "raid"
LOP.DB.TypeData[2526] = "dungeon"
LOP.DB.TypeData[2520] = "dungeon"
LOP.DB.TypeData[2527] = "dungeon"
LOP.DB.TypeData[2519] = "dungeon"
LOP.DB.TypeData[2521] = "dungeon"
LOP.DB.TypeData[2515] = "dungeon"
LOP.DB.TypeData[2516] = "dungeon"
LOP.DB.TypeData[2451] = "dungeon"
LOP.DB.TypeData[2574] = "raid"
LOP.DB.TypeData[2522] = "raid"
LOP.DB.TypeData[2569] = "raid"

LOP.DB.NameData = {}
LOP.DB.NameData[0] = "unknown"
LOP.DB.NameData[48] = L["Blackfathom Deeps"]
LOP.DB.NameData[230] = L["Blackrock Depths"]
LOP.DB.NameData[229] = L["Blackrock Spire"]
LOP.DB.NameData[429] = L["Dire Maul"]
LOP.DB.NameData[90] = L["Gnomeregan"]
LOP.DB.NameData[349] = L["Maraudon"]
LOP.DB.NameData[389] = L["Ragefire Chasm"]
LOP.DB.NameData[129] = L["Razorfen Downs"]
LOP.DB.NameData[47] = L["Razorfen Kraul"]
LOP.DB.NameData[1001] = L["Scarlet Halls"]
LOP.DB.NameData[1004] = L["Scarlet Monastery"]
LOP.DB.NameData[1007] = L["Scholomance"]
LOP.DB.NameData[33] = L["Shadowfang Keep"]
LOP.DB.NameData[329] = L["Stratholme"]
LOP.DB.NameData[36] = L["The Deadmines"]
LOP.DB.NameData[34] = L["The Stockade"]
LOP.DB.NameData[109] = L["The Temple of Atal'Hakkar"]
LOP.DB.NameData[70] = L["Uldaman"]
LOP.DB.NameData[43] = L["Wailing Caverns"]
LOP.DB.NameData[209] = L["Zul'Farrak"]
LOP.DB.NameData[558] = L["Auchenai Crypts"]
LOP.DB.NameData[543] = L["Hellfire Ramparts"]
LOP.DB.NameData[585] = L["Magisters' Terrace"]
LOP.DB.NameData[557] = L["Mana-Tombs"]
LOP.DB.NameData[560] = L["Old Hillsbrad Foothills"]
LOP.DB.NameData[556] = L["Sethekk Halls"]
LOP.DB.NameData[555] = L["Shadow Labyrinth"]
LOP.DB.NameData[552] = L["The Arcatraz"]
LOP.DB.NameData[269] = L["The Black Morass"]
LOP.DB.NameData[542] = L["The Blood Furnace"]
LOP.DB.NameData[553] = L["The Botanica"]
LOP.DB.NameData[554] = L["The Mechanar"]
LOP.DB.NameData[540] = L["The Shattered Halls"]
LOP.DB.NameData[547] = L["The Slave Pens"]
LOP.DB.NameData[545] = L["The Steamvault"]
LOP.DB.NameData[546] = L["The Underbog"]
LOP.DB.NameData[619] = L["Ahn'kahet. The Old Kingdom"]
LOP.DB.NameData[601] = L["Azjol-Nerub"]
LOP.DB.NameData[600] = L["Drak'Tharon Keep"]
LOP.DB.NameData[604] = L["Gundrak"]
LOP.DB.NameData[602] = L["Halls of Lightning"]
LOP.DB.NameData[668] = L["Halls of Reflection"]
LOP.DB.NameData[599] = L["Halls of Stone"]
LOP.DB.NameData[658] = L["Pit of Saron"]
LOP.DB.NameData[595] = L["The Culling of Stratholme"]
LOP.DB.NameData[632] = L["The Forge of Souls"]
LOP.DB.NameData[576] = L["The Nexus"]
LOP.DB.NameData[578] = L["The Oculus"]
LOP.DB.NameData[608] = L["The Violet Hold"]
LOP.DB.NameData[650] = L["Trial of the Champion"]
LOP.DB.NameData[574] = L["Utgarde Keep"]
LOP.DB.NameData[575] = L["Utgarde Pinnacle"]
LOP.DB.NameData[645] = L["Blackrock Caverns"]
LOP.DB.NameData[938] = L["End Time"]
LOP.DB.NameData[670] = L["Grim Batol"]
LOP.DB.NameData[644] = L["Halls of Origination"]
LOP.DB.NameData[940] = L["Hour of Twilight"]
LOP.DB.NameData[755] = L["Lost City of the Tol'vir"]
LOP.DB.NameData[725] = L["The Stonecore"]
LOP.DB.NameData[657] = L["The Vortex Pinnacle"]
LOP.DB.NameData[643] = L["Throne of the Tides"]
LOP.DB.NameData[939] = L["Well of Eternity"]
LOP.DB.NameData[568] = L["Zul'Aman"]
LOP.DB.NameData[859] = L["Zul'Gurub"]
LOP.DB.NameData[962] = L["Gate of the Setting Sun"]
LOP.DB.NameData[994] = L["Mogu'Shan Palace"]
LOP.DB.NameData[959] = L["Shado-pan Monastery"]
LOP.DB.NameData[1011] = L["Siege of Niuzao Temple"]
LOP.DB.NameData[961] = L["Stormstout Brewery"]
LOP.DB.NameData[960] = L["Temple of the Jade Serpent"]
LOP.DB.NameData[1182] = L["Auchindoun"]
LOP.DB.NameData[1175] = L["Bloodmaul Slag Mines"]
LOP.DB.NameData[1208] = L["Grimrail Depot"]
LOP.DB.NameData[1195] = L["Iron Docks"]
LOP.DB.NameData[1176] = L["Shadowmoon Burial Grounds"]
LOP.DB.NameData[1209] = L["Skyreach"]
LOP.DB.NameData[1279] = L["The Everbloom"]
LOP.DB.NameData[1358] = L["Upper Blackrock Spire"]
LOP.DB.NameData[1501] = L["Black Rook Hold"]
LOP.DB.NameData[1677] = L["Cathedral of Eternal Night"]
LOP.DB.NameData[1571] = L["Court of Stars"]
LOP.DB.NameData[1466] = L["Darkheart Thicket"]
LOP.DB.NameData[1456] = L["Eye of Azshara"]
LOP.DB.NameData[1477] = L["Halls of Valor"]
LOP.DB.NameData[1492] = L["Maw of Souls"]
LOP.DB.NameData[1458] = L["Neltharion's Lair"]
LOP.DB.NameData[1651] = L["Return to Karazhan"]
LOP.DB.NameData[1753] = L["Seat of the Triumvirate"]
LOP.DB.NameData[1516] = L["The Arcway"]
LOP.DB.NameData[1493] = L["Vault of the Wardens"]
LOP.DB.NameData[1544] = L["Violet Hold"]
LOP.DB.NameData[1763] = L["Atal'Dazar"]
LOP.DB.NameData[1754] = L["Freehold"]
LOP.DB.NameData[1762] = L["Kings' Rest"]
LOP.DB.NameData[1864] = L["Shrine of the Storm"]
LOP.DB.NameData[1822] = L["Siege of Boralus"]
LOP.DB.NameData[1877] = L["Temple of Sethraliss"]
LOP.DB.NameData[1594] = L["The MOTHERLODE!!"]
LOP.DB.NameData[1841] = L["The Underrot"]
LOP.DB.NameData[1771] = L["Tol Dagor"]
LOP.DB.NameData[1862] = L["Waycrest Manor"]
LOP.DB.NameData[2097] = L["Operation. Mechagon"]
LOP.DB.NameData[469] = L["Blackwing Lair"]
LOP.DB.NameData[409] = L["Molten Core"]
LOP.DB.NameData[509] = L["Ruins of Ahn'Qiraj"]
LOP.DB.NameData[531] = L["Temple of Ahn'Qiraj"]
LOP.DB.NameData[564] = L["Black Temple"]
LOP.DB.NameData[565] = L["Gruul's Lair"]
LOP.DB.NameData[534] = L["Hyjal Summit"]
LOP.DB.NameData[532] = L["Karazhan"]
LOP.DB.NameData[544] = L["Magtheridon's Lair"]
LOP.DB.NameData[548] = L["Serpentshrine Cavern"]
LOP.DB.NameData[580] = L["Sunwell Plateau"]
LOP.DB.NameData[550] = L["Tempest Keep"]
LOP.DB.NameData[631] = L["Icecrown Citadel"]
LOP.DB.NameData[533] = L["Naxxramas"]
LOP.DB.NameData[249] = L["Onyxia's Lair"]
LOP.DB.NameData[616] = L["The Eye of Eternity"]
LOP.DB.NameData[615] = L["The Obsidian Sanctum"]
LOP.DB.NameData[724] = L["The Ruby Sanctum"]
LOP.DB.NameData[649] = L["Trial of the Crusader"]
LOP.DB.NameData[603] = L["Ulduar"]
LOP.DB.NameData[624] = L["Vault of Archavon"]
LOP.DB.NameData[757] = L["Baradin Hold"]
LOP.DB.NameData[669] = L["Blackwing Descent"]
LOP.DB.NameData[967] = L["Dragon Soul"]
LOP.DB.NameData[720] = L["Firelands"]
LOP.DB.NameData[671] = L["The Bastion of Twilight"]
LOP.DB.NameData[754] = L["Throne of the Four Winds"]
LOP.DB.NameData[1009] = L["Heart of Fear"]
LOP.DB.NameData[1008] = L["Mogu'shan Vaults"]
LOP.DB.NameData[1136] = L["Siege of Orgrimmar"]
LOP.DB.NameData[996] = L["Terrace of Endless Spring"]
LOP.DB.NameData[1098] = L["Throne of Thunder"]
LOP.DB.NameData[1228] = L["Highmaul"]
LOP.DB.NameData[1205] = L["Blackrock Foundry"]
LOP.DB.NameData[1448] = L["Hellfire Citadel"]
LOP.DB.NameData[1520] = L["The Emerald Nightmare"]
LOP.DB.NameData[1648] = L["Trial of Valor"]
LOP.DB.NameData[1530] = L["The Nighthold"]
LOP.DB.NameData[1676] = L["Tomb of Sargeras"]
LOP.DB.NameData[1712] = L["Antorus, the Burning Throne"]
LOP.DB.NameData[1861] = L["Uldir"]
LOP.DB.NameData[2070] = L["Battle of Dazar'alor"]
LOP.DB.NameData[2096] = L["Crucible of Storms"]
LOP.DB.NameData[2164] = L["The Eternal Palace"]
LOP.DB.NameData[2217] = L["Ny�alotha "]
LOP.DB.NameData[2284] = L["Sanguine Depths"]
LOP.DB.NameData[2285] = L["Spires of Ascension"]
LOP.DB.NameData[2286] = L["The Necrotic Wake"]
LOP.DB.NameData[2287] = L["Halls of Atonement"]
LOP.DB.NameData[2289] = L["Plaguefall"]
LOP.DB.NameData[2290] = L["Mists of Tirna Scithe"]
LOP.DB.NameData[2291] = L["De Other Side"]
LOP.DB.NameData[2293] = L["Theater of Pain"]
LOP.DB.NameData[2296] = L["Castle Nathria"]
LOP.DB.NameData[2441] = L["Tazavesh, the Veiled Market"]
LOP.DB.NameData[2450] = L["Sanctum of Domination"]
LOP.DB.NameData[2481] = L["Sepulcher of the First Ones"]
LOP.DB.NameData[2526] = L["Algeth'ar Academy"]
LOP.DB.NameData[2520] = L["Brackenhide Hollow"]
LOP.DB.NameData[2527] = L["Halls of Infusion"]
LOP.DB.NameData[2519] = L["Neltharus"]
LOP.DB.NameData[2521] = L["Ruby Life Pools"]
LOP.DB.NameData[2515] = L["The Azure Vault"]
LOP.DB.NameData[2516] = L["The Nokhud Offensive"]
LOP.DB.NameData[2451] = L["Uldaman: Legacy of Tyr"]
LOP.DB.NameData[2574] = L["Dragon Isles"]
LOP.DB.NameData[2522] = L["Vault of the Incarnates"]
LOP.DB.NameData[2569] = L["Aberrus, the Shadowed Crucible"]
LOP.DB.NameData[2579] = L["Dawn of the Infinite"]

LOP.DB.WB.revision = 2

LOP.DB.WB.NameData = {}
LOP.DB.WB.NameData[109943] = L["Ana-Mouz"]
LOP.DB.WB.NameData[109331] = L["Calamir"]
LOP.DB.WB.NameData[110378] = L["Drugon the Frostblood"]
LOP.DB.WB.NameData[99929] = L["Flotsam"]
LOP.DB.WB.NameData[108879] = L["Humongris"]
LOP.DB.WB.NameData[108829] = L["Levantus"]
LOP.DB.WB.NameData[110321] = L["Na'zak the Fiend"]
LOP.DB.WB.NameData[107544] = L["Nithogg"]
LOP.DB.WB.NameData[108678] = L["Shar'thos"]
LOP.DB.WB.NameData[112350] = L["Withered J'im"]
LOP.DB.WB.NameData[140252] = L["Hailstone Construct"]
LOP.DB.WB.NameData[136385] = L["Azurethos"]
LOP.DB.WB.NameData[140163] = L["Warbringer Yenajz"]
LOP.DB.WB.NameData[132701] = L["T'zane"]
LOP.DB.WB.NameData[132253] = L["Ji'arak"]
LOP.DB.WB.NameData[138794] = L["Dunegorger Kraulok"]
LOP.DB.WB.NameData[137374] = L["The Lion's Roar"]
LOP.DB.WB.NameData[138122] = L["Doom's Howl"]
LOP.DB.WB.NameData[144946] = L["Ivus the Forest Lord"]
LOP.DB.WB.NameData[148295] = L["Ivus the Decayed"]
LOP.DB.WB.NameData[60491] = L["Sha of Anger"]
LOP.DB.WB.NameData[62346] = L["Galleon"]
LOP.DB.WB.NameData[69099] = L["Nalak"]
LOP.DB.WB.NameData[69161] = L["Oondasta"]
LOP.DB.WB.NameData[83746] = L["Rukhmar"]


LOP.DB.WB.AddonData = {}
LOP.DB.WB.AddonData[109943] = L["legion"]
LOP.DB.WB.AddonData[109331] = L["legion"]
LOP.DB.WB.AddonData[110378] = L["legion"]
LOP.DB.WB.AddonData[99929] = L["legion"]
LOP.DB.WB.AddonData[108879] = L["legion"]
LOP.DB.WB.AddonData[108829] = L["legion"]
LOP.DB.WB.AddonData[110321] = L["legion"]
LOP.DB.WB.AddonData[107544] = L["legion"]
LOP.DB.WB.AddonData[108678] = L["legion"]
LOP.DB.WB.AddonData[42269] = L["legion"]
LOP.DB.WB.AddonData[112350] = L["legion"]
LOP.DB.WB.AddonData[140252] = L["bfa"]
LOP.DB.WB.AddonData[136385] = L["bfa"]
LOP.DB.WB.AddonData[140163] = L["bfa"]
LOP.DB.WB.AddonData[132701] = L["bfa"]
LOP.DB.WB.AddonData[132253] = L["bfa"]
LOP.DB.WB.AddonData[138794] = L["bfa"]
LOP.DB.WB.AddonData[137374] = L["bfa"]
LOP.DB.WB.AddonData[138122] = L["bfa"]
LOP.DB.WB.AddonData[144946] = L["bfa"]
LOP.DB.WB.AddonData[148295] = L["bfa"]
LOP.DB.WB.AddonData[60491] = L["mop"]
LOP.DB.WB.AddonData[62346] = L["mop"]
LOP.DB.WB.AddonData[69099] = L["mop"]
LOP.DB.WB.AddonData[69161] = L["mop"]
LOP.DB.WB.AddonData[83746] = L["wod"]
