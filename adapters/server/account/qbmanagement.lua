local adapter = {}

function adapter.getMoney(accountName)
    return exports['qb-management']:GetAccount(accountName) or 0
end

function adapter.addMoney(accountName, amount)
    return exports['qb-management']:AddMoney(accountName, amount)
end

function adapter.removeMoney(accountName, amount)
    return exports['qb-management']:RemoveMoney(accountName, amount)
end

FM_Adapter_server_account_qbmanagement = adapter