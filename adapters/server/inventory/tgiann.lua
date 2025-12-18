local adapter = {}

function adapter.addItem(src, item, amount, metadata)
    exports['tgiann-inventory']:AddItem(src, item, amount, nil, metadata)
    return true
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports['tgiann-inventory']:GetPlayerItems(src)

    for _, item in pairs(items) do
        inventory[item.slot] = {
            name = item.name,
            label = item.label,
            amount = item.amount,
            metadata = item.metadata,
        }
    end

    return inventory
end

FM_Adapter_server_inventory_tgiann = adapter