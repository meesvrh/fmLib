local adapter = {}

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    OXInv:openInventory('stash', { id = stashId, owner = owner })
end

function adapter.getItems()
    local inventory = {}
    local items = OXInv:GetPlayerItems()

    for slot, item in pairs(items) do
        inventory[slot] = {
            name = item.name,
            label = item.label,
            amount = item.count
        }
    end

    return inventory
end

function adapter.displayMetadata(metadata)
    OXInv:displayMetadata(metadata)
end

function adapter.setWeaponWheel(state)
    OXInv:weaponWheel(state)
end

FM_Adapter_client_inventory_ox = adapter