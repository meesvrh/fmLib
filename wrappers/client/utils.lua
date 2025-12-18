-- FM.utils = {}

-- MIGRATED TO ADAPTER PATTERN: adapters/client/framework.lua (FM.framework.notify)
---@param message string
---@param type? 'error'|'success'
-- function FM.utils.notify(message, type)
--     if not message then return end

--     if ESX then ESX.ShowNotification(message, type)
--     elseif QB then QB.Functions.Notify(message, type) end
-- end

-- MIGRATED TO ADAPTER PATTERN: adapters/client/textui.lua (FM.textui.show/hide)
-- function FM.utils.showTextUI(text)
--     if JGTextUI then
--         JGTextUI:DrawText(text)
--     elseif OKOKTextUI then
--         OKOKTextUI:Open(text, 'lightred', 'left', true)
--     elseif OXLib then
--         OXLib:showTextUI(text)
--     end
-- end

-- function FM.utils.hideTextUI()
--     if JGTextUI then
--         JGTextUI:HideText()
--     elseif OKOKTextUI then
--         OKOKTextUI:Close()
--     elseif OXLib then
--         OXLib:hideTextUI()
--     end
-- end