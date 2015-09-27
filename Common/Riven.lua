if GetObjectName(myHero) ~= "Riven" then return end

RivenMenu = Menu("Riven", "Riven")
RivenMenu:SubMenu("Combo", "Combo")
RivenMenu.Combo:Boolean("Q", "Use Q", true)
RivenMenu.Combo:Boolean("W", "Use W", true)
RivenMenu.Combo:Boolean("E", "Use E", true)
RivenMenu.Combo:Boolean("R", "Use R", true)
RivenMenu.Combo:Boolean("Items", "Cast Items", true)
RivenMenu.Combo:Boolean("QSS", "Use QSS", true)
RivenMenu.Combo:Slider("QSSHP", "if HP % <", 75, 0, 100, 1)

RivenMenu:SubMenu("Harass", "Harass")
RivenMenu.Harass:Boolean("Q", "Use Q", true)
RivenMenu.Harass:Boolean("W", "Use W", true)
RivenMenu.Harass:Boolean("E", "Use E", true)

RivenMenu:SubMenu("Killsteal", "Killsteal")
RivenMenu.Killsteal:Boolean("W", "Killsteal with W", true)
RivenMenu.Killsteal:Boolean("R", "Killsteal with R", true)

RivenMenu:SubMenu("Misc", "Misc")
RivenMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
RivenMenu.Misc:Boolean("Autolvl", "Auto level", true)
RivenMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E", "W-E-Q"})
RivenMenu.Misc:Boolean("AutoW", "Auto W", true)
RivenMenu.Misc:Slider("catchable", "if Can Stun X Enemies", 2, 0, 5, 1)
RivenMenu.Misc:Key("Flee", "Flee", string.byte("G"))

--[[RivenMenu:SubMenu("JungleClear", "JungleClear")
RivenMenu.JungleClear:Boolean("Q", "Use Q", true)
RivenMenu.JungleClear:Boolean("W", "Use W", true)
RivenMenu.JungleClear:Boolean("E", "Use E", true)]]

RivenMenu:SubMenu("Drawings", "Drawings")
RivenMenu.Drawings:Boolean("Q", "Draw Q Range", true)
RivenMenu.Drawings:Boolean("W", "Draw W Range", true)
RivenMenu.Drawings:Boolean("E", "Draw E Range", true)
RivenMenu.Drawings:Boolean("R", "Draw R Range", true)

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["MasterYi"]                    = {_W},
    ["FiddleSticks"]                = {_W, _R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_R},
}

local callback = nil
 
OnProcessSpell(function(unit, spell)    
    if not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == GetTeam(GetMyHero()) then return end
    local unitChanellingSpells = CHANELLING_SPELLS[GetObjectName(unit)]
 
        if unitChanellingSpells then
            for _, spellSlot in pairs(unitChanellingSpells) do
                if spell.name == GetCastName(unit, spellSlot) then callback(unit, CHANELLING_SPELLS) end
            end
	end
end)


spellData =
        {
        [-1] = {dmg = function () return 5+math.max(5*math.floor((GetLevel(myHero)+2)/3)+10,10*math.floor((GetLevel(myHero)+2/3)-15)*(GetBaseDamage(myHero)+GetBonusDmg(myHero))/100) end, }, -- only 1 buff not 3
        [_Q] = {dmg = function () return 20*GetCastLevel(myHero, _Q)-10+(.05*GetCastLevel(myHero, _Q)+.35)*(GetBaseDamage(myHero)+GetBonusDmg(myHero)) end }, --only 1 strike end,
        [_W] = {dmg = function () return 30*GetCastLevel(myHero, _W)+20+GetBonusDmg(myHero) end, },
        [_R] = {dmg = function () return math.min((40*GetCastLevel(myHero, _R)+40+.6*GetBonusDmg(myHero))*(1+(100-25)/100*8/3),120*GetCastLevel(myHero, _R)+120+1.8*GetBonusDmg(myHero)) end, },
        }
	
OnLoop(function(myHero)
  if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	
	if GetItemSlot(myHero,3140) > 0 and RivenMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < RivenMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and RivenMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < RivenMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
	
	if CanUseSpell(myHero, _E) and RivenMenu.Combo.E:Value() and GoS:ValidTarget(target, 500) and GoS:GetDistance(target) < 250 then
	CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
	end
	
	if CanUseSpell(myHero,_W) == READY and RivenMenu.Combo.W:Value() and GoS:ValidTarget(target, 125) then	
        CastSpell(_W)
	end
	
	if 100*GetCurrentHP(target)/GetMaxHP(target) <= 50 and GoS:ValidTarget(target, 900) and RivenMenu.Combo.R:Value() and GetCastName(myHero, _R) == "RivenFengShuiEngine" then 
	CastSpell(_R)
        end
	
	if RivenMenu.Combo.Items:Value() then
	Items={3074, 3077, 3142, 3143, 3144, 3153,3748}
	    for _,Item in pairs(Items) do
	      if GetItemSlot(myHero,Item) > 0 and GoS:ValidTarget(target, 550) then
	      CastTargetSpell(target, GetItemSlot(myHero,Item))
	      end
	    end
	end
	
  end

  if IOW:Mode() == "Harass" then
	
	local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	
	if CanUseSpell(myHero, _E) and RivenMenu.Combo.E:Value() and GoS:ValidTarget(target, 500) and GoS:GetDistance(target) < 250 then
	CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
	end
	
	if CanUseSpell(myHero,_W) == READY and RivenMenu.Combo.W:Value() and GoS:ValidTarget(target, 125) then	
        CastSpell(_W)
	end
	
  end 
  
  if RivenMenu.Misc.Flee:Value() then
        local mousePos = GetMousePos()
        if CanUseSpell(myHero, _E) == READY then
	CastSkillShot(_E, mousePos.x, mousePos.y, mousePos.z)
	elseif CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _Q) == READY then
	CastSkillShot(_Q, mousePos.x, mousePos.y, mousePos.z)
	end
  end
  
  if RivenMenu.Misc.AutoW:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 125) >= RivenMenu.Misc.catchable:Value() then
  CastSpell(_W)
  end
  

	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1600,500,1100,200,false,true)
		
		if Ignite and RivenMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end

		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(enemy, 125) and RivenMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, spellData[_W].dmg(), 0) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(enemy, 900) and RivenMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, spellData[_R].dmg(), 0) then
		CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
		end
		
	end

if RivenMenu.Misc.Autolvl:Value() then
   if RivenMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
   elseif RivenMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
   elseif RivenMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _E, _W, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

if RivenMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,260,1,128,0xff00ff00) end
if RivenMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,125,1,128,0xff00ff00) end
if RivenMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,325,1,128,0xff00ff00) end
if RivenMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,900,1,128,0xff00ff00) end

end)	

OnProcessSpell(function(unit, spell)
    if unit and spell and spell.name then
      if unit == myHero then
        if spell.name:lower():find("attack") then 
		        GoS:DelayAction(function() 
                                if IOW:Mode() == "Combo" and RivenMenu.Combo.R:Value() then
							
							    local target = GetCurrentTarget()
							    local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,500,1100,200,false,true)
							 
				                            if CanUseSpell(myHero, _R) == READY and GetCastName(myHero, _R) ~= "RivenFengShuiEngine" and GoS:ValidTarget(target, 900) and spellData[R].dmg()+SpellData[Q].dmg()+spellData[-1].dmg()+GoS:GetDmg(myHero, target) > GetCurrentHP(target)+GetDmgShield(target) then
							    CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
							    end
								
                                end
                        end, GetWindUp(myHero) * 1000)
		end	

		if spell.name:lower():find("rivenmartyr") then
		                GoS:DelayAction(function() 
                                        if IOW:Mode() == "Combo" and RivenMenu.Combo.Q:Value() then
							
							    local target = GetCurrentTarget()
							    local targetPos = GetOrigin(target)
								
							    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							    CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							    end
						    
					end
							
					if IOW:Mode() == "Harass" and RivenMenu.Harass.Q:Value() then
							
							    local target = GetCurrentTarget()
							    local targetPos = GetOrigin(target)
								
							    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							    CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
					                     end
						   
					end
				end, spell.windUpTime * 1000 + GetLatency() / 2000)
		end
		
		if spell.name:lower():find("rivenfengshuiengine") then
		                GoS:DelayAction(function() 
                               if IOW:Mode() == "Combo" and RivenMenu.Combo.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
				end
							
				if IOW:Mode() == "Harass" and RivenMenu.Harass.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
				 end
			end, spell.windUpTime * 1000 + GetLatency() / 2000)
		end
		
		if spell.name:lower():find("rivenizunablade") then
		                GoS:DelayAction(function() 
                                        if IOW:Mode() == "Combo" and RivenMenu.Combo.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
				        end
							
					if IOW:Mode() == "Harass" and RivenMenu.Harass.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
					end
				end, spell.windUpTime * 1000 + GetLatency() / 2000)
		end
		
		if spell.name:lower():find("itemtiamatcleave") then
		                GoS:DelayAction(function() 
                                        if IOW:Mode() == "Combo" and RivenMenu.Combo.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
					end
							
					if IOW:Mode() == "Harass" and RivenMenu.Harass.Q:Value() then
							
							local target = GetCurrentTarget()
							local targetPos = GetOrigin(target)
								
							if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 260) then
							CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z)
							end
						    
				        end
				end, spell.windUpTime * 1000 + GetLatency() / 2000)
		end
		
      end
  end
end)

GoS:AddGapcloseEvent(_W, 125, false) -- hi Copy-Pasters ^^
