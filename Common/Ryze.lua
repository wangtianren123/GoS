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

	if SpellRREADY and GoS:ValidTarget(target, 700) and RyzeMenu.Combo.R:Value() and GotBuff(myHero, "ryzepassivestack") == 4 then
        CastSpell(_R)
	end  
	  
	if SpellWREADY and GoS:ValidTarget(target, 600) and RyzeMenu.Combo.W:Value() then
        CastTargetSpell(target, _W)
	end
						    
	if SpellQREADY and Q2Pred.HitChance == 1 and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and RyzeMenu.Combo.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
        elseif SpellQREADY and QPred.HitChance == 1 and RyzeMenu.Combo.Q:Value() and GoS:ValidTarget(target, 900) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
						  
	if SpellEREADY and GoS:ValidTarget(target, 600) and RyzeMenu.Combo.E:Value() then
        CastTargetSpell(target, _E)
	end
		
  end

  if IOW:Mode() == "Harass" then
	
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,true,true)
	local Q2Pred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,false,true)
	 	  
	if SpellWREADY and GoS:ValidTarget(target, 600) and RyzeMenu.Harass.W:Value() then
        CastTargetSpell(target, _W)
	end
      
	if SpellQREADY and Q2Pred.Hitchance == 1 and RyzeMenu.Harass.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
        elseif SpellQREADY and QPred.HitChance == 1 and RyzeMenu.Harass.Q:Value() and GoS:ValidTarget(target, 900) then
	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
						  
	if SpellEREADY and GoS:ValidTarget(target, 600) and RyzeMenu.Harass.E:Value() then
        CastTargetSpell(target, _E)
	end
	
  end 

	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,900,55,true,true)
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if Ignite and RyzeMenu.Misc.Autoignite:Value() then
                  if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
		if SpellQREADY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 900) and RyzeMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_Q)+35+.55*GetBonusAP(myHero)+0.015*GetMaxMana(myHero)+0.005*GetCastLevel(myHero,_Q)*GetMaxMana(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif SpellWREADY and GoS:ValidTarget(enemy, 600) and RyzeMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 60+20*GetCastLevel(myHero,_W)+0.4*GetBonusAP(myHero)+0.025*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _W)
		elseif SpellEREADY and GoS:ValidTarget(enemy, 600) and RyzeMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 20+16*GetCastLevel(myHero,_E)+0.2*GetBonusAP(myHero)+0.02*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _E)
		end
		
	end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
        if IOW:Mode() == "LaneClear" then
		local mobPos = GetOrigin(mob)
		
		if SpellRREADY and RyzeMenu.JungleClear.R:Value() and GotBuff(myHero, "ryzepassivestack") == 4 and GoS:ValidTarget(mob, 900) then
		CastSpell(_R)
		end
		
		if SpellWREADY and RyzeMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 600) then
		CastTargetSpell(mob, _W)
		end
		
		if SpellQREADY and RyzeMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 900) then
		CastSkillShot(_Q, mobPos.x, mobPos.y, mobPos.z)
		end
		
	        if SpellEREADY and RyzeMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 600) then
		CastTargetSpell(mob, _E)
		end
		
        end
end

if RyzeMenu.Misc.Autolvl:Value() then

if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end

end

if RyzeMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if RyzeMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if RyzeMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end

SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY

end)	
