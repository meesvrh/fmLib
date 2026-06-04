local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end
    
    local data = {
        id = stashId
    }
    
    if owner ~= nil then
        data.owner = owner
    end
    
    if slots then
        data.slots = slots
    end
    
    if weight then
        data.maxWeight = weight
    end
    
    exports.one_inventory:OpenInventory('stash', data)
end

function adapter.getItems()
    local inventory = {}
    local items = exports.one_inventory:GetInventoryItems()
    
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

function adapter.hasItem(item, requiredCount)
    return exports.one_inventory:HasItem(item, requiredCount or 1)
end

function adapter.getItemCount(item)
    return exports.one_inventory:GetItemCount(item)
end

function adapter.getItemInfo(item)
    local def = exports.one_inventory:GetItemDefinition(item)
    if not def then return {} end
    
    return {
        name = def.name or item,
        label = def.label or item,
        stack = def.stack or false,
        weight = def.weight or 0,
        description = def.description or "",
        image = def.image and ("nui://%s/web/images/%s):format(def.image) or ("nui://%s/web/images/%s.png):format(resourceName, item)
    }
end

function adapter.displayMetadata(metadata)
    if metadata and metadata.name then
        exports.one_inventory:ShowItemMetadata(metadata.name, metadata.key)
    end
end

function adapter.getImgDirectory()
    return 'one_inventory/web/images/'
end

function adapter.getWeightHolding()
    return exports.one_inventory:GetWeightHolding()
end

function adapter.getMaxWeight()
    return exports.one_inventory:GetMaxWeight()
end

function adapter.getEquippedWeapon()
    return exports.one_inventory:GetEquippedWeapon()
end

function adapter.getEquippedClothing()
    return exports.one_inventory:GetEquippedClothing()
end

function adapter.equipClothing(item, metadata)
    return exports.one_inventory:EquipClothing(item, metadata)
end

function adapter.unequipClothing(componentType)
    return exports.one_inventory:UnequipClothing(componentType)
end

function adapter.useItemInSlot(slot)
    return exports.one_inventory:UseItemInSlot(slot)
end

function adapter.openNearbyInventory()
    return exports.one_inventory:OpenNearbyInventory()
end

function adapter.openInventory(invType, data)
    return exports.one_inventory:OpenInventory(invType, data)
end

function adapter.searchInventory(searchType, itemName, metadata)
    return exports.one_inventory:SearchInventory(searchType, itemName, metadata)
end

function adapter.getSlot(slot)
    return exports.one_inventory:GetSlot(slot)
end

function adapter.getSlotWithItem(itemName, metadata)
    return exports.one_inventory:GetSlotWithItem(itemName, metadata)
end

function adapter.getSlotsWithItem(itemName, metadata)
    return exports.one_inventory:GetSlotsWithItem(itemName, metadata)
end

FM_Adapter_client_inventory_one = adapter
