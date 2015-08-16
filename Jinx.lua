PrintChat("D3ftland Jinx By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Jinx", "Jinx")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
ExtraConfig = scriptConfig("Extra", "Extra")
ExtraConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, false)
ExtraConfig.addParam("Baseult", "Baseult", SCRIPT_PARAM_ONOFF, false)
ExtraConfig.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
ExtraConfig.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
ExtraConfig.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
ExtraConfig.addParam("Item4", "Use QSS (broken)", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawRange","Draw AA Range", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()

if ExtraConfig.Autolvl then
LevelUp()
end

if ExtraConfig.Baseult then
Baseult()
end

local target = GetTarget(2500, DAMAGE_PHYSICAL)
 if IWalkConfig.Combo then
   if CanUseSpell(myHero, _Q) == READY then
        if GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
        CastSpell(_Q)
        elseif GetDistance(myHero, target) < 570 and GotBuff(myHero, "JinxQ") > 0 then
        CastSpell(_Q)
        end
    end
  end
end)

function Killsteal()
   for i,enemy in pairs(GetEnemyHeroes()) do
   local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1150,40,true,true)
   local RPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,20000,600,false,true)
       if CanUseSpell(myHero, _W) == READY and ValidTarget(enemy, GetCastRange(myHero,_W)) and KSConfig.KSW and WPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 50*GetCastLevel(myHero,_Q) - 40 + 1.4*GetBaseDamage(myHero)) then  
       CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	   elseif CanUseSpell(myHero, _R) == READY and ValidTarget(enemy, 4000) and KSConfig.KSR and RPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, (GetMaxHP(enemy)-GetCurrentHP(enemy))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GetDistance(enemy)/1700))) >= GetCurrentHP(enemy) then 
       CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
       end
   end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_W)
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
local HeroPos = GetOrigin(myHero)
DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetRange(myHero),3,100,0xff00ff00)
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end
