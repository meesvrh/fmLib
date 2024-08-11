--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

---@class Settings
Settings = {
    ---@type boolean Whether or not to print console.debug messages
    debug = true,
    ---@type boolean Whether or not to use sfx for web modules (overrides sfx = true in modules)
    useSfx = true,
    ---@type boolean Whether or not to ignore resource initialized logs
    ignoreResourceInitializedLogs = false,
}

---@enum Defaults
---Fallbacks for when you don't specify a value
Defaults = {
    MONEY = 'money',
    ADMIN_ESX = 'admin',
    ADMIN_QB = 'god',
}

---@enum KeyMappings
---Key mappings for the library
KeyMappings = {
    CANCEL = { mapper = 'keyboard', key = 'x' },
}

---@type table Only change these if you have changed the name of a resource
Resources = {
    ESX = { name = 'es_extended', export = 'getSharedObject' },
    QB = { name = 'qb-core', export = 'GetCoreObject' },
    OXInv = 'ox_inventory',
    QBInv = 'qb-inventory',
    QSInv = 'qs-inventory',
    PSInv = 'ps-inventory',
    MOVHUD = '17mov_Hud',
}