--[[
    fmLib - Inventory Server Adapter
]]

FM = FM or {}
FM.inventory = FM.inventory or {}

local inventoryAdapter = BaseAdapter:new('inventory', 'server')

---@param itemName string The name of the item to register as usable
---@param cb function Callback function(src, item) called when item is used
---@return nil
function FM.inventory.registerUsableItem(itemName, cb)
    return FM.framework.registerUsableItem(itemName, cb)
end

---@param item string The item name to get the label for
---@return string|nil label The display label for the item (Note: May not work for weapons in ESX & OX inventory)
function FM.inventory.getItemLabel(item)
    if not item then return end

    if inventoryAdapter:hasFunction('getItemLabel') then
        return inventoryAdapter:call('getItemLabel', item)
    else
        return FM.framework.getItemLabel(item)
    end
end

---@param inv string|number Inventory identifier (player source or inventory name)
---@param slot number The slot number to get metadata from
---@return table|nil metadata The item metadata at the specified slot, or nil if not found
function FM.inventory.getMetaDataBySlot(inv, slot)
    return inventoryAdapter:call('getMetaDataBySlot', inv, slot)
end

---@param inv string|number Inventory identifier (player source or inventory name)
---@param itemName string The item name to find
---@return number|nil slot The first slot containing the item, or nil if not found
function FM.inventory.getSlotIDByItem(inv, itemName)
    return inventoryAdapter:call('getSlotIDByItem', inv, itemName)
end

---@param inv string|number Inventory identifier (player source or inventory name)
---@param slot number The slot number to update
---@param metadata table The new metadata to set
---@return boolean|nil success Success status, or nil if not supported
function FM.inventory.setMetaDataBySlot(inv, slot, metadata)
    return inventoryAdapter:call('setMetaDataBySlot', inv, slot, metadata)
end

---@param stash { id: string|number, label: string, slots: number, weight: number, owner?: string|boolean, groups?: table, coords?: vector3|vector3[] } Stash configuration (mainly for ox-inventory)
---@return nil
function FM.inventory.registerStash(stash)
    return inventoryAdapter:call('registerStash', stash)
end

---@param stashId string|number The stash identifier to upgrade
---@param newWeight? number New weight limit (optional)
---@param newSlots? number New slot count (optional)
---@return nil
function FM.inventory.upgradeStash(stashId, newWeight, newSlots)
    return inventoryAdapter:call('upgradeStash', stashId, newWeight, newSlots)
end

-- Server inventory functions for player operations (inventory adapter functions need to return the same values as the player operations)

---@param src number Player source ID
---@param item string Item name to add
---@param amount number Amount to add
---@param metadata? table Optional item metadata
---@return boolean success True if item was added successfully
function FM.inventory.addItem(src, item, amount, metadata)
    return inventoryAdapter:call('addItem', src, item, amount, metadata)
end

---@param src number Player source ID
---@param weapon string Weapon name to add
---@param ammo? number Ammo count (default 0)
---@return boolean success True if weapon was added successfully
function FM.inventory.addWeapon(src, weapon, ammo)
    return inventoryAdapter:call('addWeapon', src, weapon, ammo)
end

---@param src number Player source ID
---@param weapon string Weapon name to get
---@return { name: string, ammo: number, count: number }|nil weapon Weapon data or nil if not found
function FM.inventory.getWeapon(src, weapon)
    return inventoryAdapter:call('getWeapon', src, weapon)
end

---@param src number Player source ID
---@param weapon string Weapon name to remove
---@return boolean success True if weapon was removed successfully
function FM.inventory.removeWeapon(src, weapon)
    return inventoryAdapter:call('removeWeapon', src, weapon)
end

---@param src number Player source ID
---@param item string Item name to remove
---@param amount number Amount to remove
---@param slotId? number Specific slot to remove from (optional)
---@param metadata? table Specific metadata to match (optional)
---@return boolean success True if item was removed successfully
function FM.inventory.removeItem(src, item, amount, slotId, metadata)
    return inventoryAdapter:call('removeItem', src, item, amount, slotId, metadata)
end

---@param src number Player source ID
---@param item string Item name to check
---@param amount number Amount to check
---@return boolean canCarry True if player can carry the specified amount
function FM.inventory.canCarryItem(src, item, amount)
    return inventoryAdapter:call('canCarryItem', src, item, amount)
end

---@param src number Player source ID
---@param item string Item name to get
---@return { name: string, label: string, amount: number }|nil item Item data or nil if not found
function FM.inventory.getItem(src, item)
    return inventoryAdapter:call('getItem', src, item)
end

---@param src number Player source ID
---@return table<number, { name: string, label: string, amount: number, metadata?: table }> inventory Table of items indexed by slot
function FM.inventory.getInventory(src)
    return inventoryAdapter:call('getInventory', src)
end

-- Adapter helper function
---@param funcName string Function name to check
---@return boolean hasFunction True if the adapter has this function
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