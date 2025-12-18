local adapter = {}

local function isNewPSInv()
    local version = GetResourceMetadata('ps-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    if isNewPSInv() then
        TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, {
            maxweight = weight,
            slots = slots,
        })
        TriggerEvent('inventory:client:SetCurrentStash', stashId)
    end
end

FM_Adapter_client_inventory_ps = adapter