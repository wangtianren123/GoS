if GetObjectName(myHero) ~= "Cassiopeia" then return end

require('Deftlib')

local CassiopeiaMenu = Menu("Cassiopeia", "Cassiopeia")
CassiopeiaMenu:SubMenu("Combo", "Combo")
CassiopeiaMenu.Combo:Boolean("Q", "Use Q", true)
CassiopeiaMenu.Combo:Boolean("W", "Use W", true)
CassiopeiaMenu.Combo:Boolean("E", "Use E", true)
CassiopeiaMenu.Combo:Boolean("R", "Use R", true)

CassiopeiaMenu:SubMenu("Harass", "Harass")
CassiopeiaMenu.Harass:Boolean("Q", "Use Q", true)
CassiopeiaMenu.Harass:Boolean("W", "Use W", true)
CassiopeiaMenu.Harass:Boolean("E", "Use E", true)

CassiopeiaMenu:SubMenu("Killsteal", "Killsteal")
CassiopeiaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
CassiopeiaMenu.Killsteal:Boolean("W", "Killsteal with W", true)
CassiopeiaMenu.Killsteal:Boolean("E", "Killsteal with E", true)

CassiopeiaMenu:SubMenu("Misc", "Misc")
CassiopeiaMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
CassiopeiaMenu.Misc:Boolean("Autolvl", "Auto level", true)
CassiopeiaMenu.Misc:List("Autolvltable", "Priority", 1, {"E-Q-W", "Q-E-W", "W-E-Q"})
CassiopeiaMenu.Misc:Boolean("Interrupt", "Interrupt Spells with R", true)
CassiopeiaMenu.Misc:Slider("HP", "if HP % <", 50, 1, 100, 1)

CassiopeiaMenu:SubMenu("Farm", "Farm")
CassiopeiaMenu.Misc:Boolean("AutoE", "Auto E if pois", true)
CassiopeiaMenu.Farm:SubMenu("LastHit2", "LastHit with E")
CassiopeiaMenu.Farm.LastHit2:Boolean("EX", "Enabled", true)
CassiopeiaMenu.Farm.LastHit2:Boolean("EXP", "Only if pois", true)
CassiopeiaMenu.Farm:SubMenu("LaneClear", "LaneClear")
CassiopeiaMenu.Farm.LaneClear:Boolean("E", "Use E", true)
CassiopeiaMenu.Farm.LaneClear:Slider("Mana", "Min Mana %", 50, 1, 100, 1)

CassiopeiaMenu:SubMenu("JungleClear", "JungleClear")
CassiopeiaMenu.JungleClear:Boolean("Q", "Use Q", true)
CassiopeiaMenu.JungleClear:Boolean("W", "Use W", true)
CassiopeiaMenu.JungleClear:Boolean("E", "Use E", true)

CassiopeiaMenu:SubMenu("Drawings", "Drawings")
CassiopeiaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
CassiopeiaMenu.Drawings:Boolean("W", "Draw W Range", false)
CassiopeiaMenu.Drawings:Boolean("E", "Draw E Range", false)
CassiopeiaMenu.Drawings:Boolean("R", "Draw R Range", false)

OnLoop(function(myHero)

    if IOW:Mode() == "Combo" then

		local unit = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,300,825, 80*math.pi/180,false,true)
	      
		if IsFacing(unit, 825) and GoS:ValidTarget(unit, 825) and CassiopeiaMenu.Combo.R:Value() and 100*GetCurrentHP(unit)/GetMaxHP(unit) <= 50 and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= 30 then
		CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end
	       
                local poisoned = false
                if GotBuff(unit, "cassiopeianoxiousblastpoison") > 0 or GotBuff(unit, "cassiopeiamiasmapoison") > 0 and GoS:ValidTarget(unit, 700) then
                poisoned = true
                end

	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Combo.E:Value() and GoS:ValidTarget(unit, 700) and poisoned then
		CastTargetSpell(unit, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.Combo.Q:Value() and GoS:ValidTarget(unit, 850) and QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.Combo.W:Value() and GoS:ValidTarget(unit, 925) and WPred.HitChance == 1 and not targetpoisoned then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
    end

    if IOW:Mode() == "Harass" then
	
		local unit = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,300,800,180,false,true)

                local poisoned = false
                if GotBuff(unit, "cassiopeianoxiousblastpoison") > 0 or GotBuff(unit, "cassiopeiamiasmapoison") > 0 and GoS:ValidTarget(unit, 700) then
                poisoned = true
                end

	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Harass.E:Value() and GoS:ValidTarget(unit, 700) and poisoned then
		CastTargetSpell(unit, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.Harass.Q:Value() and GoS:ValidTarget(unit, 850) and QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.Harass.W:Value() and GoS:ValidTarget(unit, 925) and WPred.HitChance == 1 then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
    end

	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,300,800,180,false,true)
		
		if Ignite and CassiopeiaMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
		end
		
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 850) and CassiopeiaMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40*GetCastLevel(myHero,_Q)+35+.45*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(enemy, 850) and CassiopeiaMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 15*GetCastLevel(myHero,_W)+15+0.3*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, 700) and CassiopeiaMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _E)
		end
		
	end

if CassiopeiaMenu.Misc.Autolvl:Value() then    
   if CassiopeiaMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _E, _W, _E, _E, _R, _E, _Q, _E , _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
   elseif CassiopeiaMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
   elseif CassiopeiaMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _E, _W, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do

		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
                       
                local poisoned = false
                if GotBuff(minion, "cassiopeianoxiousblastpoison") > 0 or GotBuff(minion, "cassiopeiamiasmapoison") > 0 and GoS:ValidTarget(minion, 700) then
                poisoned = true
                end

        if IOW:Mode() == "LaneClear" then
		  if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LaneClear.E:Value() and GoS:IsInDistance(minion, 700) and poisoned and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= CassiopeiaMenu.Farm.LaneClear.Mana:Value() then
		  CastTargetSpell(minion, _E)
	          end
	end
	
	if IOW:Mode() == "LastHit" then
	          if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LastHit2.EX:Value() and CassiopeiaMenu.Farm.LastHit2.EXP:Value() and GoS:IsInDistance(minion, 700) and poisoned and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		  CastTargetSpell(minion, _E)
		  elseif CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LastHit2.EX:Value() and not CassiopeiaMenu.Farm.LastHit2.EXP:Value() and GoS:IsInDistance(minion, 700) and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		  CastTargetSpell(minion, _E)
		  end
	end
	
	    if CassiopeiaMenu.Misc.AutoE:Value() then
	      if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(minion, 700) and poisoned and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) and IOW:Mode() ~= "Combo" then
	      CastTargetSpell(minion, _E)
	      end
	    end
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
        
	local mobPos = GetOrigin(mob)

                local poisoned = false
                if GotBuff(mob, "cassiopeianoxiousblastpoison") > 0 or GotBuff(mob, "cassiopeiamiasmapoison") > 0 and GoS:ValidTarget(mob, 700) then
                poisoned = true
                end

        if IOW:Mode() == "LaneClear" then
		
	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.JungleClear.E:Value() and GoS:IsInDistance(mob, 700) and poisoned then
		CastTargetSpell(mob, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.JungleClear.Q:Value() and GoS:IsInDistance(mob, 850) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.JungleClear.W:Value() and GoS:IsInDistance(mob, 925) then
		CastSkillShot(_W,mobPos.x, mobPos.y, mobPos.z)
		end
	end
end

if CassiopeiaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),1,128,0xff00ff00) end
if CassiopeiaMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),1,128,0xff00ff00) end
if CassiopeiaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,1,128,0xff00ff00) end
if CassiopeiaMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),1,128,0xff00ff00) end

end)
