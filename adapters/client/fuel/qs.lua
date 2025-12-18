--[[
    fmLib - QS Fuel Adapter
]]

local adapter = {}

function adapter.set(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0
    exports['qs-fuelstations']:SetFuel(vehicle, fuelLvl)
end

FM_Adapter_client_fuel_qs = adapter