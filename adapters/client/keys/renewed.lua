--[[
    fmLib - Renewed Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['Renewed-Vehiclekeys']:addKey(plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['Renewed-Vehiclekeys']:removeKey(plate)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['Renewed-Vehiclekeys']:hasKey(plate)
end

FM_Adapter_client_keys_renewed = adapter