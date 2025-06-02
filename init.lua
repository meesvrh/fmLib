FM = {}

function Debug(str, ...)
    if not Settings.debug then return end

    if ... then
        print("^7(^3DEBUG^7) "..string.format(str, ...).."^7")
    else
        print("^7(^3DEBUG^7) "..str.."^7")
    end
end

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