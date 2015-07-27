Config = scriptConfig("Fizz", "Fizz:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

OnLoop(function(myHero)
		
        if IWalkConfig.Combo then
	       local target = GetTarget(1275, DAMAGE_MAGIC)
	                if ValidTarget(target, 1275) then
	                	
	                	
			        local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1350,250,1275,120,false,true)
                                if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
                                CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                        end
				
				if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 300) and Config.W then
				CastTargetSpell(myHero, _W)
				end
				
				if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 550) and Config.Q then
			        CastTargetSpell(target, _Q)
			        end
				 
			         if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 800) and Config.E then
				 CastTargetSpell(target, _E)
			         end
				
                        end
        end
end)
