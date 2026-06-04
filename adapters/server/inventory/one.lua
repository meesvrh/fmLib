local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    return exports.one_inventory:AddItem(src, item, amount, metadata)
end

function adapter.removeItem(src, item, amount, slotId, metadata)
    return exports.one_inventory:RemoveItem(src, item, amount, metadata, slotId)
end

function adapter.canCarryItem(src, item, amount)
    return exports.one_inventory:CanCarryItem(src, item, amount)
end

function adapter.hasItem(src, item, amount)
    return exports.one_inventory:HasItem(src, item, amount)
end

function adapter.getItem(src, item, metadata)
    local itemData = exports.one_inventory:GetItem(src, item, metadata)
    if not itemData then return end
    
    return {
        name = itemData.name,
        label = itemData.label,
        amount = itemData.count,
        metadata = itemData.metadata
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports.one_inventory:GetInventoryItems(src)
    
    for _, item in pairs(items) do
        inventory[item.slot] = {
            name = item.name,
            label = item.label,
            amount = item.count,
            metadata = item.metadata
        }
    end
    
    return inventory
end

function adapter.getItemLabel(item)
    local def = exports.one_inventory:GetItemDefinition(item)
    return def and def.label
end

function adapter.getMetaDataBySlot(inv, slot)
    local slotData = exports.one_inventory:GetSlot(inv, slot)
    return slotData and slotData.metadata
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports.one_inventory:GetSlotIdWithItem(inv, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports.one_inventory:SetItemMetadata(inv, slot, metadata)
end

function adapter.registerStash(stash)
    local stashId = stash.owner and ('stash:%s:%s'):format(stash.id, stash.owner) or ('stash:%s'):format(stash.id)
    
    if stash.slots then
        exports.one_inventory:SetInventorySlotCount(stashId, stash.slots)
    end
    if stash.weight then
        exports.one_inventory:SetInventoryMaxWeight(stashId, stash.weight)
    end
end

function adapter.upgradeStash(stashId, newWeight, newSlots)
    local fullStashId = ('stash:%s'):format(stashId)
    
    if newWeight then
        exports.one_inventory:SetInventoryMaxWeight(fullStashId, newWeight)
    end
    if newSlots then
        exports.one_inventory:SetInventorySlotCount(fullStashId, newSlots)
    end
end

function adapter.openStash(src, stashId, stashData)
    local data = stashData or {}
    exports.one_inventory:OpenInventory(src, 'stash', {
        id = stashId,
        owner = data.owner,
        slots = data.slots,
        maxWeight = data.weight,
        label = data.label,
        groups = data.groups
    })
end

function adapter.clearStash(id, _type)
    local stashId = _type and ('%s:%s'):format(_type, id) or ('stash:%s'):format(id)
    exports.one_inventory:ClearInventory(stashId)
end

function adapter.addTrunkItems(identifier, items)
    local trunkId = ('trunk:%s'):format(identifier)
    for _, v in pairs(items) do
        exports.one_inventory:AddItem(trunkId, v.item, v.count, v.metadata)
    end
    return true
end

function adapter.updatePlate(oldplate, newplate)
    return exports.one_inventory:UpdateVehiclePlate(oldplate, newplate)
end

function adapter.openPlayerInventory(src, target)
    return exports.one_inventory:OpenInventory(src, 'player', target)
end

function adapter.inspectInventory(src, target)
    return exports.one_inventory:InspectInventory(src, target)
end

function adapter.confiscateInventory(src)
    return exports.one_inventory:ConfiscateInventory(src)
end

function adapter.restoreInventory(src)
    return exports.one_inventory:RestoreInventory(src)
end

function adapter.disarmPlayer(src)
    return exports.one_inventory:DisarmPlayer(src)
end

function adapter.removeWeapons(src)
    return exports.one_inventory:RemoveWeapons(src)
end

function adapter.createDrop(coords, items, options)
    return exports.one_inventory:CreateDrop(coords, items, options)
end

function adapter.dropInventory(src)
    return exports.one_inventory:DropInventory(src)
end

function adapter.getWeightHolding(src)
    return exports.one_inventory:GetWeightHolding(src)
end

function adapter.getWeightLeft(src)
    return exports.one_inventory:GetWeightLeft(src)
end

function adapter.saveInventory(inv)
    return exports.one_inventory:SaveInventory(inv)
end

FM_Adapter_server_inventory_one = adapter