local adapter = {}

function adapter.show(text)
    JGTextUI:DrawText(text)
end

function adapter.hide()
    JGTextUI:HideText()
end

FM_Adapter_client_textui_jg = adapter