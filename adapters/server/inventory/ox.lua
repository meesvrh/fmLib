local adapter = {}

function adapter.addItem(src, item, amount, metadata)
    exports['ox_inventory']:AddItem(src, item, amount, metadata)
    return true
end

function adapter.removeItem(src, item, amount, slotId, metadata)
    exports['ox_inventory']:RemoveItem(src, item, amount, metadata, slotId)
end

function adapter.canCarryItem(src, item, amount)
    return exports['ox_inventory']:CanCarryItem(src, item, amount)
end

function adapter.getItem(src, item)
    local itemData = exports['ox_inventory']:GetItem(src, item, nil, false)
    if not itemData then return end

    return {
        name = itemData.name,
        label = itemData.label,
        amount = itemData.count
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports['ox_inventory']:GetInventory(src).items

    for slot, item in pairs(items) do
        inventory[slot] = {
            name = item.name,
            label = item.label,
            amount = item.count,
            metadata = item.metadata,
        }
    end

    return inventory
end

FM_Adapter_server_inventory_ox = adapter