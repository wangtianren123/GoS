if GetObjectName(myHero) ~= "Ahri" then return end

require('Deftlib')

local AhriMenu = Menu("Ahri", "Ahri")
AhriMenu:SubMenu("Combo", "Combo")
AhriMenu.Combo:Boolean("Q", "Use Q", true)
AhriMenu.Combo:Boolean("W", "Use W", true)
AhriMenu.Combo:Boolean("E", "Use E", true)
AhriMenu.Combo:Boolean("R", "Use R", true)
AhriMenu.Combo:List("RMode", "R Mode", 1, {"Logic", "to mouse"})

AhriMenu:SubMenu("Harass", "Harass")
AhriMenu.Harass:Boolean("Q", "Use Q", true)
AhriMenu.Harass:Boolean("W", "Use W", true)
AhriMenu.Harass:Boolean("E", "Use E", true)
AhriMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:SubMenu("Killsteal", "Killsteal")
AhriMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AhriMenu.Killsteal:Boolean("W", "Killsteal with W", true)
AhriMenu.Killsteal:Boolean("E", "Killsteal with E", true)

AhriMenu:SubMenu("Misc", "Misc")
AhriMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
AhriMenu.Misc:Boolean("Autolvl", "Auto level", true)
AhriMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E", "E-Q-W"})

AhriMenu:SubMenu("Lasthit", "Lasthit")
AhriMenu.Lasthit:Boolean("Q", "Use Q", true)
AhriMenu.Lasthit:Slider("Mana", "if Mana % >", 50, 0, 80, 1)

AhriMenu:SubMenu("LaneClear", "LaneClear")
AhriMenu.LaneClear:Boolean("Q", "Use Q", true)
AhriMenu.LaneClear:Boolean("W", "Use W", false)
AhriMenu.LaneClear:Boolean("E", "Use E", false)
AhriMenu.LaneClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:SubMenu("JungleClear", "JungleClear")
AhriMenu.JungleClear:Boolean("Q", "Use Q", true)
AhriMenu.JungleClear:Boolean("W", "Use W", true)
AhriMenu.JungleClear:Boolean("E", "Use E", true)
AhriMenu.JungleClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:SubMenu("Drawings", "Drawings")
AhriMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AhriMenu.Drawings:Boolean("W", "Draw W Range", true)
AhriMenu.Drawings:Boolean("E", "Draw E Range", true)
AhriMenu.Drawings:Boolean("R", "Draw R Range", true)
AhriMenu.Drawings:Boolean("Text", "Draw Killable Text", true)

local InterruptMenu = Menu("Interrupt (E)", "Interrupt")

GoS:DelayAction(function()

  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GoS:GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
		
end, 1)

OnProcessSpell(function(unit, spell)
  if unit and spell and spell.name then
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(GetMyHero()) and CanUseSpell(myHero, _E) == READY then
      if CHANELLING_SPELLS[spell.name] then
      	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1550,250,1000,60,true,true)
        if GoS:IsInDistance(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() and EPred.HitChance == 1 then 
        CastSkillShot(_E, GetOrigin(unit).x, GetOrigin(unit).y, GetOrigin(unit).z)
        end
      end
    end
  end
end)

UltOn = false

OnTick(function(myHero)
    if IOW:Mode() == "Combo" then
        
	local target = GetCurrentTarget()

        if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1050) then
        Cast(_E,target)
        end
	
        if AhriMenu.Combo.RMode:Value() == 1 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target, 550) then
            local BestPos = Vector(target) - (Vector(target) - Vector(myHero)):perpendicular():normalized() * 350
	    if UltOn then
            CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    elseif CanUseSpell(myHero, _R) == READY and 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero)+24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero)+25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero)+30+40*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) > GetCurrentHP(target) then
	    CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    end
          end
	end

        if AhriMenu.Combo.RMode:Value() == 2 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target, 900) then
            local AfterTumblePos = GetOrigin(myHero) + (Vector(mousePos) - GetOrigin(myHero)):normalized() * 550
            local DistanceAfterTumble = GoS:GetDistance(AfterTumblePos, target)
   	    if UltOn then
              if DistanceAfterTumble < 550 then
	      CastSkillShot(_R,mousePos().x,mousePos().y,mousePos().z)
              elseif CanUseSpell(myHero, _R) == READY and 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero)+24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero)+25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero)+30+40*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) > GetCurrentHP(target) then
	      CastSkillShot(_R,mousePos().x,mousePos().y,mousePos().z) 
              end
            end
          end
	end
			
	if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 700) and AhriMenu.Combo.W:Value() then
	CastSpell(_W)
	end
		
	if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 880) and AhriMenu.Combo.Q:Value() then
        Cast(_Q,target)
        end
					
    end
	
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Harass.Mana:Value() then
	
        local target = GetCurrentTarget()

        if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and AhriMenu.Harass.E:Value() then
        Cast(_E,target)
        end
				
        if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 700) and AhriMenu.Harass.W:Value() then
	CastSpell(_W)
	end
		
	if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 880) and AhriMenu.Harass.Q:Value() then
        Cast(_Q,target)
        end
		
    end
	
for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	        end
	
		if Ignite and AhriMenu.Misc.Autoignite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
                
		if CanUseSpell(myHero, _W) and GoS:ValidTarget(enemy, 700) and AhriMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero) + ExtraDmg) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(enemy, 880) and AhriMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero) + ExtraDmg) then 
		Cast(_Q,enemy)
		elseif CanUseSpell(myHero, _E) and GoS:ValidTarget(enemy, 975) and AhriMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero) + ExtraDmg) then
		Cast(_E,enemy)
	        end
	
end

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do

		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
                
                if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.LaneClear.Mana:Value() then
		  if CanUseSpell(myHero,_Q) == READY and AhriMenu.LaneClear.Q:Value() then
                    BestPos, BestHit = GetLineFarmPosition(880, 50)
                    if BestPos and BestHit > 0 then 
                    CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
                    end
	          end

                  if CanUseSpell(myHero,_W) == READY and AhriMenu.LaneClear.W:Value() then
                    if GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero) + ExtraDmg) then
                    CastSpell(_W)
                    end
                  end

                  if CanUseSpell(myHero,_E) == READY and AhriMenu.LaneClear.E:Value() then
                    if GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero) + ExtraDmg) then
                    CastSkillShot(_E, GetOrigin(minion).x, GetOrigin(minion).y, GetOrigin(minion).z)
                    end
                  end
	        end

	        if IOW:Mode() == "LastHit" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Lasthit.Mana:Value() then
	          if CanUseSpell(myHero,_Q) == READY and GoS:ValidTarget(minion, 880) and AhriMenu.Lasthit.Q:Value() and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero) + ExtraDmg) then
                  CastSkillShot(_Q, GetOrigin(minion).x, GetOrigin(minion).y, GetOrigin(minion).z)
       	          end
                end
	        
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
        if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.JungleClear.Mana:Value() then
		local mobPos = GetOrigin(mob)
		
		if CanUseSpell(myHero, _Q) == READY and AhriMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 880) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and AhriMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 700) then
		CastSpell(_W)
		end
		
	        if CanUseSpell(myHero, _E) == READY and AhriMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 975) then
		CastSkillShot(_E,mobPos.x, mobPos.y, mobPos.z)
		end
        end
end
	
if AhriMenu.Misc.Autolvl:Value() then  
  if AhriMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _E, _W, _Q, _Q , _R, _Q , _E, _Q , _E, _R, _E, _E, _W, _W, _R, _W, _W}
  elseif AhriMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
  elseif AhriMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _E, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
  end
LevelSpell(leveltable[GetLevel(myHero)])
end

end)

OnDraw(function(myHero)

if AhriMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,880,1,128,0xff00ff00) end
if AhriMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,550,1,128,0xff00ff00) end
if AhriMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,975,1,128,0xff00ff00) end
if AhriMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,550,1,128,0xff00ff00) end
end)
 
OnUpdateBuff(function(Object,buff)
  if GetTeam(Object) = GetTeam(myHero) and buff.Name == "ahritumble" then 
  UltOn = true
  end
end)

OnRemoveBuff(function(Object,buff)
  if GetTeam(Object) = GetTeam(myHero) and buff.Name == "ahritumble" then 
  UltOn = false
  end
end)

GoS:AddGapcloseEvent(_E, 1000, false)
