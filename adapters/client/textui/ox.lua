local adapter = {}

function adapter.show(text)
    OXLib:showTextUI(text)
end

function adapter.hide()
    OXLib:hideTextUI()
end

FM_Adapter_client_textui_ox = adapter