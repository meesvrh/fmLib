--[[
    fmLib - Inventory Server Adapter
]]

FM = FM or {}
FM.inventory = FM.inventory or {}

local inventoryAdapter = BaseAdapter:new('inventory', 'server')

function FM.inventory.registerUsableItem(itemName, cb)
    return FM.framework.registerUsableItem(itemName, cb)
end

function FM.inventory.getItemLabel(item)
    if not item then return end

    if inventoryAdapter:hasFunction('getItemLabel') then
        return inventoryAdapter:call('getItemLabel', item)
    else
        return FM.framework.getItemLabel(item)
    end
end

function FM.inventory.getMetaDataBySlot(inv, slot)
    return inventoryAdapter:call('getMetaDataBySlot', inv, slot)
end

function FM.inventory.getSlotIDByItem(inv, itemName)
    return inventoryAdapter:call('getSlotIDByItem', inv, itemName)
end

function FM.inventory.setMetaDataBySlot(inv, slot, metadata)
    return inventoryAdapter:call('setMetaDataBySlot', inv, slot, metadata)
end

function FM.inventory.registerStash(stash)
    return inventoryAdapter:call('registerStash', stash)
end

function FM.inventory.upgradeStash(stashId, newWeight, newSlots)
    return inventoryAdapter:call('upgradeStash', stashId, newWeight, newSlots)
end

-- Server inventory functions for player operations (inventory adapter functions need to return the same values as the player operations)
function FM.inventory.addItem(src, item, amount, metadata)
    return inventoryAdapter:call('addItem', src, item, amount, metadata)
end

function FM.inventory.addWeapon(src, weapon, ammo)
    return inventoryAdapter:call('addWeapon', src, weapon, ammo)
end

function FM.inventory.getWeapon(src, weapon)
    return inventoryAdapter:call('getWeapon', src, weapon)
end

function FM.inventory.removeWeapon(src, weapon)
    return inventoryAdapter:call('removeWeapon', src, weapon)
end

function FM.inventory.removeItem(src, item, amount, slotId, metadata)
    return inventoryAdapter:call('removeItem', src, item, amount, slotId, metadata)
end

function FM.inventory.canCarryItem(src, item, amount)
    return inventoryAdapter:call('canCarryItem', src, item, amount)
end

function FM.inventory.getItem(src, item)
    return inventoryAdapter:call('getItem', src, item)
end

function FM.inventory.getInventory(src)
    return inventoryAdapter:call('getInventory', src)
end

-- Adapter helper function
function FM.inventory.hasFunction(funcName)
    return inventoryAdapter:hasFunction(funcName)
end

-- Event registrations
RegisterNetEvent('fm:internal:openStash', function(stashId, owner, weight, slots)
    local src = source
    exports['qb-inventory']:OpenInventory(src, stashId, {
        maxweight = weight,
        slots = slots,
    })
end)

-- Compatibility bridge for older versions
FM.inventory.getSlotIDWithItem = FM.inventory.getSlotIDByItem
FM.inventory.getMetaData = FM.inventory.getMetaDataBySlot

-- Backwards compatibility alias
FM.inv = FM.inventory