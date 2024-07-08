local cache = { resource = GetCurrentResourceName(), ped = PlayerPedId(), coords = GetEntityCoords(PlayerPedId()) }
local bags = {}

RegisterCommand('spawnmedbad', function()
   local model = 'xm_prop_x17_bag_med_01a'
   lib.requestModel(model,500)


   local animDict = 'random@domestic'
   lib.requestAnimDict(animDict, 500)

   local pedcoords = GetEntityCoords(cache.ped)
   PlayAnim(cache.ped, animDict, 'pickup_low', 8.0, 8.0, 5000, 50, 0, 0, 0, 0)
   Wait(200) 
   local bag = CreateObject(GetHashKey(model), pedcoords.x, pedcoords.y, pedcoords.z - 1, true, true, true)
   SetEntityHeading(bag, GetEntityHeading(cache.ped))
   PlaceObjectOnGroundProperly(bag)
   table.insert(bags, bag)
   SetEntityAsMissionEntity(bag, true, true)
end, false)

function PlayAnim(ped, animDictionary, animationName, blendInSpeed, blendOutSpeed, duration, animFlags, startPhase, phaseControlled, controlFlags, overrideCloneUpdate)
   if not HasAnimDictLoaded(animDictionary) then
      print('Animation dictionary not found: ' .. animDictionary)
      return
   end

   TaskPlayAnim(ped, animDictionary, animationName, blendInSpeed, blendOutSpeed, duration, animFlags, startPhase, phaseControlled, controlFlags, overrideCloneUpdate)
   RemoveAnimDict(animDictionary)
end

AddEventHandler("onResourceStop", function(resourceName)
   if resourceName == cache.resource then
      for _, bagId in ipairs(bags) do
         if DoesEntityExist(bagId) then
            DeleteEntity(bagId)
         end
      end
   end
end)
