PrintChat("D3ftland Katarina By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Katarina", "Katarina")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KS", "Use Smart KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("WJ", "Ward Jump", SCRIPT_PARAM_KEYDOWN, string.byte("G"))
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawHP", "Draw Damage", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

local myHero = GetMyHero()
local myTeam = GetTeam(myHero)
local myHeroName = GetObjectName(myHero)
local wardTable = {}
local wjspell = myHeroName == "Katarina" and _E or nil
local wjrange = wjspell == 600 
local wardIDs = {3166, 3361, 3362, 3340, 3350, 2050, 2045, 2049, 2044, 2043}
local casted, jumped = false, false
  
OnObjectLoop(function(obj, myHero)
    if Config.WJ then 
    local objName = GetObjectBaseName(obj)
    if GetTeam(obj) == myTeam and (objName:lower():find("ward") or objName:lower():find("trinkettotem")) then
      wardTable[GetNetworkID(obj)] = obj
    end
	end
end)

OnLoop(function(myHero)

Drawings()

if Config.KS then
Killsteal()
end

--if Config.WJ or casted then
--WardJump() 
--end

local target = GetTarget(1500 , DAMAGE_MAGIC)
if target and DrawingsConfig.DrawHP then
local hp  = GetCurrentHP(target)
local dmg = 0
local targetPos = GetOrigin(target)
local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
    if CanUseSpell(myHero, _Q) == READY then
      dmg = dmg + CalcDamage(myHero, target, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero)) * 1.25
    end
    if CanUseSpell(myHero, _W) == READY then
      dmg = dmg + CalcDamage(myHero, target, 0, 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) )
    end
    if CanUseSpell(myHero, _E) == READY then
      dmg = dmg + CalcDamage(myHero, target, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero))
    end
    if CanUseSpell(myHero, _R) ~= ONCOOLDOWN and GetCastLevel(myHero,_R) > 0 then
      dmg = dmg + CalcDamage(myHero, target, 0, 30+ 10*GetCastLevel(myHero,_R)+0.2* GetBonusAP(myHero) +0.3*GetBonusDmg(myHero)) * 10
    end
    if dmg > hp then
      DrawText("Killable",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(target,hp,0,hp,0xffffffff)
    else
      DrawText(math.floor(100 * dmg / hp).."%",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(target
      ,hp,0,dmg,0xffffffff)
    end
end

local target = GetTarget(700, DAMAGE_MAGIC)
if ValidTarget(target, 700) then
      
 if IWalkConfig.Combo then
  if waitTickCount > GetTickCount() then return end
    if CanUseSpell(myHero, _Q) == READY and Config.Q and GotBuff(myHero, "katarinarsound") < 1 then
      CastTargetSpell(target, _Q)
    elseif CanUseSpell(myHero, _W) == READY and Config.W and IsInDistance(target, 375) and GotBuff(myHero, "katarinarsound") < 1 then
      CastSpell(_W)
    elseif CanUseSpell(myHero, _E) == READY and Config.E and GotBuff(myHero, "katarinarsound") < 1 then
      CastTargetSpell(target, _E)
    elseif CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R)  ~= ONCOOLDOWN and IsInDistance(target, 550) and GetCastLevel(myHero,_R) > 0 then
      HoldPosition()
      waitTickCount = GetTickCount() + 50
      CastSpell(_R)
    end
 end
end

if ValidTarget(target, 700) then
       local target = GetTarget((CanUseSpell(myHero, _E) == READY and 700 or 550) , DAMAGE_MAGIC)
 if IWalkConfig.Harass then
     
    if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ then
      CastTargetSpell(target, _Q)
    elseif CanUseSpell(myHero, _W) == READY and HarassConfig.HarassW then
      CastSpell(_W)
    elseif CanUseSpell(myHero, _E) == READY and HarassConfig.HarassE then
      CastTargetSpell(target, _E)
    end
 end
end
end)


OnProcessSpell(function(unit, spell)
  if unit and unit == myHero and spell then
    if spell.name:lower():find("katarinar") then
      waitTickCount = GetTickCount() + 2500
    end
  end
end)

function Killsteal()
  for i,enemy in pairs(GetEnemyHeroes()) do
local Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2)) or nil
local ExtraDmg = 0
local ExtraDmg2 = 0
				if Ignite ~= nil and CanUseSpell(myHero, Ignite) == READY then
					ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
				end
				if GotBuff(myHero, "itemmagicshankcharge") > 99 then
				    ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
			    end
				
				if CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg2)) and ValidTarget(enemy,GetCastRange(myHero,_W)) then 
				CastSpell(_W)
				
				elseif CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg2)) and ValidTarget(enemy,GetCastRange(myHero,_Q)) then 
				CastTargetSpell(enemy, _Q)
				
				elseif CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero))) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg2)) and ValidTarget(enemy,GetCastRange(myHero,_W)) then 
				CastSpell(_W)
				DelayAction(function() CastTargetSpell(enemy, _Q) end, 0.1)
				
				elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg2)) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				DelayAction(function() CastSpell(_W) end, 0.1)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) + ExtraDmg < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg2)) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				DelayAction(function() CastTargetSpell(enemy, _Q) end, 0.1)
				DelayAction(function() CastSpell(_W) end, 0.1)
				end			
	end
end

function WardJump()
    if casted and jumped then casted, jumped = false, false
    elseif CanUseSpell(myHero, wjspell) == READY then
      local pos = Vector(myHero) + Vector(Vector(GetMousePos()) - Vector(myHero)):normalized() * wjrange
      if Jump(pos) then return end
      slot = GetWardSlot()
      if not slot or casted then return end
      CastSkillShot(slot, pos.x, pos.y, pos.z)
      casted = true
    end
end

function Jump(pos)
    for i, minion in pairs(GetAllMinions(MINION_ALLY)) do
      if GetDistanceSqr(GetOrigin(minion), pos) <= 250*250 then
        CastTargetSpell(minion, wjspell)
        jumped = true
        return true
      end
    end
    for i, ward in pairs(wardTable) do
      if GetDistanceSqr(GetOrigin(ward), pos) <= 250*250 then
        CastTargetSpell(ward, wjspell)
        jumped = true
        return true
      end
    end
end

function GetWardSlot()
    for _, id in pairs(wardIDs) do
      local slot = GetItemSlot(myHero, id)
      if slot > 0 and CanUseSpell(myHero, slot) == READY then
        return slot
      end
    end
    return nil
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
