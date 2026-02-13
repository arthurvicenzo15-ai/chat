local selectedKit = 'ak'

local function equipKit(kitName)
  local kit = Config.Kits[kitName]
  if not kit then
    TriggerEvent('chat:addMessage', { args = { '^1Academy', 'Kit inválido.' } })
    return
  end

  local ped = PlayerPedId()
  RemoveAllPedWeapons(ped, true)

  for _, entry in ipairs(kit) do
    local weaponHash = joaat(entry.weapon)
    GiveWeaponToPed(ped, weaponHash, entry.ammo, false, true)
  end

  selectedKit = kitName
  TriggerEvent('chat:addMessage', { args = { '^2Academy', ('Kit equipado: %s'):format(kitName) } })
end

RegisterNetEvent('academy:client:spawnArena', function()
  local ped = PlayerPedId()
  local spawn = Config.Spawn

  SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false)
  SetEntityHeading(ped, spawn.w)
  NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.w, true, true, false)
  SetEntityHealth(ped, 200)
  SetPedArmour(ped, 100)

  Wait(250)
  equipKit(selectedKit)
end)

RegisterCommand('kit', function(_, args)
  local kitName = args[1]
  if not kitName then
    TriggerEvent('chat:addMessage', { args = { '^3Uso', '/kit ak|m4|smg|sniper' } })
    return
  end

  equipKit(kitName)
end)

RegisterCommand('stats', function()
  TriggerServerEvent('academy:server:requestStats')
end)

RegisterNetEvent('academy:client:showStats', function(data)
  TriggerEvent('chat:addMessage', {
    args = {
      '^5Academy',
      ('Kills: %s | Deaths: %s | K/D: %.2f'):format(data.kills, data.deaths, data.kd)
    }
  })
end)

AddEventHandler('playerSpawned', function()
  TriggerEvent('academy:client:spawnArena')
end)
