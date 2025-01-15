FM.vehicle = {}

---@param vehicle number
function FM.vehicle.getPlate(vehicle)
    if not vehicle then return end

    if ESX then
        return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    elseif QB then
        return QB.Functions.GetPlate(vehicle)
    end
end

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
    end
end

---@param vehicle number
function FM.vehicle.removeKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:removeKey(plate)
    end
end

---@param vehicle number
function FM.vehicle.hasKey(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:hasKey(plate)
    end
end


---@param vehicle number
---@param fuelLvl number
function FM.vehicle.setFuel(vehicle, fuelLvl)
    if not vehicle or fuel == nil then return end

    if LEGACYFUEL then
        LEGACYFUEL:SetFuel(vehicle, fuelLvl)
    elseif OXFUEL then
        Entity(vehicle).state.fuel = fuelLvl
    else
        SetVehicleFuelLevel(vehicle, fuelLvl)
    end
end