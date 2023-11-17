--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

Settings = {
    ---@type boolean Whether or not to print debug messages
    debug = true,
    ---@type boolean Whether or not to ignore resource not found errors
    ignoreResourceNotFoundErrors = false,
    ---@type boolean Whether or not to ignore resource initialized logs
    ignoreResourceInitializedLogs = false,
}

---@enum Defaults
---Fallbacks for when you don't specify a value
Defaults = {
    MONEY = 'money',
}

---@type table Only change these if you know what you're doing!
Resources = {
    ESX = 'es_extended',
    QB = 'qb-core',
    OXTarget = 'ox_target',
    QBTarget = 'qb-target',
    OXInv = 'ox_inventory',
    QBInv = 'qb-inventory',
}