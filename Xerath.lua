Config = scriptConfig("Xerath", "Xerath:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

Spells = 
	{
	[_Q] = {dmg = function () return 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) end, },
	[_W] = {dmg = function () return 30 + 30*GetCastLevel(myHero,_W) + 0.6*GetBonusAP(myHero) end, },
	[_E] = {dmg = function () return 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) end, },
	[_R] = {dmg = function () return 405 + 165*GetCastLevel(myHero,_R) + 1.29*GetBonusAP(myHero) end,},
	}
	
	OnLoop(function(myHero)
	GetTickCount()
        if IWalkConfig.Combo then
		local target = GetTarget(5600, DAMAGE_MAGIC)
		        if ValidTarget(target, 1550) then
				     
		            local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,1150,60,true,true)
                    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                    end
                    
					
		            local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,1000,125,false,true)
                    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                    end
             
			        local _Qrange = 750 + math.min(725, 725 * (GetTickCount() - startTick) / 1500) 	
                    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
                    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then 
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
					end
					
					if GotBuff(myHero, "XerathArcanopulseChargeUp") then
					CastSkillShot2(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                    end
					
				end
				
				local target = GetTarget(5600, DAMAGE_MAGIC)
                if ValidTarget(target) then
				    local _Rrange = function () return 800 + 1050*GetCastLevel(myHero,_R) end
					local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,_Rrange,120,false,true)
                    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
					CastSpell(_R)
					else if GotBuff(myHero, "XerathLocusOfPower2") then
					HoldPosition()
				    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
		            end
					end
				end
		end
end)

function DamageCalc()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy,5600) then
			ComboDmg = spellData[_R].dmg()
			TrueDmg = CalcDamage(myHero, enemy, 0, ComboDmg)
		end
	end
end
