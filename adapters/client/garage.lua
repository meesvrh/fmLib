--[[
    fmLib - Garage Client Adapter
]]

FM = FM or {}
FM.garage = FM.garage or {}

local garageAdapter = BaseAdapter:new('garage', 'client')

---@param garageId string|number Garage identifier or name
---@param coords? vector3 Garage coordinates (optional, used by some garage systems)
---@return nil
function FM.garage.open(garageId, coords)
    return garageAdapter:call('open', garageId, coords)
end

---@param garageId string|number Garage identifier where to park the vehicle
---@return boolean|nil success True if vehicle was parked successfully
function FM.garage.parkVehicle(garageId)
    return garageAdapter:call('parkVehicle', garageId)
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}

---@deprecated Use FM.garage.open instead
---@param garageId string|number Garage identifier
---@param coords? vector3 Garage coordinates
---@return nil
function FM.vehicle.openGarage(garageId, coords)
    Warning('FM.vehicle.openGarage is deprecated, use FM.garage.open instead')
    return FM.garage.open(garageId, coords)
end

---@deprecated Use FM.garage.parkVehicle instead
---@param garageId string|number Garage identifier
---@return boolean|nil success
function FM.vehicle.storeInGarage(garageId)
    Warning('FM.vehicle.storeInGarage is deprecated, use FM.garage.parkVehicle instead')
    return FM.garage.parkVehicle(garageId)
end