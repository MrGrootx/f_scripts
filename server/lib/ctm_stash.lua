local stash = {
   id = '42wallabyway',
   label = '42 Wallaby Way',
   slots = 50,
   weight = 100000,
   owner = 'char1:604011b17a63a88dab1a0f3ff945277851b40e25'
}

AddEventHandler('onServerResourceStart', function(resourceName)
   if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
      exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
   end
end)

