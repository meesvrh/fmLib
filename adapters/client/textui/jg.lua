local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.show(text)
    exports[resourceName]:DrawText(text)
end

function adapter.hide()
    exports[resourceName]:HideText()
end

FM_Adapter_client_textui_jg = adapter