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
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(GetMyHero()) and IsReady(_E) then
      if CHANELLING_SPELLS[spell.name] then
      	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,0,1550,250,1000,60,true,true)
        if GoS:IsInDistance(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() and EPred.HitChance == 1 then 
        CastSkillShot(_E, GetOrigin(unit).x, GetOrigin(unit).y, GetOrigin(unit).z)
        end
      end
    end
  end
end)

UltOn = false

OnDraw(function(myHero)
if AhriMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos(),880,1,0,0xff00ff00) end
if AhriMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos(),700,1,0,0xff00ff00) end
if AhriMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos(),975,1,0,0xff00ff00) end
if AhriMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos(),550,1,0,0xff00ff00) end
end)

OnTick(function(myHero)
    if IOW:Mode() == "Combo" then
        
	local target = GetCurrentTarget()

        if IsReady(_E) and GoS:ValidTarget(target, 1050) then
        Cast(_E,target)
        end
	
        if AhriMenu.Combo.RMode:Value() == 1 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target, 900) then
            local BestPos = Vector(target) - (Vector(target) - Vector(myHero)):perpendicular():normalized() * 350
	    if UltOn and BestPos then
            CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    elseif IsReady(_R) and BestPos and 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero)+24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero)+25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero)+30+40*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) > GetCurrentHP(target) then
	    CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    end
          end
	end

        if AhriMenu.Combo.RMode:Value() == 2 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target, 900) then
            local AfterTumblePos = GetOrigin(myHero) + (Vector(mousePos()) - GetOrigin(myHero)):normalized() * 550
            local DistanceAfterTumble = GoS:GetDistance(AfterTumblePos, target)
   	    if UltOn then
              if DistanceAfterTumble < 550 then
	      CastSkillShot(_R,mousePos().x,mousePos().y,mousePos().z)
              elseif IsReady(_R) and 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero)+24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero)+25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero)+30+40*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) > GetCurrentHP(target) then
	      CastSkillShot(_R,mousePos().x,mousePos().y,mousePos().z) 
              end
            end
          end
	end
			
	if IsReady(_W) and GoS:ValidTarget(target, 700) and AhriMenu.Combo.W:Value() then
	CastSpell(_W)
	end
		
	if IsReady(_Q) and GoS:ValidTarget(target, 880) and AhriMenu.Combo.Q:Value() then
        Cast(_Q,target)
        end
					
    end
	
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Harass.Mana:Value() then
	
        local target = GetCurrentTarget()

        if IsReady(_E) and GoS:ValidTarget(target, 1000) and AhriMenu.Harass.E:Value() then
        Cast(_E,target)
        end
				
        if IsReady(_W) and GoS:ValidTarget(target, 700) and AhriMenu.Harass.W:Value() then
	CastSpell(_W)
	end
		
	if IsReady(_Q) and GoS:ValidTarget(target, 880) and AhriMenu.Harass.Q:Value() then
        Cast(_Q,target)
        end
		
    end
	
for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
		if Ignite and AhriMenu.Misc.Autoignite:Value() then
                  if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
                
		if IsReady(_W) and GoS:ValidTarget(enemy, 700) and AhriMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero) + Ludens()) then
		CastSpell(_W)
		elseif IsReady(_Q) and GoS:ValidTarget(enemy, 880) and AhriMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero) + Ludens()) then 
		Cast(_Q,enemy)
		elseif IsReady(_E) and GoS:ValidTarget(enemy, 975) and AhriMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero) + Ludens()) then
		Cast(_E,enemy)
	        end
	
end

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
                
                if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.LaneClear.Mana:Value() then
		  if IsReady(_Q) and AhriMenu.LaneClear.Q:Value() then
                    local BestPos, BestHit = GetLineFarmPosition(880, 50)
                    if BestPos and BestHit > 0 then 
                    CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
                    end
	          end

                  if IsReady(_W) and AhriMenu.LaneClear.W:Value() then
                    if GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero) + Ludens()) then
                    CastSpell(_W)
                    end
                  end

                  if IsReady(_E) and AhriMenu.LaneClear.E:Value() then
                    if GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero) + Ludens()) then
                    CastSkillShot(_E, GetOrigin(minion).x, GetOrigin(minion).y, GetOrigin(minion).z)
                    end
                  end
	        end

	        if IOW:Mode() == "LastHit" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Lasthit.Mana:Value() then
	          if IsReady(_Q) and GoS:ValidTarget(minion, 880) and AhriMenu.Lasthit.Q:Value() and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero) + Ludens()) then
                  CastSkillShot(_Q, GetOrigin(minion).x, GetOrigin(minion).y, GetOrigin(minion).z)
       	          end
                end
	        
end

if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.JungleClear.Mana:Value() then
        for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		local mobPos = GetOrigin(mob)
		
		if IsReady(_Q) and AhriMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 880) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if IsReady(_W) and AhriMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 700) then
		CastSpell(_W)
		end
		
	        if IsReady(_E) and AhriMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 975) then
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
 
OnUpdateBuff(function(Object,buff)
  if buff.Name == "ahritumble" then 
  UltOn = true
  end
end)

OnRemoveBuff(function(Object,buff)
  if buff.Name == "ahritumble" then 
  UltOn = false
  end
end)

GoS:AddGapcloseEvent(_E, 666, false)
