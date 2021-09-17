levels = {}

level = nil

function levels.addEnemy(level,enemy)
  level.enemies[#level.enemies+1] = enemy()
  return level
end

function levels.addEnemyM(level,enemy,count)
  count = count or 1
  for i = 1, count do
    level.enemies[#level.enemies+1] = enemy()
  end
  return level
end

function levels.add(name,shop)
  local a = {}
  a.name = name or 'unknown level'
  a.enemies = {}
  a.shop = shop or shop1
  a.addE = levels.addEnemy
  a.addEm = levels.addEnemyM
  if not level then
    level = a
  end
  levels[#levels+1] = a
  a.level = #levels
  return a
end

levels.add('Деревня 1')
:addEm(units.enemy_robber,4)
levels.add('Деревня 2')
levels.add('Деревня 3')