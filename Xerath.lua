Config = scriptConfig("Xerath", "Xerath:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

spellData = 
	{
	[_Q] = {dmg = function () return 80 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) end, },
	[_W] = {dmg = function () return 60 + 30*GetCastLevel(myHero,_W) + 0.6*GetBonusAP(myHero) end, },
	[_E] = {dmg = function () return 80 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) end, },
	[_R] = {dmg = function () return 570 + 165*GetCastLevel(myHero,_R) + 1.29*GetBonusAP(myHero) end,
	      range = function () return 1850 + 1050*GetCastLevel(myHero,_R) end },
	}
	

OnLoop(function(myHero)
        if IWalkConfig.Combo then
		local target = GetTarget(1600, DAMAGE_MAGIC)
		        if ValidTarget(target, 1600) then
				     
		     local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,200,1150,60,true,true)
                     if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                     CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                     end
                    
					
		     local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,1000,200,true,true)
                     if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 Config.W then
                     CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                     end
             
					
                    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,1600,100,false,true)
                    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                    end

		    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                    CastSkillShot2(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	            end
					
			end
		end
end)
