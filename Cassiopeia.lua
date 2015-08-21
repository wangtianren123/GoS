PrintChat("D3ftland Cassiopeia By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Cassiopeia", "Cassiopeia")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("Interrupt", "Interrupt Spells if lowHP", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, false)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, false)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["MasterYi"]                    = {_W},
    ["FiddleSticks"]                = {_W, _R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_R},
}

local callback = nil
 
OnProcessSpell(function(unit, spell)    
    if not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == GetTeam(GetMyHero()) then return end
    local unitChanellingSpells = CHANELLING_SPELLS[GetObjectName(unit)]
 
        if unitChanellingSpells then
            for _, spellSlot in pairs(unitChanellingSpells) do
                if spell.name == GetCastName(unit, spellSlot) then callback(unit, CHANELLING_SPELLS) end
            end
		end
end)
 
function addInterrupterCallback( callback0 )
        callback = callback0
end

OnLoop(function(myHero)
Drawings()
Killsteal()

if MiscConfig.Autolvl then
LevelUp()
end

local target = GetTarget(850, DAMAGE_MAGIC)
if target then
local poisoned = false
		for i=0, 63 do
			if GetBuffCount(target,i) > 0 and GetBuffName(target,i):lower():find("poison") then
				poisoned = true
			end
	        end
end
		
     if IWalkConfig.Combo then    
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,850,40,false,true)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,500,850,90,false,true)
		
	    if CanUseSpell(myHero, _E) == READY and Config.E and ValidTarget(target, 700) and poisoned then
			CastTargetSpell(target, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and Config.Q and ValidTarget(target, 850) and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and Config.W and ValidTarget(target, 850) and WPred.HitChance == 1 and not poisoned then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	  end
	  
	  if IWalkConfig.Harass then    
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,850,40,false,true)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,500,850,90,false,true)
		
	    if CanUseSpell(myHero, _E) == READY and HarassConfig.HarassE and ValidTarget(target, 700) and poisoned then
			CastTargetSpell(target, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, 850) and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and HarassConfig.HarassW and ValidTarget(target, 850) and WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	  end
	  
	  

end)

function Killsteal()
for i,enemy in pairs(GetEnemyHeroes()) do
        local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,600,850,40,false,true)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2500,500,850,90,false,true)
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 40*GetCastLevel(myHero,_Q)+35+.45*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_W)) and KSConfig.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 15*GetCastLevel(myHero,_W)+15+0.3*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		elseif CanUseSpell(myHero, _E) == READY and ValidTarget(enemy,GetCastRange(myHero,_E)) and KSConfig.KSE and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		CastTargeSpell(enemy, _E)
		end
	end
end


function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_W)
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
HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z, GetCastRange(myHero,_E) ,3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

if GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.25 then
local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,800,180,false,true)
addInterrupterCallback(function(target, spellType)
  if IsInDistance(target, GetCastRange(myHero,_R)) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
    CastTargetSpell(target, _E)
  end
end)
end
