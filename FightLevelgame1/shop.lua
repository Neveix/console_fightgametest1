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

sales.default = {sales.new('Волонтёр',_,units.player_volonter,6)}
sales.default2 = {sales.new('Вооружённый волонтёр',_,units.player_volonter2,16)}


shop1 = shops.add('Лавка 1')
:addSM(sales.default)
:addSM(sales.default2)

function get_shop_sale(sale)
  io.write('Сделка: ['..sale.name)
  io.write('] "'..sale.des..'"')
  io.write(' за '..sale.price..'$')
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
    for i = 1,#level.shop.sales do
      get_shop_sale(level.shop.sales[i])
    end
  end
end

function buy_sale(sale)
  player.balance = player.balance - sale.price
  player.addF(sale.war)
end

function try_buy_sale(s)
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
  ip:changeIpr(fight)
end

function beforeInput()
  print('----==== Магазин '..level.shop.name..' ====----')
  print('Ваш баланс : '..player.balance..'$')
  get_shop_sales{}
end

cmds_shop = ip:newcmds()
:cmd('sale',get_shop_sales,'N | <>','Получить информацию о сделке(-ах)')
:cmd('buy',try_buy_sale,'sale N , Count','Купить бойца по предложению в количестве Count')
:cmd('next',go_fight,'','Go to next level for fight')

shopIp = ip:newIp('Магазинчик',cmds_shop,2)
shopIp.typesymbol = 'shop>'
shopIp.fBeforeInput = beforeInput
shopIp.fNum = try_buy_sale

