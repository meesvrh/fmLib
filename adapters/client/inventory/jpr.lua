local adapter = {}

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
end

FM_Adapter_client_inventory_jpr = adapter