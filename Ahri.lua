Config = scriptConfig("Ahri", "Ahri:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

spellData = 
	{
	[_Q] = {dmg = function () return 35 + 25*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) end, },
	[_W] = {dmg = function () return 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) end, },
	[_E] = {dmg = function () return 25 + 35*GetCastLevel(myHero,_E) + 0.5*GetBonusAP(myHero) end, },
	[_R] = {dmg = function () return 90 + 120*GetCastLevel(myHero,_R) + 0.9*GetBonusAP(myHero) end },
	}

OnLoop(function(myHero)
        DamageCalc()
        if IWalkConfig.Combo then
		local target = GetTarget(1000, DAMAGE_MAGIC)
		        if ValidTarget(target, 1000) then
				
			        local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1550,250,975,60,true,true)
                                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                                CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                                end
				
				local mousePos = GetMousePos()
			        if CanUseSpell(myHero, _R) == READY and ComboDmg < GetCurrentHP(target) and Config.R then
			        CastSkillShot(_R,mousePos.x,mousePos.y,mousePos.z)	
				end
					
				local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,250,880,100,false,true)
                                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                                end
					
			        if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 500) and Config.W then
			        CastTargetSpell(myHero, _W)
			        end
					
			end
        end
end)
								
function DamageCalc()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy, 1000) then
			ComboDmg = spellData[_Q].dmg() + spellData[_W].dmg() + spellData[_E].dmg()
			TrueDmg = CalcDamage(myHero, enemy, 0, ComboDmg)
	  end
	end
end
AddGapcloseEvent(_E, 975, false)
