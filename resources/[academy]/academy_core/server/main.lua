local PlayerStats = {}

local function getIdentifier(src)
  local identifiers = GetPlayerIdentifiers(src)
  for _, id in ipairs(identifiers) do
    if id:find('license:') then
      return id
    end
  end
  return ('src:%d'):format(src)
end

local function ensurePlayer(src)
  local identifier = getIdentifier(src)
  if not PlayerStats[identifier] then
    PlayerStats[identifier] = {
      kills = 0,
      deaths = 0
    }
  end
  return identifier, PlayerStats[identifier]
end

RegisterNetEvent('academy:server:addKill', function(victimSource)
  local src = source
  if src == victimSource then
    return
  end

  local killerId, killerStats = ensurePlayer(src)
  local victimId, victimStats = ensurePlayer(victimSource)

  killerStats.kills = killerStats.kills + 1
  victimStats.deaths = victimStats.deaths + 1

  TriggerClientEvent('academy:pvp:killfeed', -1, {
    killer = GetPlayerName(src) or ('ID %d'):format(src),
    victim = GetPlayerName(victimSource) or ('ID %d'):format(victimSource)
  })

  TriggerEvent('academy:server:persistStats', killerId, killerStats)
  TriggerEvent('academy:server:persistStats', victimId, victimStats)
end)

RegisterNetEvent('academy:server:requestStats', function()
  local src = source
  local _, stats = ensurePlayer(src)
  local kd = stats.deaths == 0 and stats.kills or (stats.kills / stats.deaths)

  TriggerClientEvent('academy:client:showStats', src, {
    kills = stats.kills,
    deaths = stats.deaths,
    kd = kd
  })
end)

RegisterCommand('resetkd', function(src)
  if src == 0 then
    return
  end

  local _, stats = ensurePlayer(src)
  stats.kills = 0
  stats.deaths = 0

  TriggerClientEvent('chat:addMessage', src, { args = { '^2Academy', 'Seu K/D foi resetado.' } })
end)

AddEventHandler('playerDropped', function()
  local src = source
  local identifier = getIdentifier(src)
  local stats = PlayerStats[identifier]
  if stats then
    TriggerEvent('academy:server:persistStats', identifier, stats)
  end
end)

AddEventHandler('academy:server:persistStats', function(identifier, stats)
  -- Placeholder para integração com oxmysql:
  -- exports.oxmysql:insert('INSERT INTO academy_stats (identifier, kills, deaths) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE kills = ?, deaths = ?', {
  --   identifier, stats.kills, stats.deaths, stats.kills, stats.deaths
  -- })
end)
