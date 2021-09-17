
function get_info_warrior(warr,n)
  io.write('"'..warr.name..'"')
  io.write('[Level:'..warr.level..']')
  io.write(' HP:'..warr.hp..'/'..warr.maxhp)
  if warr.ap~=0 then
    io.write(' AP:'..warr.ap)
  end
  io.write('('..n..')')
  print()
end

function get_info_friend(s)
  if s[2] then
    local n = tonumber(s[2]) or 1
    if player.fr[n] then
      get_info_warrior(player.fr[n],n)
    end
  else
    for i = 1,#player.fr do
      get_info_warrior(player.fr[i],i)
    end
    if #player.fr==0 then
      print'У вас нет войнов'
    end
  end
end

function get_info_enemy(s)
  if s[2] then
    local n = tonumber(s[2]) or 1
    if level.enemies[n] then
      get_info_warrior(level.enemies[n],n)
    end
  else
    for i = 1,#level.enemies do
      get_info_warrior(level.enemies[i],i)
    end
    if #level.enemies==0 then
      print'У врага нет войнов'
    end
  end
end

function toggle_ability(s)
  
end

function leavefight()
  print('Вы возвращаетесь в магазин')
  ip:changeIpr(shopIp)
end

function get_locationData()
  io.write('----====')
  io.write('Level '..level.level..' name : '..level.name)
  local totalhp = 0
  local totalmaxhp = 0
  for i = 1,#player.fr do
    totalhp = totalhp + player.fr[i].hp
    totalmaxhp = totalmaxhp + player.fr[i].maxhp
  end
  if totalmaxhp~=0 then
    io.write(' You:'..math.floor(totalhp/totalmaxhp*100)..'%')
  end
  totalhp = 0
  totalmaxhp = 0
  for i = 1,#level.enemies do
    totalhp = totalhp + level.enemies[i].hp
    totalmaxhp = totalmaxhp + level.enemies[i].maxhp
  end
  if totalmaxhp~=0 then
    io.write(' Enm:'..math.floor(totalhp/totalmaxhp*100)..'%')
  end
  print('====----')
end

function beforeInput()
  -- выводится название локации, уровень, общее состояние своих бойцов и вражеских
  get_locationData()
  -- выводится список бойцов, их здоровье и номер
  get_info_friend{}
  -- выводится список врагов, их здоровье и номер
  get_info_enemy{}
end

function step()
  
end

-- команды
-- fr <N | all> - узнать всё о N-ном бойце (либо всех)
-- ab <N> - активировать/деактивировать способность номер N (если есть)
-- en <N | all>- узнать список с вражескими бойцами
-- "" - сделать ход
-- leave - покинуть поле


cmds_fight = ip:newcmds()

:cmd('fr',get_info_friend,'N | ""',"Узнать информацию о д N-ном войне (либо о всех)")
:cmd('en',get_info_enemy,'N | ""',"Узнать информацию о вражеском N-ном войне (либо о всех)")
:cmd('ab',toggle_ability,'N','Переключить Nную способность')
:cmd('',step,'','Следующий шаг')
:cmd('leave',leavefight,'','Покинуть поле')

fight = ip:newIp('Бой',cmds_fight,2)

fight.fBeforeInput = beforeInput
fight.typesymbol = 'fight>'
