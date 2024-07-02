RegisterCommand('clearctm', function()
   RemoveAllPedWeapons(GetPlayerPed(-1), true)
   notify("~r~ Clear all weapons")
end, false)


Citizen.CreateThread(function()
   local h_key = 74
   local x_key = 73

   while true do
      Citizen.Wait(1)
      if IsControlJustReleased(1, h_key) then
         giveWeapon('weapon_pistol')
         giveWeapon('weapon_knife')
         giveWeapon('weapon_pumpshortgun')
         weaponComponents('weapon_pumpshortgun', 'COMMPONENT_AT_SR_SUPP')
         alert("~b~ Given Weapons with ~INPUT_VEH_HEADLIGHT~")
      end
   end
end)
