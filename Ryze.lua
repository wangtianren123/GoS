local ARCANE_MASTERY = "ryzepassivestack"
local SUPERCHARGED = "ryzepassivecharged"

Config = scriptConfig("Ryze", "Ryze:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

OnLoop(function(myHero)

	if IWalkConfig.Combo then
	       local target = GetTarget(1000, DAMAGE_MAGIC)
	                if ValidTarget(target, 1000) then
		
		
		                local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,true,true)
                                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	                        end
			
                                if CanUseSpell(myHero, _R) == READY and (GotBuff(myHero, SUPERCHARGED) > 0 or GotBuff(myHero, ARCANE_MASTERY) > 3) and Config.R then
                                CastTargetSpell(myHero, _R)
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
