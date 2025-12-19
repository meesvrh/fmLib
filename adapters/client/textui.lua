--[[
    fmLib - TextUI Client Adapter
]]

FM = FM or {}
FM.textui = FM.textui or {}

local textuiAdapter = BaseAdapter:new('textui', 'client')

---@param text string Text to display in the UI
---@return nil
function FM.textui.show(text)
    return textuiAdapter:call('show', text)
end

---@return nil
function FM.textui.hide()
    return textuiAdapter:call('hide')
end

-- Backwards compatibility
FM.utils = FM.utils or {}

---@deprecated Use FM.textui.show instead
---@param text string Text to display
---@return nil
function FM.utils.showTextUI(text)
    Warning('FM.utils.showTextUI is deprecated, use FM.textui.show instead')
    return FM.textui.show(text)
end

---@deprecated Use FM.textui.hide instead
---@return nil
function FM.utils.hideTextUI()
    Warning('FM.utils.hideTextUI is deprecated, use FM.textui.hide instead')
    return FM.textui.hide()
end