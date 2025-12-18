--[[
    fmLib - QBX Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    exports['qbx_vehiclekeys']:GiveKeys(vehicle)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    exports['qbx_vehiclekeys']:RemoveKeys(vehicle)
end

function adapter.has(vehicle)
    if not vehicle then return end
    return exports['qbx_vehiclekeys']:HasKeys(vehicle)
end

FM_Adapter_client_keys_qbx = adapter