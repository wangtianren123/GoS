if GetObjectName(myHero) ~= "Sivir" then return end

local SivirMenu = Menu("Sivir", "Sivir")
SivirMenu:SubMenu("Combo", "Combo")
SivirMenu.Combo:Boolean("Q", "Use Q", true)
SivirMenu.Combo:Slider("QMana", "Q if Mana % >", 30, 0, 80, 1)
SivirMenu.Combo:Boolean("W", "Use W", true)
SivirMenu.Combo:Boolean("R", "Use R", true)
SivirMenu.Combo:Slider("Rmin", "Minimum Enemies in Range", 2, 1, 5, 1)
SivirMenu.Combo:Slider("RMana", "R if Mana % >", 30, 0, 80, 1)
SivirMenu.Combo:Boolean("Items", "Use Items", true)
SivirMenu.Combo:Slider("myHP", "if HP % <", 50, 0, 100, 1)
SivirMenu.Combo:Slider("targetHP", "if Target HP % >", 20, 0, 100, 1)
SivirMenu.Combo:Boolean("QSS", "Use QSS", true)
SivirMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)

SivirMenu:SubMenu("Harass", "Harass")
SivirMenu.Harass:Boolean("Q", "Use Q", true)
SivirMenu.Harass:Boolean("W", "Use W", true)
SivirMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

SivirMenu:SubMenu("Killsteal", "Killsteal")
SivirMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)

SivirMenu:SubMenu("Misc", "Misc")
SivirMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
SivirMenu.Misc:Boolean("Autolvl", "Auto level", true)
SivirMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E", "E-Q-W"})

SivirMenu:SubMenu("Drawings", "Drawings")
SivirMenu.Drawings:Boolean("Q", "Draw Q Range", true)


OnLoop(function(myHero)
 if IOW:Mode() == "Combo" then
	
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1350,250,1075,85,false,true)
	
	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1075) and SivirMenu.Combo.Q:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SivirMenu.Combo.QMana:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
	if GetItemSlot(myHero,3140) > 0 and SivirMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SivirMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and SivirMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SivirMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 600) and SivirMenu.Combo.R:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SivirMenu.Combo.RMana:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 600) >= SivirMenu.Combo.Rmin:Value() then
	CastSpell(_R)
	end

 end

 if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SivirMenu.Harass.Mana:Value() then
 
        local target = GetCurrentTarget()
 	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1350,250,1075,85,false,true)
	
	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1075) and SivirMenu.Harass.Q:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end

 end
 
 for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1350,250,1075,85,false,true)
	
	if IOW:Mode() == "Combo" then	
	if GetItemSlot(myHero,3153) > 0 and SivirMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SivirMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > SivirMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and SivirMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SivirMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > SivirMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and SivirMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
        end
        
	if Ignite and SivirMenu.Misc.AutoIgnite:Value() then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
	end
	
	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 1075) and SivirMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 20*GetCastLevel(myHero,_Q)+5+(0.6+0.1*GetCastLevel(myHero, _Q))*(GetBaseDamage(myHero)+GetBonusDmg(myHero)) + 0.5*GetBonusAP(myHero), 0) then 
	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
		
end
  
if SivirMenu.Misc.Autolvl:Value() then
      if SivirMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_W, _Q, _E, _Q, _Q , _R, _Q , _W, _Q , _W, _R, _W, _W, _E, _E, _R, _E, _E}
      elseif SivirMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
      elseif SivirMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_W, _Q, _E, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
      end
LevelSpell(leveltable[GetLevel(myHero)])
end

if SivirMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,1075,1,128,0xff00ff00) end

end)

OnProcessSpell(function(unit, spell)
    local target = GetCurrentTarget()
    if unit and spell and spell.name then
      if unit == myHero then
        if spell.name:lower():find("attack") then 
	        GoS:DelayAction(function() 

                                 if IOW:Mode() == "Combo" and GoS:ValidTarget(target, 600) and CanUseSpell(myHero, _W) == READY and SivirMenu.Combo.W:Value() then	  
                                 CastSpell(_W)		
 			         end
                                                
                                 if IOW:Mode() == "Harass" and GoS:ValidTarget(target, 600) and CanUseSpell(myHero, _W) == READY and SivirMenu.Harass.W:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SivirMenu.Harass.Mana:Value() then	  
                                 CastSpell(_W)
                                 end
                       
                end, GetWindUp(myHero)*1000)
            end
      end
  end
end)
