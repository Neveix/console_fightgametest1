abilities = {}
ab = abilities

function ab.passive_Attack2(subj,damage)
  --for i = 1,subj.
end

function ab.fAttack(subj,objN)
  objN = objN or 1
  if #level.en > 0 then
    if level.en[objN] then
      local damage = subj.damage
      
      objN:getD(damage)
    else
      print('Враг не найден')
    end
  else
    print('Врагов нет...')
  end
end



-- atype: 0"active" 1"passive;getdamage"        2"passive;attack1"    3"passive;aura"                4"passive;attack2"
-- func:  func(object) damage = func(damage)     func(enemy)         for each clan do func(clan)    damage = func(enemy)
function abilities.add(name,atype,func,targets)
  atype = tonumber(atype) or error('incorrect type of ability')
  name = name or error('incorrect name')
  targets = targets or 0 -- 1b"friends" 2b"enemies"
  local a = {}
  a.name = name
  a.type = atype
  a.func = func
  a.targets = targets
  a.active = true
  abilities[name] = a
  abilities[#abilities+1] = a
  a.add = abilities.add
  return a
end

abilities.add('Attack',0,fAttack,2)
