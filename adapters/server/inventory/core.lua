local adapter = {}

function adapter.getInventory(src)
    local inventory = {}
    local items = exports['core_inventory']:getInventory(src)

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

FM_Adapter_server_inventory_core = adapter