require("Inspired")
require("IWalk")

AddInfo("Fizz", "Fizz")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("E", "Use E", true)
AddButton("R", "Use R", true)

OnLoop(function(myHero)
        IWalk()
		
		if GetKeyValue("Combo") then
		 local target = GetTarget(1275, DAMAGE_MAGIC)
	                if ValidTarget(target, 1275) then
			       local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1350,250,1275,120,false,true)
		               if GetButtonValue("R") then
                                if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
                                CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                        end
                               end
				
				if GetButtonValue("W") then
				 if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 300) then
				 CastTargetSpell(myHero, _W)
				 end
				end
				
				if GetButtonValue("Q") then
				 if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 550) then
				 CastTargetSpell(target, _Q)
			         end
				end
				 
				if GetButtonValue("E") then
			         if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 800) then
				 CastTargetSpell(target, _E)
			         end
				end
				
                        end
                end
end)
