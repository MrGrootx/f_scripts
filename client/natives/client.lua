Boxes = {}
BoxCreated = false
BoxInHand = false
CurrentBox = 0
BoxPacking = false

RegisterCommand('getobject', function()
   local playerPed = PlayerPedId()
   local playerCoords = GetEntityCoords(playerPed)
   if not BoxCreated then
      BoxCreated = true
      local coords = vector3(278.9416, -9.0310, 78.5658)
      local val, zGround = GetGroundZFor_3dCoord(278.9416, -9.0310, 78.5658, true)
      Boxes[1] = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, zGround + 0.70, true, true, true)
      Boxes[2] = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, zGround + 0.35, true, true, true)
      Boxes[3] = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, zGround, true, true, true)
      print("Boxes created at coordinates: " .. coords.x .. ", " .. coords.y .. ", " .. zGround)
   end
   AddBoxToPlayer()
end, false)

Citizen.CreateThread(function()
   while false do
      local sleep = 2000
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)

      if IsControlJustReleased(1, 38) then
         print("Pressed E")
         local missionTruck = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 20.0, 0, 70)
         if DoesEntityExist(missionTruck) then
            local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(missionTruck), playerCoords, true)
            print("Vehicle found at distance: " .. vehicleDistance)

            if vehicleDistance <= 20.0 then
               print("Near vehicle")
               -- RemoveBlip(MissionBlip)

               SetVehicleDoorOpen(missionTruck, 3, false, false)
               SetVehicleDoorOpen(missionTruck, 2, false, false)

               CurrentBox = CurrentBox + 1
               AddBoxToPlayer()
               BoxPacking = true
               BoxInHand = true
            else
               print("Not near the vehicle")
            end
         else
            print("No vehicle found nearby")
         end
      end
      Citizen.Wait(sleep)
   end
end)

function AddBoxToPlayer()
   loadAnimDict("anim@heists@box_carry@")
   TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
   AttachEntityToEntity(Boxes[CurrentBox], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0,
      250.0, 20.0, true, true, false, true, 1, true)
   print("Box attached to player")
end

function loadAnimDict(dict)
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
      Citizen.Wait(10)
   end
   print("Animation dictionary loaded: " .. dict)
end
