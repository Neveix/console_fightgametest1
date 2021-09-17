player = {}
player.fr = {}
player.lastfr = {}
player.onlevel = 0
player.balance = 0

function savefr()
  player.lastfr = uf:copyT(player.fr,6)
end

function loadfr()
  player.fr = player.lastfr
  for i = 1,#player.fr do
    player.fr[i]:checkHp()
  end
  updateCWL()
end

function updateCWL()
  clanWarriorList[0] = player.fr
end

function player.addF(friend)
  player.fr[#player.fr+1] = friend()
  updateCWL()
end

function player.addFm(friend,count)
  count = count or 1
  for i = 1, count do
    player.fr[#player.fr+1] = friend()
  end
  updateCWL()
end

function player.goto_next_level()
  player.onlevel = player.onlevel + 1
  level = levels[player.onlevel]
  updateCWL()
end

function player.reward(c)
  player.balance = player.balance + (c or 0)
end

updateCWL()