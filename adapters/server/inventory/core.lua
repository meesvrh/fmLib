local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:getInventory(src)

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
    return exports[resourceName]:getItemBySlot(inv, slot)?.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports[resourceName]:getFirstSlotByItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:setMetadata(inv, slot, metadata)
end

FM_Adapter_server_inventory_core = adapter