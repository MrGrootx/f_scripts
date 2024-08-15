RegisterCommand('createtable', function()
   local heading = 0
   local obj
   local created = false
   local model = 'gr_prop_gr_bench_02a'
   lib.requestModel(model)
   
   CreateThread(function()
       while true do
           ---@diagnostic disable-next-line: need-check-nil
           local hit, coords, entity = RayCastGamePlayCamera(100.0)

           if not created then
               created = true
               obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
               SetEntityCollision(obj, false, true)
           end

           if IsControlPressed(0, 174) then
               heading = heading + 1.5
           end

           if IsControlPressed(0, 175) then
               heading = heading - 1.5
           end

           if IsDisabledControlPressed(0, 176) then
               local new_position = vector4(coords.x, coords.y, coords.z, heading)
               DeleteObject(obj)
               Wait(100)
               -- lib.hideTextUI()

               local propobj = CreateObject(model, new_position, false, true)
               SetEntityHeading(propobj, new_position.w) -- using .w for heading
               FreezeEntityPosition(propobj, true)
               SetEntityInvincible(propobj, true)
               SetModelAsNoLongerNeeded(model)
               PlaceObjectOnGroundProperly(propobj)

               created = false
               obj = nil
               heading = 0
           end

           -- Cancellation logic
           if IsControlPressed(0, 177) then  -- '177' is usually the BACKSPACE key
               if created then
                   DeleteObject(obj)
                   created = false
                   obj = nil
                   heading = 0
               end
           end

           local pedPos = GetEntityCoords(cache.ped)
           local distance = #(coords - pedPos)

           if distance <= 3.5 then
               SetEntityCoords(obj, coords.x, coords.y, coords.z)
               SetEntityHeading(obj, heading)
           end
           Wait(0)
       end
   end)
end, false)


-- Thanks to quantumdevelopment69
function RotationToDirection(rotation)
   local adjustedRotation =
   {
       x = (math.pi / 180) * rotation.x,
       y = (math.pi / 180) * rotation.y,
       z = (math.pi / 180) * rotation.z
   }
   local direction =
   {
       x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
       y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
       z = math.sin(adjustedRotation.x)
   }

   return direction
end

function RayCastGamePlayCamera(distance)
   local cameraRotation = GetGameplayCamRot(0)
   local cameraCoord = GetGameplayCamCoord()
   local direction = RotationToDirection(cameraRotation)
   local destination =
   {
       x = cameraCoord.x + direction.x * distance,
       y = cameraCoord.y + direction.y * distance,
       z = cameraCoord.z + direction.z * distance
   }
   local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x,
       destination.y, destination.z, -1, cache.ped, 0))

   return b, c, e
end
