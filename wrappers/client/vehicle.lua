FM.vehicle = {}

-- MIGRATED TO ADAPTER PATTERN: adapters/client/framework.lua
-- Backwards compatibility is handled in the framework adapter
--[[
---@param vehicle number
function FM.vehicle.getPlate(vehicle)
    if not vehicle then return end

    if ESX then
        return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    elseif QB then
        return QB.Functions.GetPlate(vehicle)
    end
end
--]]

-- MIGRATED TO ADAPTER PATTERN: adapters/client/keys.lua
-- Backwards compatibility is handled in the keys adapter
--[[
---@param vehicle number
function FM.vehicle.giveKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    if QBVehKeys then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    elseif CDGarage then
        TriggerEvent('cd_garage:AddKeys', plate)
    elseif okokGarage then
        TriggerServerEvent('okokGarage:GiveKeys', plate)
    elseif QSVehKeys then
        QSVehKeys:GiveKeys(plate, model, true)
    elseif RenewedVehKeys then
        RenewedVehKeys:addKey(plate)
    elseif WASABI_CARLOCK then
        WASABI_CARLOCK:GiveKey(plate)
    elseif TGIANN_HOTWIRE then
        TGIANN_HOTWIRE:GiveKeyPlate(plate, true)
    elseif MM_CARKEYS then
        MM_CARKEYS:GiveKey(plate)
    elseif MRNEWBVEHICLEKEYS then
        MRNEWBVEHICLEKEYS:GiveKeys(vehicle)
    elseif ISVehicleKeys then
        ISVehicleKeys:GiveKey(plate)
    elseif FAST_VEHICLEKEYS then
        FAST_VEHICLEKEYS:GiveKey(plate)
    elseif FILO_VEHICLEKEYS then
        FILO_VEHICLEKEYS:GiveKeys(plate)
    elseif QBX_VEHICLEKEYS then
        QBX_VEHICLEKEYS:GiveKeys(vehicle)
    end
end

---@param vehicle number
function FM.vehicle.removeKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    if QBVehKeys then
        TriggerEvent("vehiclekeys:client:RemoveKeys", plate)
    elseif okokGarage then
        TriggerServerEvent('okokGarage:RemoveKeys', plate)
    elseif QSVehKeys then
        QSVehKeys:RemoveKeys(plate, model)
    elseif RenewedVehKeys then
        RenewedVehKeys:removeKey(plate)
    elseif WASABI_CARLOCK then
        WASABI_CARLOCK:RemoveKey(plate)
    elseif MM_CARKEYS then
        MM_CARKEYS:RemoveKey(plate)
    elseif MRNEWBVEHICLEKEYS then
        MRNEWBVEHICLEKEYS:RemoveKeys(vehicle)
    elseif FILO_VEHICLEKEYS then
        FILO_VEHICLEKEYS:RemoveKeys(plate)
    elseif QBX_VEHICLEKEYS then
        QBX_VEHICLEKEYS:RemoveKeys(vehicle)
    end
end

---@param vehicle number
function FM.vehicle.hasKey(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if QBVehKeys then
        QBVehKeys:hasKey(plate)
    elseif CDGarage then
        return CDGarage:DoesPlayerHaveKeys(plate)
    elseif QSVehKeys then
        return QSVehKeys:GetServerKey(plate)
    elseif RenewedVehKeys then
        return RenewedVehKeys:hasKey(plate)
    elseif WASABI_CARLOCK then
        return WASABI_CARLOCK:HasKey(plate)
    elseif TGIANN_HOTWIRE then
        return TGIANN_HOTWIRE:HasKeyPlate(plate)
    elseif FILO_VEHICLEKEYS then
        return FILO_VEHICLEKEYS:HasKeys(plate)
    elseif MRNEWBVEHICLEKEYS then
        return MRNEWBVEHICLEKEYS:HaveKeys(vehicle)
    elseif QBX_VEHICLEKEYS then
        return QBX_VEHICLEKEYS:HasKeys(vehicle)
    end
end
--]]

-- FUEL ADAPTERS WILL BE NEXT
---@param vehicle number
---@param fuelLvl number
function FM.vehicle.setFuel(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0

    if OXFUEL then
        Entity(vehicle).state.fuel = fuelLvl
    elseif LEGACYFUEL then
        LEGACYFUEL:SetFuel(vehicle, fuelLvl)
    elseif CDN_FUEL then
        CDN_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RENEWED_FUEL then
        RENEWED_FUEL:SetFuel(vehicle, fuelLvl)
    elseif QBFUEL then
        QBFUEL:SetFuel(vehicle, fuelLvl)
    elseif LC_FUEL then
        LC_FUEL:SetFuel(vehicle, fuelLvl)
    elseif PS_FUEL then
        PS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RCORE_FUEL then
        RCORE_FUEL:SetFuel(vehicle, fuelLvl)
    elseif QS_FUEL then
        QS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif ND_FUEL then
        ND_FUEL:SetFuel(vehicle, fuelLvl)
    elseif BIGDADDY_FUEL then
        BIGDADDY_FUEL:SetFuel(vehicle, fuelLvl)
    elseif GKS_FUEL then
        GKS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RIP_FUEL then
        RIP_FUEL:SetFuel(vehicle, fuelLvl)
    elseif MYFUEL then
        MYFUEL:SetFuel(vehicle, fuelLvl)
    elseif LJ_FUEL then
        LJ_FUEL:SetFuel(vehicle, fuelLvl)
    elseif MELONS_FUEL then
         MELONS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif HRS_FUEL then
         HRS_FUEL:SetFuel(vehicle, fuelLvl)
    else
        SetVehicleFuelLevel(vehicle, fuelLvl)
    end
end

-- MIGRATED TO ADAPTER PATTERN: adapters/client/garage.lua
-- Backwards compatibility is handled in the garage adapter
--[[
---@param garageId string | number The garage ID
function FM.vehicle.storeInGarage(garageId)
    if GetResourceState(Resources.RXGARAGE.name) == "started" then
        exports[Resources.RXGARAGE.name]:ParkVehicle("House Garage ("..tostring(garageId)..")", 'garage', 'car')
    elseif OKOKG then
        TriggerEvent("okokGarage:StoreVehiclePrivate")
    elseif JGGARAGE then
        TriggerEvent("jg-advancedgarages:client:store-vehicle", "House: "..tostring(garageId), "car")
    elseif CODEMG then
        TriggerEvent("codem-garage:storeVehicle", garageId)
    elseif CDGarage then
        TriggerEvent('cd_garage:StoreVehicle_Main', 1, false, false)
    else
        FM.console.err("No garage resource found")
    end
end

---@param garageId string | number The garage ID
---@param coords vector4 The coordinates for the garage
function FM.vehicle.openGarage(garageId, coords)
    if GetResourceState(Resources.RXGARAGE.name) == "started" then
        exports[Resources.RXGARAGE.name]:OpenGarage("House Garage ("..tostring(garageId)..")", 'garage', 'car', coords)
    elseif OKOKG then
        TriggerEvent("okokGarage:OpenPrivateGarageMenu", vector3(coords.x, coords.y, coords.z), coords.w)
    elseif JGGARAGE then
        TriggerEvent("jg-advancedgarages:client:open-garage", "House: "..tostring(garageId), "car", coords)
    elseif CODEMG then
        TriggerEvent("codem-garage:openHouseGarage", garageId)
    elseif CDGarage then
        -- Choose either 'quick' or 'inside' in the 1st argument.
        -- Replace nil with '10cargarage_shell' or '40cargarage_shell' in the 2nd argument.
        TriggerEvent('cd_garage:PropertyGarage', 'quick', nil)
    else
        FM.console.err("No garage resource found")
    end
end
--]]
