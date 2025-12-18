--[[
    fmLib - Fast Vehicle Keys Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['fast-vehiclekeys']:GiveKey(plate)
end

FM_Adapter_client_keys_fast = adapter