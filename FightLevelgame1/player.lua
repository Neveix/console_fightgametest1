player = {}
player.fr = {}
player.onlevel = 0
player.balance = 0

function player.addF(friend)
  player.fr[#player.fr+1] = friend()
end

function player.addFm(friend,count)
  count = count or 1
  for i = 1, count do
    player.fr[#player.fr+1] = friend()
  end
end

function player.goto_next_level()
  player.onlevel = player.onlevel + 1
  level = levels[player.onlevel]
end