--[[
    fmLib - Inventory Server Adapter
]]

FM = FM or {}
FM.inventory = FM.inventory or {}

local inventoryAdapter = BaseAdapter:new('inventory', 'server')

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

-- Backwards compatibility alias
FM.inv = FM.inventory