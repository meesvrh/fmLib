--[[
    fmLib - ESX Framework Client Adapter
]]

local adapter = {}

function adapter.getPlate(vehicle)
    if not vehicle then return end
    return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
end

function adapter.notify(message, type)
    if not message then return end
    ESX.ShowNotification(message, type)
end

function adapter.hasItem(item)
    local has = ESX.SearchInventory(item, 1)
    return has and has > 0
end

function adapter.getItems()
    local inventory = {}
    local items = ESX.GetPlayerData().inventory

    for slot, item in pairs(items) do
        inventory[slot] = {
            name = item.name,
            label = item.label,
            amount = item.count
        }
    end

    return inventory
end

FM_Adapter_client_framework_esx = adapter