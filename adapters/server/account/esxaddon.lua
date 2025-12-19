local adapter = {}

function adapter.getMoney(accountName)
    local p = promise.new()

    TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
        if not acc then
            Debug("(account.getMoney) Account '%s' not found", accountName)
            p:resolve(0)
            return
        end

        p:resolve(acc.money)
    end)

    return Citizen.Await(p)
end

function adapter.addMoney(accountName, amount)
    local p = promise.new()

    TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
        if not acc then
            Debug("(account.addMoney) Account '%s' not found", accountName)
            p:resolve(false)
            return
        end

        acc.addMoney(amount)
        p:resolve(true)
    end)

    return Citizen.Await(p)
end

function adapter.removeMoney(accountName, amount)
    local p = promise.new()

    TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
        if not acc then
            Debug("(account.removeMoney) Account '%s' not found", accountName)
            p:resolve(false)
            return
        end

        if acc.money >= amount then
            acc.removeMoney(amount)
            p:resolve(true)
        else
            Debug("(account.removeMoney) Not enough money in account '%s' to remove %s", accountName, amount)
            p:resolve(false)
        end
    end)

    return Citizen.Await(p)
end

FM_Adapter_server_account_esxaddon = adapter