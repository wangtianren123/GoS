if GetObjectName(myHero) ~= "Ahri" then return end

require('Deftlib')

local AhriMenu = MenuConfig("Ahri", "Ahri")
AhriMenu:Menu("Combo", "Combo")
AhriMenu.Combo:Boolean("Q", "Use Q", true)
AhriMenu.Combo:Boolean("W", "Use W", true)
AhriMenu.Combo:Boolean("E", "Use E", true)
AhriMenu.Combo:Boolean("R", "Use R", true)
AhriMenu.Combo:DropDown("RMode", "R Mode", 1, {"Logic", "to mouse"})

AhriMenu:Menu("Harass", "Harass")
AhriMenu.Harass:Boolean("Q", "Use Q", true)
AhriMenu.Harass:Boolean("W", "Use W", true)
AhriMenu.Harass:Boolean("E", "Use E", true)
AhriMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:Menu("Killsteal", "Killsteal")
AhriMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AhriMenu.Killsteal:Boolean("W", "Killsteal with W", true)
AhriMenu.Killsteal:Boolean("E", "Killsteal with E", true)

AhriMenu:Menu("Misc", "Misc")
if Ignite ~= nil then AhriMenu.Misc:Boolean("Autoignite", "Auto Ignite", true) end
AhriMenu.Misc:Boolean("Autolvl", "Auto level", true)
AhriMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E", "E-Q-W"})

AhriMenu:Menu("Lasthit", "Lasthit")
AhriMenu.Lasthit:Boolean("Q", "Use Q", true)
AhriMenu.Lasthit:Slider("Mana", "if Mana % >", 50, 0, 80, 1)

AhriMenu:Menu("LaneClear", "LaneClear")
AhriMenu.LaneClear:Boolean("Q", "Use Q", true)
AhriMenu.LaneClear:Boolean("W", "Use W", false)
AhriMenu.LaneClear:Boolean("E", "Use E", false)
AhriMenu.LaneClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:Menu("JungleClear", "JungleClear")
AhriMenu.JungleClear:Boolean("Q", "Use Q", true)
AhriMenu.JungleClear:Boolean("W", "Use W", true)
AhriMenu.JungleClear:Boolean("E", "Use E", true)
AhriMenu.JungleClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:Menu("Drawings", "Drawings")
AhriMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AhriMenu.Drawings:Boolean("W", "Draw W Range", true)
AhriMenu.Drawings:Boolean("E", "Draw E Range", true)
AhriMenu.Drawings:Boolean("R", "Draw R Range", true)
AhriMenu.Drawings:ColorPick("color", "Color Picker", {255,255,255,255})

local InterruptMenu = MenuConfig("Interrupt (E)", "Interrupt")

GoS:DelayAction(function()

  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GoS:GetEnemyHeroes()) do
    	local added = false
        if spell["Name"] == GetObjectName(k) then
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        added = true
        end
        if not added then
        InterruptMenu:Info("bullshit", "No Interruptable Spells Found")
        end
    end
  end
		
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_E) then
      if CHANELLING_SPELLS[spell.name] then
        if GoS:IsInDistance(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
        Cast(_E,unit)
        end
      end
    end
end)

local UltOn = false

OnDraw(function(myHero)
local col = AhriMenu.Drawings.color:Value()
if AhriMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos(),880,1,0,col) end
if AhriMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos(),700,1,0,col) end
if AhriMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos(),975,1,0,col) end
if AhriMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos(),550,1,0,col) end
end)

OnTick(function(myHero)
  
    if IOW:Mode() == "Combo" then
        
        local target = GetCurrentTarget()

        if IsReady(_E) and GoS:ValidTarget(target,975) then
        Cast(_E,target)
        end
	
        if AhriMenu.Combo.RMode:Value() == 1 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target,900) then
            local BestPos = Vector(target) - (Vector(target) - Vector(myHero)):perpendicular():normalized() * 350
	    if UltOn and BestPos then
            CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    elseif IsReady(_R) and BestPos and 25+15*GetCastLevel(myHero,_Q)+.35*GetBonusAP(myHero)+24+40*GetCastLevel(myHero,_W)+.64*GetBonusAP(myHero)+25+35*GetCastLevel(myHero,_E)+.5*GetBonusAP(myHero)+30+40*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) > GetCurrentHP(target) then
	    CastSkillShot(_R, BestPos.x, BestPos.y, BestPos.z)
	    end
          end
	end

        if AhriMenu.Combo.RMode:Value() == 2 and AhriMenu.Combo.R:Value() then
          if GoS:ValidTarget(target,900) then
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
			
	if IsReady(_W) and GoS:ValidTarget(target,700) and AhriMenu.Combo.W:Value() then
	CastSpell(_W)
	end
		
	if IsReady(_Q) and GoS:ValidTarget(target, 880) and AhriMenu.Combo.Q:Value() then
        Cast(_Q,target)
        end
					
    end
	
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Harass.Mana:Value() then
        
        local target = GetCurrentTarget()

        if IsReady(_E) and GoS:ValidTarget(target, 975) and AhriMenu.Harass.E:Value() then
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

for i=1, IOW.mobs.maxObjects do
                local minion = IOW.mobs.objects[i]
                
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

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
        if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.JungleClear.Mana:Value() then
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
GoS:DelayAction(function() LevelSpell(leveltable[GetLevel(myHero)]) end, math.random(1000,3000))
end
end)
 
OnUpdateBuff(function(unit,buff)
  if buff.Name == "ahritumble" then 
  UltOn = true
  end
end)

OnRemoveBuff(function(unit,buff)
  if buff.Name == "ahritumble" then 
  UltOn = false
  end
end)

GoS:AddGapcloseEvent(_E, 666, false)
