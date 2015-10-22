if GetObjectName(myHero) ~= "Jinx" then return end

local JinxMenu = Menu("Jinx", "Jinx")
JinxMenu:SubMenu("Combo", "Combo")
JinxMenu.Combo:Boolean("Q", "Use Q", true)
JinxMenu.Combo:Boolean("W", "Use W", true)
JinxMenu.Combo:Boolean("E", "Use E", true)
JinxMenu.Combo:Boolean("ECC", "Auto E on CCed", true)
JinxMenu.Combo:Boolean("R", "Use R (Finisher)", true)
JinxMenu.Combo:Boolean("Items", "Use Items", true)
JinxMenu.Combo:Slider("myHP", "if HP % <", 50, 0, 100, 1)
JinxMenu.Combo:Slider("targetHP", "if Target HP % >", 20, 0, 100, 1)
JinxMenu.Combo:Boolean("QSS", "Use QSS", true)
JinxMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)
JinxMenu.Combo:Boolean("Farm", "Switch Q in X/V", true)

JinxMenu:SubMenu("Harass", "Harass")
JinxMenu.Harass:Boolean("Q", "Use Q", true)
JinxMenu.Harass:Boolean("W", "Use W", true)
JinxMenu.Harass:Boolean("E", "Use E", true)
JinxMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

JinxMenu:SubMenu("Killsteal", "Killsteal")
JinxMenu.Killsteal:Boolean("W", "Killsteal with W", true)
JinxMenu.Killsteal:Boolean("R", "Killsteal with R", true)

JinxMenu:SubMenu("Misc", "Misc")
JinxMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
JinxMenu.Misc:Boolean("Autolvl", "Auto level", true)
JinxMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E"})

JinxMenu:SubMenu("Drawings", "Drawings")
JinxMenu.Drawings:Boolean("W", "Draw W Range", true)
JinxMenu.Drawings:Boolean("E", "Draw E Range", true)

OnDraw(function(myHero)
if JinxMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos(),1500,1,0,0xff00ff00) end
if JinxMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos(),920,1,0,0xff00ff00) end
end)

OnTick(function(myHero)

    if IOW:Mode() == "Combo" then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,1500,60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,920,60,false,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,700,3000,140,false,true)
		
	if GetItemSlot(myHero,3140) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	if CanUseSpell(myHero, _Q) == READY and JinxMenu.Combo.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 570 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 525 and JinxMenu.Combo.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, 920) and IsFacing(target, 920) and JinxMenu.Combo.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x-100,EPred.PredPos.y-100,EPred.PredPos.z-100)
        elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, 920) and JinxMenu.Combo.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x+100,EPred.PredPos.y+100,EPred.PredPos.z+100)
        end
	
	if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(target, 3000) and JinxMenu.Combo.R:Value() and GetCurrentHP(target) < GoS:CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(target)/1700))) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end

  end

    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= JinxMenu.Harass.Mana:Value() then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,1500,60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,920,60,false,true)
		
	if CanUseSpell(myHero, _Q) == READY and JinxMenu.Harass.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 570 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 525 and JinxMenu.Harass.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, 920) and IsFacing(target, 920) and JinxMenu.Harass.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x-100,EPred.PredPos.y-100,EPred.PredPos.z-100)
        elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, 920) and JinxMenu.Harass.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x+100,EPred.PredPos.y+100,EPred.PredPos.z+100)
        end
		
	end

local target = GetCurrentTarget()
local targetpos = GetOrigin(target)

if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 920) then
  if GotBuff(target, "snare") > 0 or GotBuff(target, "suppression") > 0 or GotBuff(target, "stun") > 0 then
  CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
  end
end

if IOW:Mode() == "LastHit" then
  if GotBuff(myHero, "JinxQ") > 0 and JinxMenu.Combo.Farm:Value() then
  CastSpell(_Q)
  end
end
  
if IOW:Mode() == "LaneClear" then
  if GotBuff(myHero, "JinxQ") > 0 and JinxMenu.Combo.Farm:Value() then
  CastSpell(_Q)
  end
end
  

    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
    
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),3300,600,1500,60,true,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2300,700,3000,140,false,true)
	
	if IOW:Mode() == "Combo" then	
	if GetItemSlot(myHero,3153) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > JinxMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > JinxMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
        end
		
	if Ignite and JinxMenu.Misc.AutoIgnite:Value() then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
		
        if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(enemy, 1500) and JinxMenu.Killsteal.W:Value() and WPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 50*GetCastLevel(myHero,_Q) - 40 + 1.4*GetBaseDamage(myHero)) then  
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	elseif CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(enemy, 3000) and GoS:GetDistance(myHero, enemy) > 400 and JinxMenu.Killsteal.R:Value() and RPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, (GetMaxHP(enemy)-GetCurrentHP(enemy))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(enemy)/1700))) then 
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
    end

if JinxMenu.Misc.Autolvl:Value() then
    if JinxMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
    elseif JinxMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
    end
LevelSpell(leveltable[GetLevel(myHero)])
end

end)


GoS:AddGapcloseEvent(_E, 0, false)
