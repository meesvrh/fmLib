FM.account = {}

---@param accountName string
---@return number
function FM.account.getAccountMoney(accountName)
    if ADDON_ACCOUNT then
        local p = promise.new()

        TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
            if not acc then
                Debug("(account.getAccountMoney) Account '%s' not found", accountName)
                p:resolve(0)
                return
            end

            p:resolve(acc.money)
        end)

        return Citizen.Await(p)
    elseif QB_MANAGEMENT then
        return QB_MANAGEMENT:GetAccount(accountName) or 0
    end

    Debug("(account.getAccountMoney) Missing compatibility")
    return 0
end

---@param accountName string
---@param amount number
---@return boolean
function FM.account.addAccountMoney(accountName, amount)
    if ADDON_ACCOUNT then
        local p = promise.new()

        TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
            if not acc then
                Debug("(account.addAccountMoney) Account '%s' not found", accountName)
                p:resolve(false)
                return
            end

            acc.addMoney(amount)
            p:resolve(true)
        end)

        return Citizen.Await(p)
    elseif QB_MANAGEMENT then
        return QB_MANAGEMENT:AddMoney(accountName, amount)
    end

    Debug("(account.addAccountMoney) Missing compatibility")
    return false
end

---@param accountName string
---@param amount number
---@return boolean
function FM.account.removeAccountMoney(accountName, amount)
    if ADDON_ACCOUNT then
        local p = promise.new()

        TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
            if not acc then
                Debug("(account.removeAccountMoney) Account '%s' not found", accountName)
                p:resolve(false)
                return
            end

            if acc.money >= amount then
                acc.removeMoney(amount)
                p:resolve(true)
            else
                Debug("(account.removeAccountMoney) Not enough money in account '%s' to remove %s", accountName, amount)
                p:resolve(false)
            end
        end)

        return Citizen.Await(p)
    elseif QB_MANAGEMENT then
        return QB_MANAGEMENT:RemoveMoney(accountName, amount)
    end

    Debug("(account.removeAccountMoney) Missing compatibility")
    return false
end

-- Aliases
FM.acc = FM.account