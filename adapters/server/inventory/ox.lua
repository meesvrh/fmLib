local adapter = {}

function adapter.addItem(src, item, amount, metadata)
    exports['ox_inventory']:AddItem(src, item, amount, metadata)
    return true
end

function adapter.removeItem(src, item, amount, slotId, metadata)
    exports['ox_inventory']:RemoveItem(src, item, amount, metadata, slotId)
end

function adapter.canCarryItem(src, item, amount)
    return exports['ox_inventory']:CanCarryItem(src, item, amount)
end

function adapter.getItem(src, item)
    local itemData = exports['ox_inventory']:GetItem(src, item, nil, false)
    if not itemData then return end

    return {
        name = itemData.name,
        label = itemData.label,
        amount = itemData.count
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports['ox_inventory']:GetInventory(src).items

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
        for itemName, v in pairs(exports['ox_inventory']:Items()) do
            cachedItemLabels[itemName] = v.label
        end

        return cachedItemLabels[item]
    end
end

function adapter.getMetaDataBySlot(inv, slot)
    return exports['ox_inventory']:GetSlot(inv, slot)?.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports['ox_inventory']:GetSlotIdWithItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports['ox_inventory']:SetMetadata(inv, slot, metadata)
end

function adapter.registerStash(stash)
    exports['ox_inventory']:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner, stash.groups, stash.coords)
end

function adapter.upgradeStash(stashId, newWeight, newSlots)
    if newWeight then
        exports['ox_inventory']:SetMaxWeight(stashId, newWeight)
    end

    if newSlots then
        exports['ox_inventory']:SetSlotCount(stashId, newSlots)
    end
end

FM_Adapter_server_inventory_ox = adapter