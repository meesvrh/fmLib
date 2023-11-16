--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

FM = {}

function FM:construct()
    setmetatable({}, self)
    self.__index = self
    return self
end
exports('new', function()
    return FM:construct()
end)