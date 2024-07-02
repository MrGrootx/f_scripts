function alert(msg)
   BeginTextCommandDisplayHelp("STRING")
   AddTextComponentSubstringPlayerName(msg)
   EndTextCommandDisplayHelp(0, false, true, -1)
end

function notify(msg)
   BeginTextCommandThefeedPost('STRING')
   AddTextComponentSubstringPlayerName(msg)
   EndTextCommandThefeedPostTicker(true, false)
end

function giveWeapon(hash)
   GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, true)
end

function spawnCar(car)
   local car = GetHashKey(car)
   RequestModel(car)
   while not HasModelLoaded(car) do
      RequestModel(car)
      Citizen.Wait(0)
   end

   local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
   local vehicle = CreateVehicle(car, x + 3, y + 3, z + 1, 0.0, true, false)
   SetEntityAsMissionEntity(vehicle, true, true)
end

function weaponComponents(weaponghash, componenthash)
   if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weaponghash), false) then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weaponghash), GetHashKey(componenthash))
   end
end

-- Speedometer
function Text(content)
   SetTextFont(0)
   SetTextScale(1.5, 1.5)
   SetTextProportional(0)
   BeginTextCommandDisplayText("STRING")
   AddTextComponentSubstringPlayerName(content)
   DrawText(0.9, 0.7)
end
