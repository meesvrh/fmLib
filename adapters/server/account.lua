--[[
    fmLib - Account Server Adapter
]]

FM = FM or {}
FM.account = FM.account or {}

local accountAdapter = BaseAdapter:new('account', 'server')

function FM.account.getMoney(accountName)
    if GetResourceState('RxBanking') == 'started' then
        local bankingCfg = exports['RxBanking']:GetConfig()
        -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
        -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
        if not bankingCfg.Society.thirdPartyAccounts then
            return exports['RxBanking']:GetSocietyAccount(accountName)?.balance or 0
        end
    end

    return accountAdapter:call('getMoney', accountName)
end

function FM.account.addMoney(accountName, amount)
    if GetResourceState('RxBanking') == 'started' then
        local bankingCfg = exports['RxBanking']:GetConfig()
        -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
        -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
        if not bankingCfg.Society.thirdPartyAccounts then
            return exports['RxBanking']:AddSocietyMoney(accountName, amount)
        end
    end

    return accountAdapter:call('addMoney', accountName, amount)
end

function FM.account.removeMoney(accountName, amount)
    if GetResourceState('RxBanking') == 'started' then
        local bankingCfg = exports['RxBanking']:GetConfig()
        -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
        -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
        if not bankingCfg.Society.thirdPartyAccounts then
            return exports['RxBanking']:RemoveSocietyMoney(accountName, amount)
        end
    end

    return accountAdapter:call('removeMoney', accountName, amount)
end

-- Backwards compatibility
function FM.account.getAccountMoney(accountName)
    Warning('FM.account.getAccountMoney is deprecated, use FM.account.getMoney instead')
    return FM.account.getMoney(accountName)
end

function FM.account.addAccountMoney(accountName, amount)
    Warning('FM.account.addAccountMoney is deprecated, use FM.account.addMoney instead')
    return FM.account.addMoney(accountName, amount)
end

function FM.account.removeAccountMoney(accountName, amount)
    Warning('FM.account.removeAccountMoney is deprecated, use FM.account.removeMoney instead')
    return FM.account.removeMoney(accountName, amount)
end

-- Alias
FM.acc = FM.account