AddInfo("Thresh", "Thresh:")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("E", "Use E", true)
AddButton("R", "Use R", true)

OnLoop(function(myHero)
     if GetKeyValue("Combo") then
        local target = GetTarget(1100, DAMAGE_MAGIC)
		local myHeroPos = nil
	            if ValidTarget(target, 1100) then
                    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
                    if GetButtonValue("Q") then
                     if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                     CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                     end
                    end
					
				   --local Obj_Type = GetObjectType(Object);
                  -- if Obj_Type == Obj_AI_Hero then
	               --if IsObjectAlive(Object) then
                    --local WPred = GetPredictionForPlayer(GetMyHeroPos(),ally,GetMoveSpeed(ally),1900,500,950,70,false,true)
                    --if GetButtonValue("W") then
                    -- if CanUseSpell(myHero, _W) == READY and IsInDistance(ally, 950) and WPred.HitChance == 1 then
                    -- CastSkillShot(--do what ever you want here, i'm noob)
                   --  end
                   -- end
				 --  end
				  --end
					
                    if GetButtonValue("E") then
                     local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,400,110,false,true)
                     if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ((GetCurrentHP(myHero)/(GetMaxHP(myHero)/100))) > 26 then
                     CastSkillShot(_E,EPred.PredPos.x-400,EPred.PredPos.y-400,EPred.PredPos.z-400)
		      else if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ((GetCurrentHP(myHero)/(GetMaxHP(myHero)/100))) < 26 then
                      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		      end
	       	     end
                    end
                    
					
					
           
                    if GetButtonValue("R") then
		        if CanUseSpell(myHero, _R) == READY and IsInDistance(target, 450) then
		        CastTargetSpell(myHero, _R)
			end
		    end
            end
     end
end)

function Closestally(pos)
    local ally = nil
    for k,v in pairs(GetAllyHeroes()) do 
        if not ally and v then ally = v end
        if ally and v and GetDistanceSqr(GetOrigin(ally),pos) > GetDistanceSqr(GetOrigin(v),pos) then
            ally = v
        end
    end
    a = GetOrigin(ally)
    return a
end

AddGapcloseEvent(_E, 450, true)
