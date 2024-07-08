ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('ctmradio', function()
   exports["pma-voice"]:setRadioChannel(1)
end, false)


RegisterCommand('ctmradioremove', function()
   exports['pma-voice']:removePlayerFromRadio(GetPlayerServerId(PlayerId()))
end, false)
