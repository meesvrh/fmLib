local adapter = {}

function adapter.canCarryItem(source, item, amount)
    local canCarry, reason = exports['origen_inventory']:canCarryItem(source, item, amount)
    return canCarry
end

function adapter.getSlotIDByItem(inv, itemName)
    local inventoryData = exports['origen_inventory']:getInventory(inv)
    if inventoryData and inventoryData.items then
        for _, item in pairs(inventoryData.items) do
            if item.name == itemName then
                return item.slot
            end
        end
    end
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports['origen_inventory']:setMetadata(inv, slot, metadata)
end

FM_Adapter_server_inventory_origen = adapter