-- FM.account = {}

-- ---@param accountName string
-- ---@return number
-- function FM.account.getAccountMoney(accountName)
--     if GetResourceState(Resources.RX_BANKING.name) == 'started' then
--         local bankingCfg = exports[Resources.RX_BANKING.name]:GetConfig()
--         -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
--         -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
--         if not bankingCfg.Society.thirdPartyAccounts then
--             return exports[Resources.RX_BANKING.name]:GetSocietyAccount(accountName)?.balance or 0
--         end
--     end

--     if ADDON_ACCOUNT then
--         local p = promise.new()

--         TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
--             if not acc then
--                 Debug("(account.getAccountMoney) Account '%s' not found", accountName)
--                 p:resolve(0)
--                 return
--             end

--             p:resolve(acc.money)
--         end)

--         return Citizen.Await(p)
--     elseif QB_MANAGEMENT then
--         return QB_MANAGEMENT:GetAccount(accountName) or 0
--     end

--     Debug("(account.getAccountMoney) Missing compatibility")
--     return 0
-- end

-- ---@param accountName string
-- ---@param amount number
-- ---@return boolean
-- function FM.account.addAccountMoney(accountName, amount)
--     if GetResourceState(Resources.RX_BANKING.name) == 'started' then
--         local bankingCfg = exports[Resources.RX_BANKING.name]:GetConfig()
--         -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
--         -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
--         if not bankingCfg.Society.thirdPartyAccounts then
--             return exports[Resources.RX_BANKING.name]:AddSocietyMoney(accountName, amount)
--         end
--     end

--     if ADDON_ACCOUNT then
--         local p = promise.new()

--         TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
--             if not acc then
--                 Debug("(account.addAccountMoney) Account '%s' not found", accountName)
--                 p:resolve(false)
--                 return
--             end

--             acc.addMoney(amount)
--             p:resolve(true)
--         end)

--         return Citizen.Await(p)
--     elseif QB_MANAGEMENT then
--         return QB_MANAGEMENT:AddMoney(accountName, amount)
--     end

--     Debug("(account.addAccountMoney) Missing compatibility")
--     return false
-- end

-- ---@param accountName string
-- ---@param amount number
-- ---@return boolean
-- function FM.account.removeAccountMoney(accountName, amount)
--     if GetResourceState(Resources.RX_BANKING.name) == 'started' then
--         local bankingCfg = exports[Resources.RX_BANKING.name]:GetConfig()
--         -- If RxBanking is using thirdPartyAccounts, it will call this function again, causing a loop, as it uses esx_addonaccount or qb-management in that case.
--         -- This check is to make sure we only use RxBanking if it's managing the society accounts itself.
--         if not bankingCfg.Society.thirdPartyAccounts then
--             return exports[Resources.RX_BANKING.name]:RemoveSocietyMoney(accountName, amount)
--         end
--     end

--     if ADDON_ACCOUNT then
--         local p = promise.new()

--         TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(acc)
--             if not acc then
--                 Debug("(account.removeAccountMoney) Account '%s' not found", accountName)
--                 p:resolve(false)
--                 return
--             end

--             if acc.money >= amount then
--                 acc.removeMoney(amount)
--                 p:resolve(true)
--             else
--                 Debug("(account.removeAccountMoney) Not enough money in account '%s' to remove %s", accountName, amount)
--                 p:resolve(false)
--             end
--         end)

--         return Citizen.Await(p)
--     elseif QB_MANAGEMENT then
--         return QB_MANAGEMENT:RemoveMoney(accountName, amount)
--     end

--     Debug("(account.removeAccountMoney) Missing compatibility")
--     return false
-- end

-- -- Aliases
-- FM.acc = FM.account