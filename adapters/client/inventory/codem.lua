local adapter = {}

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, {
        maxweight = weight,
        slots = slots,
    })
    TriggerEvent('inventory:client:SetCurrentStash', stashId)
end

FM_Adapter_client_inventory_codem = adapter