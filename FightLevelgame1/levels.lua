levels = {}

levelgroups = {
  zliohville={}
  
  }


levels.putingroup = {}


level = nil

function levels.addEnemy(level,enemy,count)
  count = count or 1
  local found = nil
  for i = 1,#level.enf do
    if level.enf[i].f == enemy then
      found = level.enf[i]
    end
  end
  if not found then 
    level.enf[#level.enf+1]={f=enemy,c=count}
  else
    found.c = found.c + count
  end
  return level
end

function levels.resetEnemies(level)
  local a = {}
  level.en = a
  level.enemies = a
  for i = 1,#level.enf do
    for _ = 1,level.enf[i].c do
      a[#a+1] = level.enf[i].f()
    end
  end
end

function levels.add(name,reward,shop)
  local a = {}
  a.name = name or 'unknown level'
  a.enemies = {}
  a.en = a.enemies
  a.enf = {}
  a.shop = shop or shop1
  a.reward = reward or 0
  a.message = nil
  a.messageShowed = false
  a.addE = levels.addEnemy
  a.resetEnemies = levels.resetEnemies
  if not level then
    level = a
  end
  levels[#levels+1] = a
  levels.putingroup[#levels.putingroup+1] = a
  a.level = #levels
  return a
end

levels.putingroup = levelgroups.zliohville
levels.add('Злиохвиль; Улица Струцсира - 1',16)
:addE(units.enemy_robber,3)
levels.add('Злиохвиль; Улица Струцсира - 3',20)
:addE(units.enemy_robber,4)
levels.add('Злиохвиль; Улица Струцсира - 5',22,shop2)
:addE(units.enemy_robber,4)
levels.add('Злиохвиль; Улица Струцсира - 7',40,shop3)
:addE(units.enemy_robber,4)
:addE(units.enemy_burglar)
levels.add('Злиохвиль; Улица Струцсира - 9',38,shop3)
:addE(units.enemy_robber,3)
:addE(units.enemy_vindicator,1)
levels.add('Злиохвиль; Улица Струцсира - 10',40,shop3) --6
:addE(units.enemy_robber,2)
:addE(units.enemy_vindicator,2)
:addE(units.enemy_burglar)
levels.add('Злиохвиль; Улица Струцсира - 12',60,shop3)
:addE(units.enemy_vindicator,1)
:addE(units.enemy_maroder)
levels.add('Злиохвиль; Улица Струцсира - 14',18,shop3) -- 8
:addE(units.enemy_robber,3)
:addE(units.enemy_burglar)
:addE(units.enemy_maroder)
levels.add('Злиохвиль; Площадь Мафгота',60,shop3) -- 9
:addE(units.enemy_robber,6)
:addE(units.enemy_burglar,4)
levels.add('Злиохвиль; Площадь Мафгота 2',0,shop3) -- 10


levelgroups.zliohville[1].message = 
[[- Что же произошло? Как это случилось? Ах.. Подойду к людям, может они что знают.
*крики, вопли*
- Где вы были? Нам нужна ваша помощь! ]]
levelgroups.zliohville[2].message = 
[[- Ах, кто же бьёт вот так со спины! Ничего, если я пройду вперёд, я прорвусь!...]]
levelgroups.zliohville[3].message = 
[[- Сколько же их здесь!]]
levelgroups.zliohville[4].message = 
[[- Хм.. Казарма. Тут-то я и достану новых бойцов!]]
levelgroups.zliohville[6].message = 
[[- Эхе-хе! Вдалеке видна площадь, а это значит, я на верном пути. Эх, сколько же мне ещё придётся пройти...]]
levelgroups.zliohville[8].message = 
[[- Так-с, я почти у площади. Там, как я погляжу, стоят основные "войска" местных головорезов]]
levelgroups.zliohville[9].message = 
[[- Что ж, я на площади. Какой ужас, нужно завлечь ещё бойцов ко мне в отряд!]]
levelgroups.zliohville[10].message = 
[[- Фуух... Я справился!
- Милорд, вы целы?
-Да, всё нормально. Когда они напали?
- Вчера вечером. Окружили город и ударили одновременно со всех сторон. Непонятно, откуда же их столько много!
- Ох, всё, мне не до разбойников. В провинции меня ждёт моя любовь.. Очистить деревню от оставшихся разбойников!
Выгнать захватчиков! Я объявляю победу!]]
