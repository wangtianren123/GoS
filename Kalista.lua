local version = 1
require('Dlib')
PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn on F7 orbwalker!")
MINION_ALLY, MINION_ENEMY, MINION_JUNGLE = GetTeam(GetMyHero()), GetTeam(GetMyHero()) == 100 and 200 or 100, 300

up=Updater.new("D3ftsu/GOS/master/Kalista.lua", "Common\Kalista", version)
if up.newVersion() then 
	up.update() end

local root = menu.addItem(SubMenu.new("Kalista"))
--ComboMenu--
local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CItems = Combo.addItem(MenuBool.new("Use Items",true))
local CQSS = Combo.addItem(MenuBool.new("Use QSS", true))
local QSSHP = Combo.addItem(MenuSlider.new("if My Health % is Less Than", 75, 0, 100, 5))
local ComboActive = Combo.addItem(MenuKeyBind.new("Combo", 32))
--Harass menu--
local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q", true))
local HMmana = Harass.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 5))
local HarassActive = Harass.addItem(MenuKeyBind.new("Harass", 67))
--Ult--
local Ultmenu = root.addItem(SubMenu.new("Ult"))
local AutoR = Ultmenu.addItem(MenuBool.new("Save Ally with R", true))
local AutoRHP = Ultmenu.addItem(MenuSlider.new("min Ally HP %", 5, 1, 100, 1))
--Killsteal
local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))
local KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", true))
--Misc--
local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscuseE = Misc.addItem(MenuBool.new("Auto E if Target Will Leave Range", true))
local MiscElvl = Misc.addItem(MenuSlider.new("E Harass if my level <", 12, 1, 18, 1))
local MiscminE = Misc.addItem(MenuSlider.new("min E Stacks", 8, 1, 63, 1))
local MiscMmana = Misc.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 5))
--Drawings--
local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsAA = Drawings.addItem(MenuBool.new("Draw AA", true))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))
local DrawingsEdmg = Drawings.addItem(MenuBool.new("Draw E% Dmg", true))
--Farm--
local Farm = root.addItem(SubMenu.new("Farm"))
local junglesteal = Farm.addItem(SubMenu.new("Junglesteal (E)", true))
local baron = junglesteal.addItem(MenuBool.new("Baron", true))
local dragon = junglesteal.addItem(MenuBool.new("Dragon", true))
local red = junglesteal.addItem(MenuBool.new("Red", true))
local blue = junglesteal.addItem(MenuBool.new("Blue", false))
local krug = junglesteal.addItem(MenuBool.new("Krug", false))
local wolf = junglesteal.addItem(MenuBool.new("Wolf", true))
local wraiths = junglesteal.addItem(MenuBool.new("Wraiths", true))
local gromp = junglesteal.addItem(MenuBool.new("Gromp", false))
local crab = junglesteal.addItem(MenuBool.new("Crab", true))
local ECanon = Farm.addItem(MenuBool.new("Always E Big Minions", true))
local Farmmana = Farm.addItem(MenuSlider.new("Don't E if Mana % <", 30, 0, 80, 5))
local Farmkills = Farm.addItem(MenuSlider.new("E if X Can Be Killed", 2, 0, 10, 1))
local FarmkillsHur = Farm.addItem(MenuSlider.new("E Hurricane if X Can Be Killed", 3, 0, 10, 1))
local LaneClearActive = Farm.addItem(MenuKeyBind.new("LaneClear", 86))

do
  _G.objectManager = {}
  objectManager.maxObjects = 0
  objectManager.objects = {}
  objectManager.camps = {}
  objectManager.barracks = {}
  objectManager.heroes = {}
  objectManager.minions = {}
  OnObjectLoop(function(object, myHero)
    objectManager.objects[GetNetworkID(object)] = object
  end)
  OnLoop(function(myHero)
    objectManager.maxObjects = 0
    for _, obj in pairs(objectManager.objects) do
      objectManager.maxObjects = objectManager.maxObjects + 1
      local type = GetObjectType(obj)
      if type == Obj_AI_Camp then
        objectManager.camps[_] = obj
      elseif type == Obj_AI_Hero then
        objectManager.heroes[_] = obj
      elseif type == Obj_AI_Minion then
        objectManager.minions[_] = obj
      end
    end
  end)
end

OnLoop(function(myHero)
	local mousePos = GetMousePos()
    if ComboActive.getValue() then
	local target = GetCurrentTarget()
	
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and CUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
		if GetItemSlot(myHero,3153) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and CItems.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
		if GetItemSlot(myHero,3140) > 0 and CQSS.getValue() and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and CQSS.getValue() and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	end
	
	if HarassActive.getValue() then
	local target = GetCurrentTarget()
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and HUseQ.getValue() and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > HMmana.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		else 
	    MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
        end
	end
    
	if MiscuseE.getValue() then
	    for i,enemy in pairs(GetEnemyHeroes()) do
            if GetCurrentMana(myHero)/GetMaxMana(myHero) > MiscMmana.getValue() and GetLevel(myHero) < MiscElvl.getValue() then
		        if GotBuff(enemy, "kalistaexpungemarker") >= MiscminE.getValue() and ValidTarget(target, GetCastRange(myHero,_E)) and IsTargetable and GetDistance(myHero, enemy) > GetCastRange(myHero,_E)-50 then
			    CastSpell(_E)
			    end
		    end
		end
	end
			
	if AutoR.getValue() then 
	    for _, ally in pairs(GetAllyHeroes()) do
            for i,enemy in pairs(GetEnemyHeroes()) do 
			    local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
				if soulboundhero and GetCurrentHP(ally) <= AutoRHP.getValue() and GetDistance(ally, enemy) < 1500 then
				CastSpell(_R)
				end
			end
		end
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
	local Damage = CalcDamage(myHero, enemy, GotBuff(enemy,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(enemy,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1150,40,true,true)
       if CanUseSpell(myHero, _E) == READY and ValidTarget(enemy, GetCastRange(myHero,_E)) and KSE.getValue() and GetCurrentHP(enemy) < Damage then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy, GetCastRange(myHero, _Q)) and KSQ.getValue() and QPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
       CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
       end
	   
	if DrawingsEdmg.getValue() then
	  local targetPos = GetOrigin(enemy)
      local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
	  if Damage > GetCurrentHP(enemy) then
	  DrawText("100%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
	  elseif Damage > 0 then
      DrawText(math.floor(Damage/GetCurrentHP(enemy)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
      end
	end
	
    end
	
	if MiscEnableAutolvl.getValue() then
	if GetLevel(myHero) == 1 then
	LevelSpell(_E)
    elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
    elseif GetLevel(myHero) == 3 then
	LevelSpell(_Q)
    elseif GetLevel(myHero) == 4 then
    LevelSpell(_E)
    elseif GetLevel(myHero) == 5 then
    LevelSpell(_E)
    elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
    elseif GetLevel(myHero) == 7 then
	LevelSpell(_E)
    elseif GetLevel(myHero) == 8 then
    LevelSpell(_Q)
    elseif GetLevel(myHero) == 9 then
    LevelSpell(_E)
    elseif GetLevel(myHero) == 10 then
    LevelSpell(_Q)
    elseif GetLevel(myHero) == 11 then
    LevelSpell(_R)
    elseif GetLevel(myHero) == 12 then
    LevelSpell(_Q)
    elseif GetLevel(myHero) == 13 then
    LevelSpell(_Q)
    elseif GetLevel(myHero) == 14 then
    LevelSpell(_W)
    elseif GetLevel(myHero) == 15 then
    LevelSpell(_W)
    elseif GetLevel(myHero) == 16 then
    LevelSpell(_R)
    elseif GetLevel(myHero) == 17 then
    LevelSpell(_W)
    elseif GetLevel(myHero) == 18 then
    LevelSpell(_W)
    end
	end
	
	local killableCount = 0
    for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
	  local Damage = CalcDamage(myHero, minion, GotBuff(minion,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(minion,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
   
      if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Siege")) or (GetObjectName(minion):find("Super")) and ValidTarget(minion, GetCastRange(myHero,_E)) and IsTargetable and ECanon.getValue() and GetCurrentMana(myHero)/GetMaxMana(myHero) > Farmmana.getValue() then 
      CastSpell(_E)
	  end
	
	  if Damage > 0 and Damage > GetCurrentHP(minion) and ValidTarget(minion, GetCastRange(myHero,_E)) then 
      killableminions = killableminions or 1
      end
	
    end
	
      if GetCurrentMana(myHero)/GetMaxMana(myHero) > Farmmana.getValue() then
        if GetItemSlot(myHero,3085) > 0 and LaneClearActive.getValue() and killableminions >= FarmkillsHur.getValue() then
        CastSpell(_E)
	    end
	  end
	  
	  if GetCurrentMana(myHero)/GetMaxMana(myHero) > Farmmana.getValue() then
        if LaneClearActive.getValue() and killableminions >= Farmkills.getValue() then
        CastSpell(_E)
	    end
	  end
	 
	for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
    local Damage = CalcDamage(myHero, mob, GotBuff(mob,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(mob,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if IsInDistance(mob, GetCastRange(myHero,_E)) then  
	  if CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Baron" and baron.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Dragon" and dragon.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Blue" and blue.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Red" and red.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Krug" and krug.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Murkwolf" and wolf.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Razorbeak" and wraiths.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Gromp" and gromp.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "Sru_Crab" and crab.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  end
   end
   
  if ValidTarget(mob, 1200) then
	local mobPos = GetOrigin(mob)
    local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
	if Damage > GetCurrentHP(mob) then
	DrawText("100%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
	elseif Damage > 0 then
    DrawText(math.floor(Damage/GetCurrentHP(mob)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
    end
  end
  end

local HeroPos = GetOrigin(myHero)
if DrawingsAA.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetRange(myHero)+GetHitBox(myHero)*2,3,100,0xffffffff) end
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end)

function GetMyHeroPos()
    return GetOrigin(GetMyHero()) 
end

function kalE(x) 
if x <= 1 then return 10 else return kalE(x-1) + 2 + x
end 
end -- too smart for you inspired, thanks for this anyway :3, lazycat

function ValidTarget(unit, range)
    range = range or 25000
    if unit == nil or GetOrigin(unit) == nil or not IsTargetable(unit) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(GetMyHero()) or not IsInDistance(unit, range) then return false end
    return true
end

function IsInDistance(p1,r)
    return GetDistanceSqr(GetOrigin(p1)) < r*r
end

function GetDistance(p1,p2)
    p1 = GetOrigin(p1) or p1
    p2 = GetOrigin(p2) or p2
    return math.sqrt(GetDistanceSqr(p1,p2))
end

function GetDistanceSqr(p1,p2)
    p2 = p2 or GetMyHeroPos()
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
end

function GetEnemyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) ~= GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetAllyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) == GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetAllMinions(team)
    local result = {}
    for _,k in pairs(objectManager.minions) do
        if k and not IsDead(k) and GetCurrentHP(k) < 100000 and GetObjectName(k):find("_") then
            if not team or GetTeam(k) == team then
                result[_] = k
            end
        else
            objectManager.minions[_] = nil
        end
    end
    return result
end

function CountMinions()
    local m = 0
    for _,k in pairs(GetAllMinions()) do 
        m = m + 1 
    end
    return m
end

function CalcDamage(source, target, addmg, apdmg)
    local ADDmg = addmg or 0
    local APDmg = apdmg or 0
    local ArmorPen = math.floor(GetArmorPenFlat(source))
    local ArmorPenPercent = math.floor(GetArmorPenPercent(source)*100)/100
    local Armor = GetArmor(target)*ArmorPenPercent-ArmorPen
    local ArmorPercent = Armor > 0 and math.floor(Armor*100/(100+Armor))/100 or math.ceil(Armor*100/(100-Armor))/100
    local MagicPen = math.floor(GetMagicPenFlat(source))
    local MagicPenPercent = math.floor(GetMagicPenPercent(source)*100)/100
    local MagicArmor = GetMagicResist(target)*MagicPenPercent-MagicPen
    local MagicArmorPercent = MagicArmor > 0 and math.floor(MagicArmor*100/(100+MagicArmor))/100 or math.ceil(MagicArmor*100/(100-MagicArmor))/100
    return (GotBuff(source,"exhausted")  > 0 and 0.4 or 1) * math.floor(ADDmg*(1-ArmorPercent))+math.floor(APDmg*(1-MagicArmorPercent))
end
