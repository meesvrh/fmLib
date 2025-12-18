local adapter = {}

function adapter.show(text)
    OKOKTextUI:Open(text, 'lightred', 'left', true)
end

function adapter.hide()
    OKOKTextUI:Close()
end

FM_Adapter_client_textui_okok = adapter