--[[
    fmLib - Account Server Adapter
]]

FM = FM or {}
FM.account = FM.account or {}

local accountAdapter = BaseAdapter:new('account', 'server')

---@param accountName string The name of the society/shared account (e.g., 'society_police')
---@return number Balance The current balance of the account (returns 0 if account not found)
function FM.account.getMoney(accountName)
    -- Uncomment to use RxBanking if available
    -- if GetResourceState('RxBanking') == 'started' then
    --     local bankingCfg = exports['RxBanking']:GetConfig()
    --     -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
    --     -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
    --     if not bankingCfg.Society.thirdPartyAccounts then
    --         return exports['RxBanking']:GetSocietyAccount(accountName)?.balance or 0
    --     end
    -- end

    return accountAdapter:call('getMoney', accountName)
end

---@param accountName string The name of the society/shared account (e.g., 'society_police')
---@param amount number The amount of money to add
---@return boolean Success status (true if money was added successfully, false otherwise)
function FM.account.addMoney(accountName, amount)
    -- Uncomment to use RxBanking if available
    -- if GetResourceState('RxBanking') == 'started' then
    --     local bankingCfg = exports['RxBanking']:GetConfig()
    --     -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
    --     -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
    --     if not bankingCfg.Society.thirdPartyAccounts then
    --         return exports['RxBanking']:AddSocietyMoney(accountName, amount)
    --     end
    -- end

    return accountAdapter:call('addMoney', accountName, amount)
end

---@param accountName string The name of the society/shared account (e.g., 'society_police')
---@param amount number The amount of money to remove
---@return boolean Success status (true if money was removed successfully, false if insufficient funds or account not found)
function FM.account.removeMoney(accountName, amount)
    -- Uncomment to use RxBanking if available
    -- if GetResourceState('RxBanking') == 'started' then
    --     local bankingCfg = exports['RxBanking']:GetConfig()
    --     -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
    --     -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
    --     if not bankingCfg.Society.thirdPartyAccounts then
    --         return exports['RxBanking']:RemoveSocietyMoney(accountName, amount)
    --     end
    -- end

    return accountAdapter:call('removeMoney', accountName, amount)
end

-- Backwards compatibility
---@deprecated Use FM.account.getMoney instead
---@param accountName string The name of the society/shared account
---@return number Balance The current balance of the account
function FM.account.getAccountMoney(accountName)
    Warning('FM.account.getAccountMoney is deprecated, use FM.account.getMoney instead')
    return FM.account.getMoney(accountName)
end

---@deprecated Use FM.account.addMoney instead
---@param accountName string The name of the society/shared account
---@param amount number The amount of money to add
---@return boolean Success status
function FM.account.addAccountMoney(accountName, amount)
    Warning('FM.account.addAccountMoney is deprecated, use FM.account.addMoney instead')
    return FM.account.addMoney(accountName, amount)
end

---@deprecated Use FM.account.removeMoney instead
---@param accountName string The name of the society/shared account
---@param amount number The amount of money to remove
---@return boolean Success status
function FM.account.removeAccountMoney(accountName, amount)
    Warning('FM.account.removeAccountMoney is deprecated, use FM.account.removeMoney instead')
    return FM.account.removeMoney(accountName, amount)
end

-- Alias
FM.acc = FM.account