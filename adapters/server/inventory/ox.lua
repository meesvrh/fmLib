local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    exports[resourceName]:AddItem(src, item, amount, metadata)
    return true
end

function adapter.removeItem(src, item, amount, slotId, metadata)
    exports[resourceName]:RemoveItem(src, item, amount, metadata, slotId)
end

function adapter.canCarryItem(src, item, amount)
    return exports[resourceName]:CanCarryItem(src, item, amount)
end

function adapter.getItem(src, item)
    local itemData = exports[resourceName]:GetItem(src, item, nil, false)
    if not itemData then return end

    return {
        name = itemData.name,
        label = itemData.label,
        amount = itemData.count
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:GetInventory(src).items

    for slot, item in pairs(items) do
        inventory[slot] = {
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
    if cachedItemLabels[item] then return cachedItemLabels[item]
    else
        for itemName, v in pairs(exports[resourceName]:Items()) do
            cachedItemLabels[itemName] = v.label
        end

        return cachedItemLabels[item]
    end
end

function adapter.getMetaDataBySlot(inv, slot)
    return exports[resourceName]:GetSlot(inv, slot)?.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports[resourceName]:GetSlotIdWithItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:SetMetadata(inv, slot, metadata)
end

function adapter.registerStash(stash)
    exports[resourceName]:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner, stash.groups, stash.coords)
end

function adapter.upgradeStash(stashId, newWeight, newSlots)
    if newWeight then
        exports[resourceName]:SetMaxWeight(stashId, newWeight)
    end

    if newSlots then
        exports[resourceName]:SetSlotCount(stashId, newSlots)
    end
end

FM_Adapter_server_inventory_ox = adapter