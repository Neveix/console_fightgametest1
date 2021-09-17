
units = {}

function units.getDamage(unit,damage)
  unit.hp = unit.hp - unit.damage*unit.prot
end

function units:setAP(ap)
  units.ap = ap
  units.prot = (100-ap)/100
end

function units.init(unit)
  unit.maxhp = unit.hp
  return unit
end

function units.default()
  local a = {}
  a.attack = 1
  a.hp = 3
  a.ap = 0
  a.prot = 1
  a.setAP = units.setAP
  a.abilities = {}
  a.name = 'Warrior'
  a.des = '<>'
  a.level = 1
  a.clan = 0
  a.attacktype = 0 -- 0=melee , 1=ranged
  a.init = units.init
  a.getD = units.getDamage
  return a:init()
end

function units.player_volonter()
  local a = units.default()
  a.name = 'Доброволец'
  a.des = 'Обычный человек, согласный драться за вас'
  a.health = 5
  a.cost = 10
  return a:init()
end

function units.player_volonter2()
  local a = units.default()
  a.name = 'Вооружённый Доброволец'
  a.des = 'Обычный человек, согласный драться за вас, но вооружённый топором'
  a.hp = 7
  a:setAP(5)
  a.level = 2
  a.cost = 16
  return a:init()
end


function units.enemy_robber()
  local a = units.default()
  a.name = 'Разбойник'
  a.clan = 1
  
  return a:init()
end