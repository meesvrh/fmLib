local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.show(text)
    exports[resourceName]:Open(text, 'lightred', 'left', true)
end

function adapter.hide()
    exports[resourceName]:Close()
end

FM_Adapter_client_textui_okok = adapter