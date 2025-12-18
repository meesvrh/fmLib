--[[
    fmLib - MrNewb Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    exports['MrNewbVehicleKeys']:GiveKeys(vehicle)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    exports['MrNewbVehicleKeys']:RemoveKeys(vehicle)
end

function adapter.has(vehicle)
    if not vehicle then return end
    return exports['MrNewbVehicleKeys']:HaveKeys(vehicle)
end

FM_Adapter_client_keys_mrnewb = adapter