local lastHealth = 0

CreateThread(function()
  while true do
    local ped = PlayerPedId()
    if DoesEntityExist(ped) then
      lastHealth = GetEntityHealth(ped)
    end
    Wait(500)
  end
end)

AddEventHandler('gameEventTriggered', function(eventName, args)
  if eventName ~= 'CEventNetworkEntityDamage' then
    return
  end

  local victim = args[1]
  local attacker = args[2]
  local victimDied = args[6] == 1

  if not victimDied then
    return
  end

  if victim ~= PlayerPedId() then
    return
  end

  if attacker and attacker ~= 0 and IsEntityAPed(attacker) and IsPedAPlayer(attacker) then
    local killerPlayer = NetworkGetPlayerIndexFromPed(attacker)
    if killerPlayer and killerPlayer ~= -1 then
      local killerSource = GetPlayerServerId(killerPlayer)
      TriggerServerEvent('academy:server:addKill', killerSource)
    end
  end

  Wait(1500)
  TriggerEvent('academy:client:spawnArena')
end)
