PrintChat("D3ftland Katarina By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Katarina", "Katarina")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KS", "Use Smart KS", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("AutoQ", "Auto Q", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("AutoW", "Auto W", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)

Drawings()

if MiscConfig.Autolvl then
LevelUp()
end

if Config.KS then
Killsteal()
end

local target = GetTarget(700, DAMAGE_MAGIC)

if MiscConfig.AutoQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(myHero, "katarinarsound") < 1 then
CastTargetSpell(target, _Q)
end

if MiscConfig.AutoW and ValidTarget(target, GetCastRange(myHero, _W)) and GotBuff(myHero, "katarinarsound") < 1 then
CastSpell(_W)
end

 if IWalkConfig.Combo then
  if waitTickCount > GetTickCount() then return end
    if CanUseSpell(myHero, _Q) == READY and Config.Q and ValidTarget(target, GetCastRange(myHero, _Q)) then
      CastTargetSpell(target, _Q)
    elseif CanUseSpell(myHero, _W) == READY and Config.W and ValidTarget(target, GetCastRange(myHero, _W)) then
      CastSpell(_W)
    elseif CanUseSpell(myHero, _E) == READY and Config.E and ValidTarget(target, GetCastRange(myHero, _E)) then
      CastTargetSpell(target, _E)
    elseif CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R)  ~= ONCOOLDOWN and ValidTarget(target, 550) and GetCastLevel(myHero,_R) > 0 then
      HoldPosition()
      waitTickCount = GetTickCount() + 50
      CastSpell(_R)
    end
 end

       local target = GetTarget(700 , DAMAGE_MAGIC)
 if IWalkConfig.Harass then
     
    if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) then
      CastTargetSpell(target, _Q)
    elseif CanUseSpell(myHero, _W) == READY and HarassConfig.HarassW and ValidTarget(target, GetCastRange(myHero, _W)) then
      CastSpell(_W)
    elseif CanUseSpell(myHero, _E) == READY and HarassConfig.HarassE and ValidTarget(target, GetCastRange(myHero, _E)) then
      CastTargetSpell(target, _E)
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
local ExtraDmg = 0
				if GotBuff(myHero, "itemmagicshankcharge") == 100 then
				    ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
			    end
				
				if CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_W)) then 
				CastSpell(_W)
				
				elseif CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_Q)) then 
				CastTargetSpell(enemy, _Q)
				
				elseif CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_W)) then 
				CastSpell(_W)
				DelayAction(function() CastTargetSpell(enemy, _Q) end, 0.1)
				
				elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				DelayAction(function() CastSpell(_W) end, 250)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg)) and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
				CastTargetSpell(enemy, _E)
				DelayAction(function() CastTargetSpell(enemy, _Q) end, 250)
				DelayAction(function() CastSpell(_W) end, 0.1)
				end
   end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
