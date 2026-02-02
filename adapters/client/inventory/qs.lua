local adapter = {}

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    QSInv:RegisterStash(stashId, slots, weight)

    TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, {
        maxweight = weight,
        slots = slots,
    })
    TriggerEvent('inventory:client:SetCurrentStash', stashId)
end

function adapter.setWeaponWheel(state)
    QSInv:WeaponWheel(state)
end

function adapter.getImgDirectory()
    return 'qs-inventory/html/images/'
end

FM_Adapter_client_inventory_qs = adapter