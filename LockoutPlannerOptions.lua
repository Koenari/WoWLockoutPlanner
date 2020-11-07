--  MyInstanceLocks AddOn for WoW-Retail Copyright (C) 2020  Patrick Hahn (Koenari)
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

-- This file is loaded from "MyInstanceLocks.toc"
function LOP.configFrame_OnShow()
	command, instanceType, addonType, broadcast = LOP.getDefaultArguments();
	editCommand:SetText(command);
	editInstanceType:SetText(instanceType);
	editAddOn:SetText(addonType);
	cbBroadcast:SetChecked(lopWantsToBroadcast);
end

function LOP.configFrameOnSave()
	LOP.setDefaultArguments(
		string.lower(editCommand:GetText()),
		string.lower(editInstanceType:GetText()),
		string.lower(editAddOn:GetText())
	);
	local wantsToBc = cbBroadcast:GetChecked();
	if (wantsToBc == 1 or wantsToBc == true) then
		lopWantsToBroadcast = true
	else
		lopWantsToBroadcast = false
	end
	lopOptionsFrame:Hide();
end
