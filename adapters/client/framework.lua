--[[
    fmLib - Framework Client Adapter
    Handles framework-specific utility functions
]]

FM = FM or {}
FM.framework = FM.framework or {}

local frameworkAdapter = BaseAdapter:new('framework', 'client')

function FM.framework.getPlate(vehicle)
    return frameworkAdapter:call('getPlate', vehicle)
end

-- Backwards compatibility
function FM.vehicle.getPlate(vehicle)
    Warning('FM.vehicle.getPlate is deprecated, use FM.framework.getPlate instead')
    return FM.framework.getPlate(vehicle)
end