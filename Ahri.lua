AddInfo("Ahri", "Ahri:")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("E", "Use E", true)
AddButton("R", "Use R", true)

spellData = 
	{
	[_Q] = {dmg = function () return 80 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) end, },
	[_W] = {dmg = function () return 64 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) end, },
	[_E] = {dmg = function () return 60 + 35*GetCastLevel(myHero,_E) + 0.5*GetBonusAP(myHero) end, },
	[_R] = {dmg = function () return 210 + 120*GetCastLevel(myHero,_R) + 0.9*GetBonusAP(myHero) end },
	}

OnLoop(function(myHero)
        DamageCalc()
        if GetKeyValue("Combo") then
		local target = GetTarget(1000, DAMAGE_MAGIC)
		        if ValidTarget(target, 1000) then
				
				    local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1550,250,975,60,true,true)
                    if GetButtonValue("E") then
                     if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
                     CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                     end
                    end
					
					if GetButtonValue("R") then
			         local mousePos = GetMousePos()
			         if CanUseSpell(myHero, _R) == READY and ComboDmg < GetCurrentHP(target)then
			         CastSkillShot(_R,mousePos.x,mousePos.y,mousePos.z)
					     end
					end
					
					local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,250,880,100,false,true)
            if GetButtonValue("Q") then
               if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
               CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
               end
            end
					
					 if GetButtonValue("W") then
				       if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 500) then
				       CastTargetSpell(myHero, _W)
			         end
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
AddGapcloseEvent(_E, 975, true)
