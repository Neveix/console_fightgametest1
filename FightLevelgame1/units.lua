
units = {}

clanWarriorList = {}


function units.getDamage(unit,damage)
  unit.hp = unit.hp - unit.damage*unit.prot
  unit:checkHp()
end

function units.deleteFromList(unit)
  local list = clanWarriorList[unit.clan]
  local at = 0
  for i = 1 , #list do
    if list[i] == unit then
      at = i
      break
    end
  end
  for i = at,#list do
    list[i] = list[i+1]
  end
end

function units.checkHealth(unit)
  if unit.hp <= 0 then
    unit.hp = 0
    unit:delete()
  end
end

function units.setAP(unit,ap)
  unit.ap = ap
  unit.prot = (100-ap)/100
end

function units.init(unit)
  unit.maxhp = unit.hp
  return unit
end

function units.default()
  local a = {}
  a.damage = 1
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
  a.checkHp = units.checkHealth
  a.delete = units.deleteFromList
  return a:init()
end

function units.player_volonter()
  local a = units.default()
  a.name = 'Доброволец'
  a.des = 'Обычный человек, согласный драться за вас'
  a.hp = 7
  return a:init()
end

function units.player_volonter2()
  local a = units.default()
  a.name = 'Вооружённый Доброволец'
  a.des = 'Обычный человек, согласный драться за вас. Вооружён'
  a.hp = 11
  a:setAP(15)
  a.level = 2
  return a:init()
end

function units.player_archer()
  local a = units.default()
  a.name = 'Лучник'
  a.des = ''
  a.damage = 3
  a.hp = 7
  return a:init()
end

function units.player_footman()
  local a = units.default()
  a.name = 'Пехотинец'
  a:setAP(25)
  a.des = ''
  a.damage = 2
  a.hp = 16
  return a:init()
end

function units.player_witcher()
  local a = units.default()
  a.name = 'Ведьмак'
  a:setAP(10)
  a.des = ''
  a.damage = 3
  a.hp = 25
  return a:init()
end

function units.player_bowman()
  local a = units.default()
  a.name = 'Хороший лучник'
  a:setAP(10)
  a.des = ''
  a.damage = 5
  a.hp = 16
  return a:init()
end

function units.player_knight()
  local a = units.default()
  a.name = 'Рыцарь'
  a:setAP(40)
  a.des = ''
  a.damage = 3
  a.hp = 32
  return a:init()
end


----------------------

function units.enemy_robber()
  local a = units.default()
  a.name = 'Разбойник'
  a.clan = 1
  a.hp = 5
  return a:init()
end

function units.enemy_burglar()
  local a = units.default()
  a.name = 'Насильник'
  a.clan = 1
  a:setAP(20)
  a.damage = 2
  a.hp = 18
  return a:init()
end

function units.enemy_vindicator()
  local a = units.default()
  a.name = 'Поборник'
  a.clan = 1
  a.damage = 2
  a.hp = 14
  return a:init()
end

function units.enemy_maroder()
  local a = units.default()
  a.name = 'Мародёр'
  a.clan = 1
  a.damage = 2
  a.hp = 25
  return a:init()
end