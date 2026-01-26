local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.getItemLabel(item)
    return exports[resourceName]:getItemLabel(item)
end

function adapter.getMetaDataBySlot(inv, slot)
    return exports[resourceName]:getItemFromSlot(inv, slot)?.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    local item, slot = exports[resourceName]:getItemByName(inv, itemName)
    return slot
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:setItemMetadataInSlot(inv, slot, metadata)
end

FM_Adapter_server_inventory_jaksam = adapter