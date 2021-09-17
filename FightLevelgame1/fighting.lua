
function get_info_warrior(warr,n)
  io.write(''..warr.name..' ')
  io.write('[Level:'..warr.level..']')
  io.write(' HP:'..uf:trunc(warr.hp)..'/'..warr.maxhp)
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

function get_locationData()
  io.write('----====')
  io.write('lvl'..level.level..' '..level.name)
  local totalhp = 0
  local totalmaxhp = 0
  for i = 1,#player.fr do
    totalhp = totalhp + player.fr[i].hp
    totalmaxhp = totalmaxhp + player.fr[i].maxhp
  end
  if totalmaxhp~=0 then
    io.write(' Y:'..math.floor(totalhp/totalmaxhp*100)..'%')
  end
  totalhp = 0
  totalmaxhp = 0
  for i = 1,#level.enemies do
    totalhp = totalhp + level.enemies[i].hp
    totalmaxhp = totalmaxhp + level.enemies[i].maxhp
  end
  if totalmaxhp~=0 then
    io.write(' E:'..math.floor(totalhp/totalmaxhp*100)..'%')
  end
  print('====----')
end

function go_shop()
  print('Вы переходите в режим покупок')
  loadfr()
  ip:changeIpr(shopIp)
end

function go_next()
  if #level.en>0 then return end
  print('Вы переходите на следующий уровень')
  player.goto_next_level()
  if not level then error('Уровней больше нет') end
  player.reward(level.reward)
  ip:changeIpr(shopIp)
end

function beforeInput()
  -- выводится название локации, уровень, общее состояние своих бойцов и вражеских
  get_locationData()
  -- выводится список бойцов, их здоровье и номер
  get_info_friend{}
  -- выводится список врагов, их здоровье и номер
  get_info_enemy{}
  --проверяется, не осталось ли у игрока войнов
  checkPlayerWarriors()
  --проверяется, не осталось ли у врага войнов
  checkEnemyWarriors()
end

function doAction(subject,object)
  --print('Объект '..subject.name..' делает действие по отношению к '..object.name)
  ab.fAttack(subject,object)
end

function allDoAction()
  local ei = 1
  local fi = 1
  for _ = 1,#level.enemies+#player.fr do
    if player.fr[fi] and #level.enemies>0 then
      local r = ran.i(1,#level.enemies)
      doAction(player.fr[fi],level.enemies[r])
    end
    if level.enemies[ei] and #player.fr>0 then
      local r = ran.i(1,#player.fr)
      doAction(level.enemies[ei],player.fr[r])
    end
    ei = ei + 1
    fi = fi + 1
  end
end

function checkPlayerWarriors()
  if #player.fr == 0 then
    print('--== Вы програли. ==--')
    print('[r] для возврата')
  end
end

function checkEnemyWarriors()
  if #level.en == 0 and #player.fr > 0 then
    print('--== Вы выйграли! ==--')
    print('[n] для принятия победы')
  end
end

function step()
  if #player.fr == 0 or #level.enemies == 0 then
    return
  end
  
  clanWarriorList[1] = level.en
  -- существа применяют способности на друг друге
  allDoAction()
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
:cmd('r',go_shop,'','Покинуть поле боя и вернуться в деревню')
:cmd('n',go_next,'','Принять победу и идти дальше')

fight = ip:newIp('Бой',cmds_fight,2)

fight.fBeforeInput = beforeInput
fight.typesymbol = 'fight>'
