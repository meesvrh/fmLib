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

    exports[resourceName]:openInventory(stashId)
end

function adapter.getItems()
    local inventory = {}
    local inv = exports[resourceName]:getInventory()

    if inv and inv.items then
        for slot, item in pairs(inv.items) do
            inventory[slot] = {
                name = item.name,
                label = exports[resourceName]:getItemLabel(item.name) or item.name,
                amount = item.count
            }
        end
    end


    return inventory
end

function adapter.setWeaponWheel(state)
    exports[resourceName]:setWeaponWheel(state)
end

FM_Adapter_client_inventory_jaksam = adapter