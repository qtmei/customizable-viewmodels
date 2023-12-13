CreateClientConVar("cl_righthand", 1)
CreateClientConVar("viewmodel_offset_x", 0)
CreateClientConVar("viewmodel_offset_y", 0)
CreateClientConVar("viewmodel_offset_z", 0)

hook.Add("Think", "CS_Custom_ViewModels_Think", function()
	local wep = LocalPlayer():GetActiveWeapon()

	if !IsValid(wep) then return end

	if !isbool(wep.OldViewModelFlip) then
		wep.OldViewModelFlip = wep.ViewModelFlip or false
	end

	if tobool(GetConVar("cl_righthand"):GetInt()) then
		wep.ViewModelFlip = wep.OldViewModelFlip
	else
		wep.ViewModelFlip = !wep.OldViewModelFlip
	end
end)

hook.Add("CalcViewModelView", "CS_Custom_ViewModels_CalcViewModelView", function(wep, vm, oldPos, oldAng, pos, ang)
	local offset = Vector(GetConVar("viewmodel_offset_x"):GetFloat(), GetConVar("viewmodel_offset_y"):GetFloat(), GetConVar("viewmodel_offset_z"):GetFloat())

	offset:Rotate(ang)

	return pos + offset, ang
end)
