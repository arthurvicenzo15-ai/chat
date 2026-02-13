RegisterNetEvent('academy:pvp:killfeed', function(data)
  local message = ('%s eliminou %s'):format(data.killer, data.victim)
  TriggerClientEvent('chat:addMessage', -1, {
    color = { 255, 80, 80 },
    args = { '^1Killfeed', message }
  })
end)
