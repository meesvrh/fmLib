--[[
    fmLib - Inventory Client Adapter
]]

FM = FM or {}
FM.inventory = FM.inventory or {}

local inventoryAdapter = BaseAdapter:new('inventory', 'client')

---@param type 'otherplayer'|'shop'|'stash'|'drop' Inventory type to open (currently only 'otherplayer' supported for qb-inventory)
---@param id string|number Target identifier (player ID for otherplayer, shop name, etc.)
---@return nil
function FM.inventory.open(type, id)
    return inventoryAdapter:call('open', type, id)
end

---@param stashId string|number Unique stash identifier
---@param owner? string|boolean Owner identifier or true for player-owned (optional)
---@param weight? number Maximum weight capacity (optional, default varies by inventory)
---@param slots? number Number of slots (optional, default varies by inventory)
---@return nil
function FM.inventory.openStash(stashId, owner, weight, slots)
    return inventoryAdapter:call('openStash', stashId, owner, weight, slots)
end

---@return table<string, number> amounts Table of item names to total amounts (combines all slots)
function FM.inventory.getItemsAmounts()
    if inventoryAdapter:hasFunction('getItemsAmounts') then
        return inventoryAdapter:call('getItemsAmounts')
    else
        local items = FM.inventory.getItems()
        local amounts = {}

        for slot, item in pairs(items) do
            if amounts[item.name] then
                amounts[item.name] = amounts[item.name] + item.amount
            else
                amounts[item.name] = item.amount
            end
        end

        return amounts
    end
end

---@return table<number, { name: string, label: string, amount: number, metadata?: table }> items Table of items indexed by slot
function FM.inventory.getItems()
    if inventoryAdapter:hasFunction('getItems') then
        return inventoryAdapter:call('getItems')
    else
        return FM.framework.getItems()
    end
end

---@param metadata table Item metadata to display in UI
---@return nil
function FM.inventory.displayMetadata(metadata)
    return inventoryAdapter:call('displayMetadata', metadata)
end

---@param state boolean Enable (true) or disable (false) weapon wheel
---@return nil
function FM.inventory.setWeaponWheel(state)
    return inventoryAdapter:call('setWeaponWheel', state)
end

---@param item string Item name to check
---@return boolean hasItem True if player has the item
function FM.inventory.hasItem(item)
    if inventoryAdapter:hasFunction('hasItem') then
        return inventoryAdapter:call('hasItem', item)
    else
        return FM.framework.hasItem(item)
    end
end

function FM.inventory.getImgDirectory()
    return inventoryAdapter:call('getImgDirectory')
end

-- Backwards compatibility alias
FM.inv = FM.inventory