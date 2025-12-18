--[[
    fmLib - QB Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    TriggerEvent("vehiclekeys:client:RemoveKeys", plate)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['qb-vehiclekeys']:hasKey(plate)
end

FM_Adapter_client_keys_qb = adapter