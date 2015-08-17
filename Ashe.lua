PrintChat("D3ftland Ashe By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Ashe", "Ashe")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, false)
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

myHero = GetMyHero()

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()

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

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
end
AddGapcloseEvent(_R, 1000, false)
