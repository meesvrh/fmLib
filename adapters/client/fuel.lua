--[[
    fmLib - Fuel Client Adapter
]]

FM = FM or {}
FM.fuel = FM.fuel or {}

local fuelAdapter = BaseAdapter:new('fuel', 'client')

---@param vehicle number Vehicle entity handle
---@param fuelLvl number Fuel level to set (0-100)
---@return nil
function FM.fuel.set(vehicle, fuelLvl)
    return fuelAdapter:call('set', vehicle, fuelLvl)
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}

---@deprecated Use FM.fuel.set instead
---@param vehicle number Vehicle entity handle
---@param fuelLvl number Fuel level (0-100)
---@return nil
function FM.vehicle.setFuel(vehicle, fuelLvl)
    Warning('FM.vehicle.setFuel is deprecated, use FM.fuel.set instead')
    return FM.fuel.set(vehicle, fuelLvl)
end