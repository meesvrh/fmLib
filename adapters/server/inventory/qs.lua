local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    exports[resourceName]:AddItem(src, item, amount, nil, metadata)
    return true
end

function adapter.canCarryItem(src, item, amount)
    return exports[resourceName]:CanCarryItem(src, item, amount)
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:GetInventory(src)

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

function adapter.getMetaDataBySlot(inv, slot)
    local items = exports[resourceName]:GetInventory(inv)
    for _, item in pairs(items) do
        if item.slot == slot then return item.info end
    end
end

function adapter.getSlotIDByItem(inv, itemName)
    local items = exports[resourceName]:GetInventory(inv)
    for name, item in pairs(items) do
        if name == itemName then return item.slot end
    end
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:SetItemMetadata(inv, slot, metadata)
end

FM_Adapter_server_inventory_qs = adapter