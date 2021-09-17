ip = require "n200_ip7"
ran = require 'n200_random'
uf = require 'n200_useful2'

program = 'fightingGame1'

function get_modules_path()
  local file = io.open(program..'-path.txt','r')
  if file then
    path = file:read()
    file:close()
  else
    print('Введите путь до файла main.lua: (например, "/neveix_Feb2021/evo_try_20_2")')
    path = io.read()
    file = io.open(program..'-path.txt','w')
    file:write(path)
    file:close()
  end
end

get_modules_path()

require (path..'/units')
require (path..'/shop')
require (path..'/levels')
require (path..'/abilities')
require (path..'/fighting')
require (path..'/player')

function beforeInput()
  print('[new] для начала новой игры ; [exit] для выхода ' )
  if player.onlevel > 0 then
    get_info_friend{}
  end
end

function newgame()
  player.fr = {}
  player.onlevel = 0
  player.goto_next_level()
  player.balance = 22
  shopIp:interprete()
end

cmds_menu = ip:newcmds()
:cmd('new',newgame,'','Start new game')

menu = ip:newIp('Game menu',cmds_menu,2)

menu.fBeforeInput = beforeInput

print('----==== '..program..' ====----')

menu:interprete()


ran.saverandom()