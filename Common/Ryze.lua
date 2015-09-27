if GetObjectName(myHero) ~= "Ryze" then return end

RyzeMenu = Menu("Ryze", "Ryze")
RyzeMenu:SubMenu("Combo", "Combo")
RyzeMenu.Combo:Boolean("Q", "Use Q", true)
RyzeMenu.Combo:Boolean("W", "Use W", true)
RyzeMenu.Combo:Boolean("E", "Use E", true)
RyzeMenu.Combo:Boolean("R", "Use R", true)

RyzeMenu:SubMenu("Harass", "Harass")
RyzeMenu.Harass:Boolean("Q", "Use Q", true)
RyzeMenu.Harass:Boolean("W", "Use W", true)
RyzeMenu.Harass:Boolean("E", "Use E", true)
RyzeMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

RyzeMenu:SubMenu("Killsteal", "Killsteal")
RyzeMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
RyzeMenu.Killsteal:Boolean("W", "Killsteal with W", true)
RyzeMenu.Killsteal:Boolean("E", "Killsteal with E", true)

RyzeMenu:SubMenu("Misc", "Misc")
RyzeMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
RyzeMenu.Misc:Boolean("Autolvl", "Auto level", true)
RyzeMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E", "Q-E-W"})

RyzeMenu:SubMenu("JungleClear", "JungleClear")
RyzeMenu.JungleClear:Boolean("Q", "Use Q", true)
RyzeMenu.JungleClear:Boolean("W", "Use W", true)
RyzeMenu.JungleClear:Boolean("E", "Use E", true)
RyzeMenu.JungleClear:Boolean("R", "Use R", false)

RyzeMenu:SubMenu("Drawings", "Drawings")
RyzeMenu.Drawings:Boolean("Q", "Draw Q Range", true)
RyzeMenu.Drawings:Boolean("W", "Draw W Range", true)
RyzeMenu.Drawings:Boolean("E", "Draw E Range", true)
	
OnLoop(function(myHero)
  if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,true,true)
	local Q2Pred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,false,true)

	if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 700) and RyzeMenu.Combo.R:Value() and GotBuff(myHero, "ryzepassivestack") == 4 then
        CastSpell(_R)
	end  
	  
	if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 600) and RyzeMenu.Combo.W:Value() then
        CastTargetSpell(target, _W)
	end
		
        if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 600) and RyzeMenu.Combo.E:Value() then
        CastTargetSpell(target, _E)
	end
	
	if CanUseSpell(myHero, _Q) == READY and Q2Pred.HitChance == 1 and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and RyzeMenu.Combo.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
        elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and RyzeMenu.Combo.Q:Value() and GoS:ValidTarget(target, 900) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end				
		
  end

  if IOW:Mode() == "Harass" then
	
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,true,true)
	local Q2Pred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,false,true)
	 	  
	if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 600) and RyzeMenu.Harass.W:Value() then
        CastTargetSpell(target, _W)
	end
      
	if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 600) and RyzeMenu.Harass.E:Value() then
        CastTargetSpell(target, _E)
	end
	
	if CanUseSpell(myHero, _Q) == READY and Q2Pred.Hitchance == 1 and RyzeMenu.Harass.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
        elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and RyzeMenu.Harass.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
	
  end 

	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,900,55,true,true)
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if Ignite and RyzeMenu.Misc.Autoignite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 900) and RyzeMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_Q)+35+.55*GetBonusAP(myHero)+0.015*GetMaxMana(myHero)+0.005*GetCastLevel(myHero,_Q)*GetMaxMana(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(enemy, 600) and RyzeMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 60+20*GetCastLevel(myHero,_W)+0.4*GetBonusAP(myHero)+0.025*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _W)
		elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, 600) and RyzeMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 20+16*GetCastLevel(myHero,_E)+0.2*GetBonusAP(myHero)+0.02*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _E)
		end
		
	end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
        if IOW:Mode() == "LaneClear" then
		local mobPos = GetOrigin(mob)
		
		if CanUseSpell(myHero, _R) == READY and RyzeMenu.JungleClear.R:Value() and GotBuff(myHero, "ryzepassivestack") == 4 and GoS:ValidTarget(mob, 900) then
		CastSpell(_R)
		end
		
		if CanUseSpell(myHero, _W) == READY and RyzeMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 600) then
		CastTargetSpell(mob, _W)
		end
		
		if CanUseSpell(myHero, _Q) == READY and RyzeMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 900) then
		CastSkillShot(_Q, mobPos.x, mobPos.y, mobPos.z)
		end
		
	        if CanUseSpell(myHero, _E) == READY and RyzeMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 600) then
		CastTargetSpell(mob, _E)
		end
		
        end
end

if RyzeMenu.Misc.Autolvl:Value() then
   if RyzeMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
   elseif RyzeMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _W, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
   elseif RyzeMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

if RyzeMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,900,0,1,0xff00ff00) end
if RyzeMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,600,0,1,0xff00ff00) end
if RyzeMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,600,0,1,0xff00ff00) end

end)	

GoS:AddGapcloseEvent(_W, 600, true) -- hi Copy-Pasters ^^
