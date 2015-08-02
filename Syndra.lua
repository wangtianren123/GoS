Config = scriptConfig("Syndra", "Syndra")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
	
OnLoop(function(myHero)

	if IWalkConfig.Combo then
	       local target = GetTarget(1000, DAMAGE_MAGIC)
	                if ValidTarget(target, 1000) then
		
		
		                        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
								local QEPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,500,730,45,false,true)
                                if QPred.HitChance == 1 and QEPred.HitChance == 1 and Config.Q and Config.E then
								CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)								
			                    DelayAction(function() CastSkillShot(_E,QEPred.PredPos.x,QEPred.PredPos.y,QEPred.PredPos.z) end, 0.25)
					            end
								
								local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,800,925,190,false,true)
								if CanUseSpell(myHero, _W) == READY then
								DelayAction(function() CastTargetSpell(Obj_AI_Minion, _W) end, 0.2)
                                end
								
                                if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                                CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                                end
								
								if CanUseSpell(myHero, _R) == READY and CalcDamage(myHero, target, 0, math.max(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero),(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero))*7)) > GetCurrentHP(target) and Config.R then
								CastTargetSpell(target, _R)
								end
								
                      end
    end
end)
