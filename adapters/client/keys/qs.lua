--[[
    fmLib - QS Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    exports['qs-vehiclekeys']:RemoveKeys(plate, model)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['qs-vehiclekeys']:GetServerKey(plate)
end

FM_Adapter_client_keys_qs = adapter