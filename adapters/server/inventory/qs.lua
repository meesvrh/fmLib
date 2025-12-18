local adapter = {}

function adapter.addItem(src, item, amount, metadata)
    exports['qs-inventory']:AddItem(src, item, amount, nil, metadata)
    return true
end

function adapter.canCarryItem(src, item, amount)
    return exports['qs-inventory']:CanCarryItem(src, item, amount)
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports['qs-inventory']:GetInventory(src)

    for _, itemData in pairs(items) do
        inventory[itemData.slot] = {
            name = itemData.name,
            label = itemData.label,
            amount = itemData.count,
            metadata = itemData.info,
        }
    end

    return inventory
end

FM_Adapter_server_inventory_qs = adapter