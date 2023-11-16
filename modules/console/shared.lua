--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

FM.console = {}

---@param name? string
---@param data any
---@param indent number
local function printTable(name, data, indent)
    if not Settings.debug then return end

    local indentStr = string.rep(" ", indent or 0)
    name = name and tostring(name).."^7: " or "^7"
    print("^7(^3DEBUG^7) ^5"..indentStr..name.."{")
    indentStr = string.rep(" ", indent + 2)
    for k, v in pairs(data) do
        local valueType = type(v)

        if valueType == "table" then
            FM.debug.table(k, v, indent + 2)
        else
            print("^7(^3DEBUG^7) ^5"..indentStr..tostring(k).."^7: ^7"..tostring(v))
        end
    end
    indentStr = string.rep(" ", indent)
    print("^7(^3DEBUG^7) ^5"..indentStr.."^7}")
end

---@param data { key: string, data: any }[] | any[]
function FM.console.debug(data)
    if not Settings.debug then return end

    local lines = 0
    for k, v in pairs(data) do
        local valueType = type(v)
        if lines == 0 then print("^7(^3DEBUG^7) --------------------------------------------") end
        if k == number then print("^7(^3DEBUG^7) ^0["..string.upper(tostring(k)).."] ^7(^5"..valueType.."^7)") end
        if valueType ~= "table" then print("^7(^3DEBUG^7) ^5"..tostring(v).."^7")
        else
            printTable(nil, v, 0)
        end
        print("^7(^3DEBUG^7) --------------------------------------------")
        lines = lines+1
    end
end

---@param message string
---@param ... string[]
function FM.console.log(message, ...)
    local strF = ... and string.format(message, ...) or message
    print("^7(^5LOG^7) ^0"..strF.."^7")
end

---@param message string
---@param ... string[]
function FM.console.success(message, ...)
    local strF = ... and string.format(message, ...) or message
    print("^7(^2SUCCESS^7) ^0"..strF.."^7")
end
FM.console.suc = FM.console.success

---@param message string
---@param ... string[]
function FM.console.error(message, ...)
    local strF = ... and string.format(message, ...) or message
    print("^7(^1ERROR^7) ^0"..strF.."^7")
end
FM.console.err = FM.console.error