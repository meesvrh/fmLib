local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.show(text)
    exports[resourceName]:showTextUI(text)
end

function adapter.hide()
    exports[resourceName]:hideTextUI()
end

FM_Adapter_client_textui_ox = adapter