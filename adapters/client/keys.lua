--[[
    fmLib - Vehicle Keys Client Adapter
]]

FM = FM or {}
FM.keys = FM.keys or {}

local keysAdapter = BaseAdapter:new('keys', 'client')

function FM.keys.give(vehicle)
    return keysAdapter:call('give', vehicle)
end

function FM.keys.remove(vehicle)
    return keysAdapter:call('remove', vehicle)
end

function FM.keys.has(vehicle)
    return keysAdapter:call('has', vehicle)
end

-- Backwards compatibility
function FM.vehicle.giveKeys(vehicle)
    Warning('FM.vehicle.giveKeys is deprecated, use FM.keys.give instead')
    return FM.keys.give(vehicle)
end

function FM.vehicle.removeKeys(vehicle)
    Warning('FM.vehicle.removeKeys is deprecated, use FM.keys.remove instead')
    return FM.keys.remove(vehicle)
end

function FM.vehicle.hasKey(vehicle)
    Warning('FM.vehicle.hasKey is deprecated, use FM.keys.has instead')
    return FM.keys.has(vehicle)
end