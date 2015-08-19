PrintChat("D3ftland Ashe By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Ashe", "Ashe")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, false)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item5", "Use Mercurial", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
BaseUltConfig = scriptConfig("BaseUlt", "BaseUlt")
BaseUltConfig.addParam("doIt", "BaseUlt (broken)", SCRIPT_PARAM_ONOFF, true) 

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

if GetItemSlot(myHero,3140) > 0 and MiscConfig.Item4 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3140))
end

if GetItemSlot(myHero,3139) > 0 and MiscConfig.Item5 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3139))
end	

        local target = GetTarget(1000, DAMAGE_PHYSICAL)
	if ValidTarget(target, 1000) then
		if IWalkConfig.Combo then
			if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and IsInDistance(target, 700) and Config.Q then
                        CastSpell(_Q)
                        end
						
			local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_W),50,true,true)
                        if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	                end
						
					
                        local target = GetTarget(1000, DAMAGE_PHYSICAL)
			local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
                        if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GetCurrentHP(target)/GetMaxHP(target) < 0.5 and Config.R then
                        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                end
	                
	                if GetItemSlot(myHero,3153) > 0 and MiscConfig.Item1 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
                        CastTargetSpell(target, GetItemSlot(myHero,3153))
                        end

                        if GetItemSlot(myHero,3144) > 0 and MiscConfig.Item2 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
                        CastTargetSpell(target, GetItemSlot(myHero,3144))
                        end

                        if GetItemSlot(myHero,3142) > 0 and MiscConfig.Item3 then
                        CastTargetSpell(GetItemSlot(myHero,3142))
                        end
		end
	end
		
	if IWalkConfig.Harass then
	        local target = GetTarget(1000, DAMAGE_PHYSICAL)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_W),50,true,true)
		              
		if ValidTarget(target, 1000) then
		
		     if (GetCurrentMana(myHero)/GetMaxMana(myHero)) > 0.2 then
			if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and IsInDistance(target, 700) and HarassConfig.HarassQ then
                        CastSpell(_Q)
                        elseif CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and HarassConfig.HarassW then
                        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
			end
	             end
		end
	end
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	          local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2000,250,GetCastRange(myHero,_W),50,true,true)
		  if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_W)) and KSConfig.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 15*GetCastLevel(myHero,_W)+5+GetBaseDamage(myHero), 0) then 
		  CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		  end
		  local RPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,20000,130,false,true)
		  if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(enemy, 3000) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 175*GetCastLevel(myHero,_R) + 75 + GetBonusAP(myHero)) then
                  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		  end
	end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
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
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
end

addInterrupterCallback(function(target, spellType)
local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
  if IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

AddGapcloseEvent(_R, 1000, false)
