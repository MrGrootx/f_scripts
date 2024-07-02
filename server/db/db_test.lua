ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterCommand({ 'dbtest' }, 'user', function(xPlayer, args, showError)
   local indentifier = 121212
   local username = "Groot"
   local testData = MySQL.insert.await('INSERT `test_db` (indentifier, username) VALUES (?,?)', {
      indentifier, username
   })
   print(testData)
end, false)
