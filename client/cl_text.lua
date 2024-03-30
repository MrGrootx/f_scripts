local color = {
   r = 247,
   b = 223,
   g = 88,
   a = 255
}

Citizen.CreateThread(function()
   while true do
      -- text
      Citizen.Wait(5)
      SetTextFont(0)
      SetTextScale(0.4, 0.4)
      SetTextColour(color.r, color.b, color.g, color.a)
      BeginTextCommandDisplayText("STRING")
      AddTextComponentSubstringPlayerName("HEY IAM JUSTGROOT")
      EndTextCommandDisplayText(0.0001, 0.0001)

      -- Rectangle
      DrawRect(150, 100, 3.2, 0.05, 66, 134, 224, 245)
   end
end)
