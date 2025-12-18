--[[
    fmLib - QB Framework Client Adapter
]]

local adapter = {}

function adapter.getPlate(vehicle)
    if not vehicle then return end
    return QB.Functions.GetPlate(vehicle)
end

FM_Adapter_client_framework_qb = adapter
