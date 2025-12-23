local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.getMoney(accountName)
    return exports[resourceName]:GetAccount(accountName) or 0
end

function adapter.addMoney(accountName, amount)
    return exports[resourceName]:AddMoney(accountName, amount)
end

function adapter.removeMoney(accountName, amount)
    return exports[resourceName]:RemoveMoney(accountName, amount)
end

FM_Adapter_server_account_qbmanagement = adapter