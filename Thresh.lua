Config = scriptConfig("Thresh", "Thresh:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

OnLoop(function(myHero)
	
        if IWalkConfig.Combo then
	       local target = GetTarget(1100, DAMAGE_MAGIC)
	                if ValidTarget(target, 1100) then
                        
                                local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
                                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                                end
                        
					
                                local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,400,110,false,true)
                                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ((GetCurrentHP(myHero)/(GetMaxHP(myHero)/100))) > 26 then
                                CastSkillShot(_E,EPred.PredPos.x-400,EPred.PredPos.y-400,EPred.PredPos.z-400)
		                else if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ((GetCurrentHP(myHero)/(GetMaxHP(myHero)/100))) < 26 then
                                CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		                end
	       	                end
                    
					
           
		                if CanUseSpell(myHero, _R) == READY and IsInDistance(target, 450) and Config.R then
		                CastTargetSpell(myHero, _R)
			        end
		        end
        end
end)
AddGapcloseEvent(_E, 450, false)
