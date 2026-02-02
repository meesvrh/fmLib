local adapter = {}

local function isNewQBInv()
    local version = GetResourceMetadata('qb-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

function adapter.open(type, id)
    if not type or not id then return end

    TriggerServerEvent("inventory:server:OpenInventory", type, id)
end

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    if isNewQBInv() then
        TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, {
            maxweight = weight,
            slots = slots,
        })
        TriggerEvent('inventory:client:SetCurrentStash', stashId)
    end
end

function adapter.getImgDirectory()
    return 'qb-inventory/html/images/'
end

FM_Adapter_client_inventory_qb = adapter