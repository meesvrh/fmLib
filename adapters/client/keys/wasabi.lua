--[[
    fmLib - Wasabi Carlock Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['wasabi_carlock']:GiveKey(plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['wasabi_carlock']:RemoveKey(plate)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['wasabi_carlock']:HasKey(plate)
end

FM_Adapter_client_keys_wasabi = adapter