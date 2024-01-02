FM = {}

function FM:construct()
    setmetatable({}, self)
    self.__index = self
    return self
end
exports('new', function()
    return FM:construct()
end)

if not IsDuplicityVersion() then
    RegisterNUICallback('fetchSettings', function(data, cb)
        cb({ 
            settings = Settings
        })
    end)
end