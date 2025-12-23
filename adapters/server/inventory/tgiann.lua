local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    exports[resourceName]:AddItem(src, item, amount, nil, metadata)
    return true
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:GetPlayerItems(src)

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