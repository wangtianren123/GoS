if GetObjectName(myHero) ~= "Jinx" then return end

JinxMenu = Menu("Jinx", "Jinx")
JinxMenu:SubMenu("Combo", "Combo")
JinxMenu.Combo:Boolean("Q", "Use Q", true)
JinxMenu.Combo:Boolean("W", "Use W", true)
JinxMenu.Combo:Boolean("E", "Use E", true)
JinxMenu.Combo:Boolean("ECC", "Auto E on CCed", true)
JinxMenu.Combo:Boolean("R", "Use R (Finisher)", true)
JinxMenu.Combo:Boolean("Items", "Use Items", true)
JinxMenu.Combo:Boolean("QSS", "Use QSS", true)
JinxMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)
JinxMenu.Combo:Boolean("Farm", "Switch Q in X/V", true)

JinxMenu:SubMenu("Harass", "Harass")
JinxMenu.Harass:Boolean("Q", "Use Q", true)
JinxMenu.Harass:Boolean("W", "Use W", true)
JinxMenu.Harass:Boolean("E", "Use E", true)
JinxMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

JinxMenu:SubMenu("Killsteal", "Killsteal")
JinxMenu.Killsteal:Boolean("E", "Killsteal with E", true)
JinxMenu.Killsteal:Boolean("R", "Killsteal with R", true)

JinxMenu:SubMenu("Misc", "Misc")
JinxMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
JinxMenu.Misc:Boolean("Autolvl", "Auto level", true)

JinxMenu:SubMenu("Drawings", "Drawings")
JinxMenu.Drawings:Boolean("W", "Draw W Range", true)
JinxMenu.Drawings:Boolean("E", "Draw E Range", true)

local Tick = 0

OnLoop(function(myHero)
Tick = Tick + 1
Checks()
Drawings()

if Tick > 20 then
Combo()
Harass()
BullShit()
Killsteal()
Autolvl()
Tick = 0
end		

end)

function Combo()

    if IOW:Mode() == "Combo" then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,700,2500,140,false,true)
		
	if GetItemSlot(myHero,3153) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(target, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	if SpellQREADY and JinxMenu.Combo.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 525 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if SpellWREADY and WPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and JinxMenu.Combo.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if SpellEREADY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and JinxMenu.Combo.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end
	
	if SpellRREADY and RPred.HitChance == 1 and GoS:ValidTarget(target, 2500) and JinxMenu.Combo.R:Value() and GetCurrentHP(target) < GoS:CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(target)/1700))) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end

  end
end

function Harass()

    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= JinxMenu.Harass.Mana:Value() then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
		
	if SpellQREADY and JinxMenu.Harass.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 525 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if SpellWREADY and WPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and JinxMenu.Harass.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if SpellEREADY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and JinxMenu.Harass.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end
		
	end
end

function BullShit()

local target = GetCurrentTarget()
local targetpos = GetOrigin(target)

if SpellEREADY and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and GotBuff(target, "snare") > 0 or GotBuff(target, "suppression") > 0 or GotBuff(target, "stun") > 0 then
CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
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
  
end

function Killsteal()
    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
    
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),3300,600,GetCastRange(myHero,_W),60,true,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2300,700,4000,140,false,true)
		
	if Ignite and JinxMenu.Misc.AutoIgnite:Value() then
          if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
        end
		
        if SpellWREADY and GoS:ValidTarget(enemy, GetCastRange(myHero,_W)) and JinxMenu.Killsteal.W:Value() and WPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy)  < GoS:CalcDamage(myHero, enemy, 50*GetCastLevel(myHero,_Q) - 40 + 1.4*GetBaseDamage(myHero)) then  
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	elseif SpellRREADY and GoS:ValidTarget(enemy, 4000) and GoS:GetDistance(myHero, enemy) > 400 and JinxMenu.Killsteal.R:Value() and RPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, (GetMaxHP(enemy)-GetCurrentHP(enemy))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(enemy)/1700))) then 
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
    end
end

function Autolvl()     
if JinxMenu.Misc.Autolvl:Value() then 

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
        LevelSpell(_W)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_Q)
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
end

function Drawings()
if JinxMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if JinxMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end

function Checks()
SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY
end 
