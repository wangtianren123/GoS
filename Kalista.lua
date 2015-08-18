PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item4", "Use QSS (broken)", SCRIPT_PARAM_ONOFF, true)
ExtraConfig = scriptConfig("Extra", "Extra")
ExtraConfig.addParam("Autolvl", "Autolvl E-Q-W", SCRIPT_PARAM_ONOFF, false)
ExtraConfig.addParam("AutoR", "Save Ally (R)", SCRIPT_PARAM_ONOFF, true)
ExtraConfig.addParam("Balista", "Balista Combo", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawEdmg", "Draw E Dmg %", SCRIPT_PARAM_ONOFF, true)
JSConfig = scriptConfig("JS", "Junglesteal")
JSConfig.addParam("baron","Baron", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("dragon","Dragon", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("red","Red", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("blue","Blue", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()
Junglesteal()
if ExtraConfig.Autolvl then
LevelUp()
end

if ExtraConfig.AutoR then
SaveAlly()
end

if ExtraConfig.Balista then
Balista()
end

local target = GetTarget(1150, DAMAGE_PHYSICAL)
if ValidTarget(target, 1150) then
 if IWalkConfig.Combo then
   
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
   if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and Config.Q then
   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
   end
   
   if GetItemSlot(myHero,3153) > 0 and Config.Item1 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
   CastTargetSpell(target, GetItemSlot(myHero,3153))
   end

   if GetItemSlot(myHero,3144) > 0 and Config.Item2 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
   CastTargetSpell(target, GetItemSlot(myHero,3144))
   end

   if GetItemSlot(myHero,3142) > 0 and Config.Item3 then
   CastTargetSpell(GetItemSlot(myHero,3142))
   end
 end
end
 
local target = GetTarget(1150, DAMAGE_PHYSICAL) 
if ValidTarget(target, 1150) then
 if IWalkConfig.Harass then
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
   if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and HarassConfig.HarassQ then
   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
   end
 end
end
end)

OnProcessSpell(function(unit, spell)
 for _, ally in pairs(GetAllyHeroes()) do
  if unit and unit == myHero and spell then
    if spell.name:lower():find("kalistapspellcast") then
      PrintChat("You are now pledged to "..GetObjectName(spell.target).."")
    end
  end
 end
end)

function Killsteal()
   for i,enemy in pairs(GetEnemyHeroes()) do
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1150,40,true,true)
   local Damage = CalcDamage(myHero, enemy, GotBuff(enemy,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(enemy,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
       if CanUseSpell(myHero, _E) == READY and ValidTarget(enemy,GetCastRange(myHero,_E)) and KSConfig.KSE and GetCurrentHP(enemy) < Damage then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy, GetCastRange(myHero, _Q)) and KSConfig.KSQ and QPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
       CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
       end
	local targetPos = GetOrigin(enemy)
    local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
	if Damage > 0 and ValidTarget(enemy,GetCastRange(myHero,_E)) then 
    DrawText(math.floor(Damage/GetCurrentHP(enemy)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
    end
   end
end

function LevelUp()     

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

function Drawings()
  for _,target in pairs(GetEnemyHeroes()) do
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
 end
end

function SaveAlly()
 for _, ally in pairs(GetAllyHeroes()) do
 for i,enemy in pairs(GetEnemyHeroes()) do
   local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
   if soulboundhero and GetCurrentHP(ally)/GetMaxHP(ally) < 0.05 and GetDistance(ally, enemy) < 1500 then 
   CastSpell(_R)
   end
 end
 end
end

function Balista()
   for _, ally in pairs(GetAllyHeroes()) do
     if GetObjectName(ally) == "Blitzcrank" then
      for i,enemy in pairs(GetEnemyHeroes()) do
        if ValidTarget(enemy, 2450) then
         if GetCurrentHP(enemy) > 200 and GetDistance(ally, enemy) > 450 then
           if GotBuff(enemy, "rocketgrab2") > 0 then
           CastSpell(_R)
           end
         end
        end
     end
   end
 end
end

function kalE(x) 
if x <= 1 then return 10 else return kalE(x-1) + 2 + x
end 
end -- too smart for you inspired, thanks for this anyway :3, lazycat

function Junglesteal()
  for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
  local Damage = CalcDamage(myHero, mob, GotBuff(mob,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(mob,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Baron12.1.1" and ValidTarget(mob,GetCastRange(myHero,_E)) and JSConfig.baron and GetCurrentHP(mob) < Damage then
	CastSpell(_E)
	elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Dragon6.1.1" and ValidTarget(mob,GetCastRange(myHero,_E)) and JSConfig.baron and GetCurrentHP(mob) < Damage then
	CastSpell(_E)
	end
	
	local mobPos = GetOrigin(mob)
    local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
	if Damage > 0 and ValidTarget(mob,GetCastRange(myHero,_E)) then 
    DrawText(math.floor(Damage/GetCurrentHP(mob)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
    end
  end
end
