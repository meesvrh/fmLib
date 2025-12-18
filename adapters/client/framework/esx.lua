--[[
    fmLib - ESX Framework Client Adapter
]]

local adapter = {}

function adapter.getPlate(vehicle)
    if not vehicle then return end
    return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
end

FM_Adapter_client_framework_esx = adapter