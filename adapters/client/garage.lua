--[[
    fmLib - Garage Client Adapter
]]

FM = FM or {}
FM.garage = FM.garage or {}

local garageAdapter = BaseAdapter:new('garage', 'client')

function FM.garage.open(garageId, coords)
    return garageAdapter:call('open', garageId, coords)
end

function FM.garage.parkVehicle(garageId)
    return garageAdapter:call('parkVehicle', garageId)
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}

function FM.vehicle.openGarage(garageId, coords)
    Warning('FM.vehicle.openGarage is deprecated, use FM.garage.open instead')
    return FM.garage.open(garageId, coords)
end

function FM.vehicle.storeInGarage(garageId)
    Warning('FM.vehicle.storeInGarage is deprecated, use FM.garage.parkVehicle instead')
    return FM.garage.parkVehicle(garageId)
end