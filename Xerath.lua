Config = scriptConfig("Xerath", "Xerath:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
	
OnLoop(function(myHero)
    if IWalkConfig.Combo and waitTickCount < GetTickCount() then
    local target = GetTarget(1500, DAMAGE_MAGIC)
    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 1500) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 730 + math.min(770, i/2)
              local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
              if Pred.HitChance >= 1 then
                CastSkillShot2(_Q, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
              end
          end, i)
      end
    end
				

		            local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,1000,125,false,true)
                    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                    end
					
		            local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,1050,60,true,true)
                    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                    end
                    
					
				
				local range = function () return 800 + 1050*GetCastLevel(myHero,_R) end
				 local target = GetTarget(range(), DAMAGE_MAGIC)
				    local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,range,120,false,true)
                    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R and CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero)) < GetCurrentHP(target) then
					waitTickCount = GetTickCount() + 550
					CastSpell(_R)
					CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
				    DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 250)
					DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 300)
		            end
	    end
end)
