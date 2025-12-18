--[[
    fmLib - Fuel Client Adapter
]]

FM = FM or {}
FM.fuel = FM.fuel or {}

local fuelAdapter = BaseAdapter:new('fuel', 'client')

function FM.fuel.set(vehicle, fuelLvl)
    return fuelAdapter:call('set', vehicle, fuelLvl)
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}

-- Backwards compatibility
function FM.vehicle.setFuel(vehicle, fuelLvl)
    Warning('FM.vehicle.setFuel is deprecated, use FM.fuel.set instead')
    return FM.fuel.set(vehicle, fuelLvl)
end