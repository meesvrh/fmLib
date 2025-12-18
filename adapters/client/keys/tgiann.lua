--[[
    fmLib - TGIANN Hotwire Adapter
]]

local adapter = {}

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports['tgiann-hotwire']:GiveKeyPlate(plate, true)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports['tgiann-hotwire']:HasKeyPlate(plate)
end

FM_Adapter_client_keys_tgiann = adapter