PrintChat("D3ftland Katarina By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Ryze", "Ryze")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSQ", "KillSteal with Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSW", "KillSteal with W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KSE", "KillSteal with E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, false)

OnLoop(function(myHero)
Drawings()
Killsteal()

	
	       local target = GetTarget(600, DAMAGE_MAGIC)
	                if ValidTarget(target, 600) then
if IWalkConfig.Combo then	
		
		                local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,true,true)
				local Q2Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,false,true)
                                if CanUseSpell(myHero, _Q) == READY and Q2Pred.HitChance == 1 and Config.Q and (GotBuff(myHero, "ryzepassivecharged") > 0) then
                                CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
				elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	                        end
			
                                if CanUseSpell(myHero, _R) == READY and (GotBuff(myHero, "ryzepassivecharged") > 0 or GotBuff(myHero, "ryzepassivestack") > 3) and Config.R then
                                CastSpell(_R)
		                end
			
                                if CanUseSpell(myHero, _W) == READY and Config.W then
                                CastTargetSpell(target, _W)
		                end
			
	                        if CanUseSpell(myHero, _E) == READY and Config.E then
                                CastTargetSpell(target, _E)
		                end
	                end
	end	
end)

OnLoop(function(myHero)

	
	    local target = GetTarget(1000, DAMAGE_MAGIC)
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,true,true)
                                if ValidTarget(target, 1000) then
if IWalkConfig.Harass then							   
					if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target,GetCastRange(myHero,_Q)) and Config.HarassQ then 
                                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
					elseif CanUseSpell(myHero, _W) == READY and ValidTarget(target,GetCastRange(myHero,_W)) and Config.HarassW then
                                        CastTargetSpell(target, _W)
					elseif CanUseSpell(myHero, _E) == READY and ValidTarget(target,GetCastRange(myHero,_E)) and Config.HarassE then
                                        CastTargetSpell(target, _E)
					end
				end
	end
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,GetCastRange(myHero,_Q),55,true,true)
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (25*GetCastLevel(myHero,_Q)+35+.55*GetBonusAP(myHero)+0.015*GetMaxMana(myHero)+0.005*GetCastLevel(myHero,_Q)*GetMaxMana(myHero))) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) and ValidTarget(enemy,GetCastRange(myHero,_W)) and Config.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (60+20*GetCastLevel(myHero,_W)+0.4*GetBonusAP(myHero)+0.025*GetMaxMana(myHero))) then
		CastTargetSpell(enemy, _W)
		elseif CanUseSpell(myHero, _E) and ValidTarget(enemy,GetCastRange(myHero,_E)) and Config.KSE and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (20+16*GetCastLevel(myHero,_E)+0.2*GetBonusAP(myHero)+0.02*GetMaxMana(myHero))) then
		CastTargetSpell(enemy, _E)
		end
	end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and Config.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and Config.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and Config.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end
