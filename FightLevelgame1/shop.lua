shops = {}

sales = {}

function sales.new(name,des,war,price)
  local a = {}
  a.name = name or error('no name sale') 
  a.war = war or error('no warrior') 
  a.des = des or war().des
  a.price = price
  return a
end

function shops.addSale(shop,sale)
  shop.sales[#shop.sales+1] = sale
  return shop
end

function shops.addSaleM(shop,saleM)
  for i = 1,#saleM do
    shop.sales[#shop.sales+1] = saleM[i]
  end
  return shop
end

function shops.add(name,des)
  local a = {}
  if not name then error('no name shop') end
  a.name = name
  a.sales = {}
  a.des = des or ''
  a.addS = shops.addSale
  a.addSM = shops.addSaleM
  shops[name] = a
  return a
end

local new = sales.new

sales.default = {sales.new('Доброволец',_,units.player_volonter,6),sales.new('Доброволец (2)',_,units.player_volonter2,16)}
sales.archer1 = sales.new('Лучник',_,units.player_archer,16)
sales.footman1 = sales.new('Пехотинец',_,units.player_footman,24)


shop1 = shops.add('Пункт сбора граждан')
:addSM(sales.default)

shop2 = shops.add('Убежище на Струцсира')
:addSM(sales.default)
:addS(sales.archer1)

shop3 = shops.add('Казармы')
:addS(sales.archer1)
:addS(sales.footman1)



function get_shop_sale(sale)
  io.write('['..sale.name)
  io.write('] за '..sale.price..'$')
  io.write('"'..sale.des..'"')
  print()
end

function get_shop_sales(s)
  if s[2] then
    local n = tonumber(s[2]) or 1
    if level.shop.sales[n] then
      get_shop_sale(level.shop.sales[n])
    else
      print('Нет такой сделки')
    end
  else
    print('[buy <N>] для покупки N-ного война')
    for i = 1,#level.shop.sales do
      io.write(tostring('('..i..') '))
      get_shop_sale(level.shop.sales[i])
    end
  end
end

function buy_sale(sale)
  player.balance = player.balance - sale.price
  player.addF(sale.war)
end

function try_buy_sale(ipr,s)
  local n = tonumber(s[2]) or 1
  local c = tonumber(s[3]) or 1
  local sales = level.shop.sales
  if sales[n] then
    print('Запрос на покупку '..sales[n].name..' ('..n..') в количестве '..c)
    local price = sales[n].price
    local buyedcount = 0
    if price * c > player.balance then
      while player.balance>=price do
        buy_sale(sales[n])
        buyedcount = buyedcount + 1
      end
    else
      for i = 1,c do
        buy_sale(sales[n])
        buyedcount = buyedcount + 1
      end
    end
    if buyedcount > 0 then
      print('Куплено '..buyedcount..'/'..c..' бойцов')
    else
      print('У вас не хватает денег на покупку')
    end
  else
    print('Предложения под номером '..n..' не существует')
  end
end

function go_fight()
  print('Вы переходите в режим боя')
  savefr()
  level:resetEnemies()
  ip:changeIpr(fight)
end

local function beforeInput()
  if level.message and not level.messageShowed then
    io.write(tostring(level.message))
    level.messageShowed = true
    io.read()
  end
  
  print('----==== '..level.shop.name..' ====----')
  print('Ваш баланс : '..player.balance..'$')
  --get_shop_sales{}
  print('Ваши бойцы:')
  print('[sale] для просмотра магазина ; [f] для перехода на уровень ' )
  get_info_friend{}
end

cmds_shop = ip:newcmds()
:cmd('sale',get_shop_sales,'N | <>','Получить информацию о сделке(-ах)')
:cmd('buy',try_buy_sale,'sale N , Count','Купить бойца по предложению в количестве Count',1)
:cmd('f',go_fight,'','Перейти на уровень для того, чтобы сразиться')

shopIp = ip:newIp('Магазин',cmds_shop,2)
shopIp.typesymbol = 'shop>'
shopIp.fBeforeInput = beforeInput
shopIp.fNum = try_buy_sale

