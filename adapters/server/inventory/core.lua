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

function adapter.getMetaDataBySlot(inv, slot)
    return exports['core_inventory']:getItemBySlot(inv, slot)?.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports['core_inventory']:getFirstSlotByItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports['core_inventory']:setMetadata(inv, slot, metadata)
end

FM_Adapter_server_inventory_core = adapter