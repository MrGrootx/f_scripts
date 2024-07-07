ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('savesql', function(source, args, raw)
   local name, role = args[1], args[2]

   local xPlayer = ESX.GetPlayerFromId(source)
   local indentifier = xPlayer.identifier

   MySQL.insert(
      'INSERT INTO groot_learn (identifier,name,role) VALUES(?,?,?) ON DUPLICATE KEY UPDATE name = ? , role = ?', {
         indentifier, name, role, name, role
      }, function(data)
         print('datas saved successfully')
         -- MySQL.query('SELECT * FROM `groot_learn` ')
      end)
end, false)


RegisterCommand('getsql', function(source, args, raw)
   local xPlayer = ESX.GetPlayerFromId(source)
   local indentifier = xPlayer.identifier
end, false)

RegisterCommand('updatesql', function(source, args, raw)
   if not args[1] then
      return print('Please provide an argument')
   end
   local xPlayer = ESX.GetPlayerFromId(source)
   local indentifier = xPlayer.identifier

   local data = MySQL.update.await('UPDATE groot_learn SET role = ? WHERE identifier = ? ', {
      args[1],
      indentifier
   })

   print(data)
end, false)

RegisterCommand('checkuser', function(source, args, raw)
   if not args[1] then print('Please provide an argument') end

   local identifier = args[1]

   local data = MySQL.query.await("SELECT * FROM groot_learn WHERE identifier = ?", {
      identifier
   })


   if data and #data > 0 then
      print(json.encode(data))
   else
      MySQL.insert.await("INSERT INTO groot_learn (identifier, name, role) VALUES (?, ?, ?)", {
         identifier,
         'Groot4',
         'admin4'
      })
   end
end, false)
