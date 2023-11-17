FM = {}

function FM:construct()
    setmetatable({}, self)
    self.__index = self
    return self
end
exports('new', function()
    return FM:construct()
end)