--[[
    fmLib - Filo Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['filo_vehiclekey']:GiveKeys(plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['filo_vehiclekey']:RemoveKeys(plate)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['filo_vehiclekey']:HasKeys(plate)
end

FM_Adapter_client_keys_filo = adapter