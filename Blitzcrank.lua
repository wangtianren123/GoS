AddInfo("Blitzcrank", "Blitzcrank")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("E", "Use E", true)
AddButton("R", "Use R", true)

OnLoop(function(myHero)
        IWalk()

	if GetKeyValue("Combo") then
	local target = GetTarget(1000, DAMAGE_MAGIC)
	    if ValidTarget(target, 1000) then
		  local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,925,70,true,true)
		        if GetButtonValue("Q") then
             if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
             CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	           end
            end
			
		        if GetButtonValue("W") then
                 if CanUseSpell(myHero, _W) == READY and not IsInDistance(target, 150) and IsInDistance(target, 400) then
                 CastTargetSpell(myHero, _W)
		         end
		        end
			
		        if GetButtonValue("E") then
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 250) then
                 CastTargetSpell(myHero, _E)
		         end
                end
		  local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),0,250,0,600,true,true)	
		          if GetButtonValue("R") then
	             if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
               CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	             end
              end
	    end
	end	
end)
