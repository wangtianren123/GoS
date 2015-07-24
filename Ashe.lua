AddInfo("Ashe", "Ashe:")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("R", "Use R", true)

OnLoop(function(myHero)
        
		if GetKeyValue("Combo") then
		 local target = GetTarget(2000, DAMAGE_PHYSICAL)
	                if ValidTarget(target, 2000) then
					     
						if GetButtonValue("Q") then
				         if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and IsInDistance(target, 700) then
				         CastTargetSpell(myHero, _Q)
			             end
				        end
						
						local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,250,1200,50,true,true)
		                if GetButtonValue("W") then
                         if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
                         CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	                     end
                        end
		
						local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
		                if GetButtonValue("R") then
                         if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
                         CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                     end
                        end
					end
		end
end)
						
						
