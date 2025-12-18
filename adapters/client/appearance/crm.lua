local adapter = {}

function adapter.openWardrobe(propertyId)
    TriggerEvent('crm-appearance:show-outfits')
end

FM_Adapter_client_appearance_crm = adapter