--[[
    fmLib - MM Carkeys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['mm_carkeys']:GiveKey(plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['mm_carkeys']:RemoveKey(plate)
end

FM_Adapter_client_keys_mm = adapter