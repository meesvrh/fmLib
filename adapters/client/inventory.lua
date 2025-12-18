--[[
    fmLib - Inventory Client Adapter
]]

FM = FM or {}
FM.inventory = FM.inventory or {}

local inventoryAdapter = BaseAdapter:new('inventory', 'client')

function FM.inventory.open(type, id)
    return inventoryAdapter:call('open', type, id)
end

function FM.inventory.openStash(stashId, owner, weight, slots)
    return inventoryAdapter:call('openStash', stashId, owner, weight, slots)
end

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

function FM.inventory.getItems()
    if inventoryAdapter:hasFunction('getItems') then
        return inventoryAdapter:call('getItems')
    else
        return FM.framework.getItems()
    end
end

function FM.inventory.displayMetadata(metadata)
    return inventoryAdapter:call('displayMetadata', metadata)
end

function FM.inventory.setWeaponWheel(state)
    return inventoryAdapter:call('setWeaponWheel', state)
end

function FM.inventory.hasItem(item)
    if inventoryAdapter:hasFunction('hasItem') then
        return inventoryAdapter:call('hasItem', item)
    else
        return FM.framework.hasItem(item)
    end
end

-- Backwards compatibility alias
FM.inv = FM.inventory