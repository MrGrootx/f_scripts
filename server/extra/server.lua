ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('g_application:sendinpuData')
AddEventHandler('g_application:sendinpuData', function(source, name)
   local xPlayer = ESX.GetPlayerFromId(source)
   local indentifier = xPlayer.identifier

   MySQL.insert.await('INSERT INTO `test_db` (indentifier,username) VALUES(?,?)', {
      indentifier, name
   })

   MySQL.query.await('SELECT * FROM `test_db` ')
end)




RegisterNetEvent('g_application:getAllData')
AddEventHandler('g_application:getAllData', function()
   print('getalldata')
   local data = MySQL.fetchAll.await('SELECT * FROM `test_db`')
   print(json.encode(data))
end)
