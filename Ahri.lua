Config = scriptConfig("Ahri", "Ahri:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSQ", "KillSteal with Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSW", "KillSteal with W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSE", "KillSteal with E", SCRIPT_PARAM_ONOFF, false)
Config.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, false)
Config.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, false)
Config.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, false)

OnLoop(function(myHero)
Drawings()
Killsteal()

    if IWalkConfig.Combo then
        
        local target = GetTarget(1000, DAMAGE_MAGIC)
		if ValidTarget(target, 1000) then
				
			        local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1550,250,975,60,true,true)
                    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                    end
				
				local mousePos = GetMousePos()
				local ComboDmg = CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero)+ 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 25 + 35*GetCastLevel(myHero,_E) + 0.5*GetBonusAP(myHero))
			        if CanUseSpell(myHero, _R) == READY and ComboDmg < GetCurrentHP(target) and Config.R then
			        CastSkillShot(_R,mousePos.x,mousePos.y,mousePos.z)	
				end
					
			        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,250,880,100,false,true)
                                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                                end
					
			        if CanUseSpell(myHero, _W) == READY and ValidTarget(target,GetCastRange(myHero,_W)) and Config.W then
			        CastSpell(_W)
			        end
	        end
	end
	if IWalkConfig.Harass then
                    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target,GetCastRange(myHero,_E)) and Config.HarassE then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                    elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target,GetCastRange(myHero,_Q)) and Config.HarassQ then 
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                    elseif CanUseSpell(myHero, _W) == READY and ValidTarget(target,GetCastRange(myHero,_W)) and CanUseSpell(myHero, _W) == READY and Config.HarassW then
                    CastSpell(_W)
                    end
		end
        end
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2500,250,GetCastRange(myHero,_Q),100,false,true)
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1550,250,GetCastRange(myHero,_E),60,true,true)
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (35 + 25*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero))) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) and ValidTarget(enemy,GetCastRange(myHero,_W)) and Config.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero))) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _E) and ValidTarget(enemy,GetCastRange(myHero,_E)) and Config.KSE and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero))) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
	end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and Config.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and Config.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and Config.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and Config.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
AddGapcloseEvent(_E, 975, false)
