--[[
    fmLib - Framework Client Adapter
]]

FM = FM or {}
FM.framework = FM.framework or {}

local frameworkAdapter = BaseAdapter:new('framework', 'client')

function FM.framework.getPlate(vehicle)
    return frameworkAdapter:call('getPlate', vehicle)
end

function FM.framework.notify(message, type)
    return frameworkAdapter:call('notify', message, type)
end

function FM.framework.hasItem(item)
    return frameworkAdapter:call('hasItem', item)
end

function FM.framework.getItems()
    return frameworkAdapter:call('getItems')
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}
FM.utils = FM.utils or {}

function FM.vehicle.getPlate(vehicle)
    Warning('FM.vehicle.getPlate is deprecated, use FM.framework.getPlate instead')
    return FM.framework.getPlate(vehicle)
end

function FM.utils.notify(message, type)
    Warning('FM.utils.notify is deprecated, use FM.framework.notify instead')
    return FM.framework.notify(message, type)
end