--[[
   To convert to MPH: speed * 2.236936
   To convert to KPH: speed * 3.6
]]


Citizen.CreateThread(function()
   while true do
      Citizen.Wait(2)
      local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6

      if IsPedInAnyVehicle(PlayerPedId(), false) then
         Text(math.floor(speed))
      end
   end
end)
