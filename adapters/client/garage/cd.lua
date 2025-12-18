--[[
    fmLib - CD Garage Client Adapter
]]

local adapter = {}

function adapter.open(garageId, coords)
    -- CD Garage uses 'quick' or 'inside' as first param
    -- nil can be replaced with '10cargarage_shell' or '40cargarage_shell'
    TriggerEvent('cd_garage:PropertyGarage', 'quick', nil)
end

function adapter.parkVehicle(garageId)
    TriggerEvent('cd_garage:StoreVehicle_Main', 1, false, false)
end

FM_Adapter_client_garage_cd = adapter