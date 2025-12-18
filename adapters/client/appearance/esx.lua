local adapter = {}

function adapter.openWardrobe(propertyId)
    TriggerEvent('esx_skin:openSaveableMenu')
end

function adapter.setOutfit(clothingData)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadClothes', skin, clothingData)
    end)
end

function adapter.loadSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)
end

FM_Adapter_client_appearance_esx = adapter