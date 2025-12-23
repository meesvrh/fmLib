local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.canCarryItem(source, item, amount)
    local canCarry, reason = exports[resourceName]:canCarryItem(source, item, amount)
    return canCarry
end

function adapter.getSlotIDByItem(inv, itemName)
    local inventoryData = exports[resourceName]:getInventory(inv)
    if inventoryData and inventoryData.items then
        for _, item in pairs(inventoryData.items) do
            if item.name == itemName then
                return item.slot
            end
        end
    end
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:setMetadata(inv, slot, metadata)
end

FM_Adapter_server_inventory_origen = adapter