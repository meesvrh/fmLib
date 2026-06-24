local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    local success = exports[resourceName]:AddItem(src, item, amount, metadata)
    return success == true
end

function adapter.removeItem(src, item, amount, slotId, metadata)
    local success = exports[resourceName]:RemoveItem(src, item, amount, metadata, slotId)
    return success == true
end

function adapter.canCarryItem(src, item, amount)
    return exports[resourceName]:CanCarryItem(src, item, amount)
end

function adapter.getItem(src, item)
    local itemData = exports[resourceName]:GetItem(src, item)
    if not itemData then return end

    return {
        name = itemData.name,
        label = itemData.label,
        amount = itemData.count,
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:GetInventoryItems(src)

    for _, item in ipairs(items) do
        inventory[item.slot] = {
            name = item.name,
            label = item.label,
            amount = item.count,
            metadata = item.metadata,
        }
    end

    return inventory
end

local cachedItemLabels = {}
function adapter.getItemLabel(item)
    if cachedItemLabels[item] then return cachedItemLabels[item] end

    local definition = exports[resourceName]:GetItemDefinition(item)
    if definition then
        cachedItemLabels[item] = definition.label
        return definition.label
    end
end

function adapter.getMetaDataBySlot(inv, slot)
    local slotData = exports[resourceName]:GetSlot(inv, slot)
    return slotData and slotData.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports[resourceName]:GetSlotIdWithItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:SetItemMetadata(inv, slot, metadata)
end

function adapter.registerStash(_stash)
    -- Stashes auto-create on first OpenInventory / AddItem call
end

function adapter.upgradeStash(stashId, newWeight, newSlots)
    local inv = ('stash:%s'):format(stashId)

    if newWeight then
        exports[resourceName]:SetInventoryMaxWeight(inv, newWeight)
    end

    if newSlots then
        exports[resourceName]:SetInventorySlotCount(inv, newSlots)
    end
end

FM_Adapter_server_inventory_one = adapter
