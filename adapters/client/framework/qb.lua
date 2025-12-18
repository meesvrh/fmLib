--[[
    fmLib - QB Framework Client Adapter
]]

local adapter = {}

function adapter.getPlate(vehicle)
    if not vehicle then return end
    return QB.Functions.GetPlate(vehicle)
end

function adapter.notify(message, type)
    if not message then return end
    QB.Functions.Notify(message, type)
end

function adapter.hasItem(item)
    return QB.Functions.HasItem(item)
end

function adapter.getItems()
    local inventory = {}
    local items = QB.Functions.GetPlayerData().items

    for slot, item in pairs(items) do
        inventory[slot] = {
            name = item.name,
            label = item.label,
            amount = item.amount
        }
    end

    return inventory
end

FM_Adapter_client_framework_qb = adapter
