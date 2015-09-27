if GetObjectName(myHero) ~= "Viktor" then return end

local ViktorMenu = Menu("Viktor", "Viktor")
ViktorMenu:SubMenu("Combo", "Combo")
ViktorMenu.Combo:Boolean("Q", "Use Q", true)
ViktorMenu.Combo:Boolean("W", "Use W", true)
ViktorMenu.Combo:Boolean("E", "Use E", true)
ViktorMenu.Combo:Boolean("R", "Use R", true)

ViktorMenu:SubMenu("Harass", "Harass")
ViktorMenu.Harass:Boolean("Q", "Use Q", true)
ViktorMenu.Harass:Boolean("W", "Use W", true)
ViktorMenu.Harass:Boolean("E", "Use E", true)
ViktorMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

ViktorMenu:SubMenu("Killsteal", "Killsteal")
ViktorMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
ViktorMenu.Killsteal:Boolean("E", "Killsteal with E", true)
ViktorMenu.Killsteal:Boolean("R", "Killsteal with R", true)

ViktorMenu:SubMenu("Misc", "Misc")
ViktorMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
ViktorMenu.Misc:Boolean("Autolvl", "Auto level", true)
ViktorMenu.Misc:List("Autolvltable", "Priority", 1, {"E-Q-W", "Q-E-W"})
ViktorMenu.Misc:Boolean("InterruptW", "Interrupt Spells (W)", true)
ViktorMenu.Misc:Boolean("InterruptR", "Interrupt Spells (R)", false)

ViktorMenu:SubMenu("Drawings", "Drawings")
ViktorMenu.Drawings:Boolean("Q", "Draw Q Range", true)
ViktorMenu.Drawings:Boolean("W", "Draw W Range", true)
ViktorMenu.Drawings:Boolean("E", "Draw E Range", true)
ViktorMenu.Drawings:Boolean("R", "Draw R Range", true)

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["FiddleSticks"]                = {_R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
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
 
function addInterrupterCallback( callback0 )
callback = callback0
end

OnLoop(function(myHero)

    if IOW:Mode() == "Combo" then
	
                local target = GetCurrentTarget()
		local targetPos = GetOrigin(target)     
	        local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,700,300,false,true)
	        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,1225,80,false,true)
                local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,250,700,450,false,true)   				
										
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1225) and ViktorMenu.Combo.E:Value() then
                local StartPos = Vector(myHero) - 525 * (Vector(myHero) - Vector(target)):normalized()
                  if EPred.HitChance == 1 then
                  CastSkillShot3(_E,StartPos,EPred.PredPos)
		  end
		end
					
		if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 700) and ViktorMenu.Combo.Q:Value() then
	        CastTargetSpell(target, _Q)
		end
				 
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 700) and WPred.HitChance == 1 and ViktorMenu.Combo.W:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) < 70 then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	        end
	
	        if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 700) then
                local damage = GoS:CalcDamage(myHero, target, 0, 25 + 200*GetCastLevel(myHero,_R) + 1.25*GetBonusAP(myHero))
                  if RPred.HitChance == 1 and damage > GetCurrentHP(target)+GetMagicShield(target)+GetDmgShield(target) then
		  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                  end
                elseif GetCastName(myHero, _R) == "viktorchaosstormguide" and GoS:ValidTarget(target, 1000) and ViktorMenu.Combo.R:Value() then
                CastSkillShot(_R, targetPos.x,targetPos.y, targetPos.z)
                end
        
	end
					        
        if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= ViktorMenu.Harass.Mana:Value() then
	            
		local target = GetCurrentTarget()
		local targetPos = GetOrigin(target)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,700,300,false,true)
		local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,1225,80,false,true)
					                 
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1225) and ViktorMenu.Harass.E:Value() then
		local StartPos = Vector(myHero) - 525 * (Vector(myHero) - Vector(target)):normalized()
                  if EPred.HitChance == 1 then
                  CastSkillShot3(_E,StartPos,EPred.PredPos)
		  end
		end
					
		if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 700) and ViktorMenu.Harass.Q:Value() then
		CastTargetSpell(target, _Q)
		end
					  
		if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(target, 700) and ViktorMenu.Harass.W:Value() and 100*GetCurrentHP(target)/GetMaxHP(myHero) < 70 then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
					 
		if GetCastName(myHero, _R) == "viktorchaosstormguide" and GoS:ValidTarget(target, 1000) then
                CastSkillShot(_R, targetPos.x,targetPos.y, targetPos.z)
                end
				
	end

    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	 
        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1200,0,1225,80,false,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,250,700,450,false,true)
        
	if Ignite and ViktorMenu.Misc.AutoIgnite:Value() then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
        end
				
	if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(enemy, 700) and ViktorMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 20*GetCastLevel(myHero,_Q) + 20 + 0.2*GetBonusAP(myHero)) then
        CastTargetSpell(enemy, _Q)
        elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy,1225) and ViktorMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 45*GetCastLevel(myHero,_E) + 25 + 0.7*GetBonusAP(myHero)) then
	local StartPos = Vector(myHero) - 525 * (Vector(myHero) - Vector(enemy)):normalized()
          if EPred.HitChance == 1 then
          CastSkillShot3(_E,StartPos,EPred.PredPos)
	  end
	elseif CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(enemy, 700) and ViktorMenu.Killsteal.R:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 100*GetCastLevel(myHero,_R) + 50 + 0.55*GetBonusAP(myHero)) then  
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)    
        end
		
    end

if ViktorMenu.Misc.Autolvl:Value() then  
   if ViktorMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
   elseif ViktorMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_E, _Q, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

if ViktorMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,0,1,0xff00ff00) end
if ViktorMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,0,1,0xff00ff00) end
if ViktorMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1225,0,1,0xff00ff00) end
if ViktorMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,0,1,0xff00ff00) end	

end)

addInterrupterCallback(function(target, spellType)
  local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,700,300,false,true)
  local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,250,700,450,false,true) 
  if GoS:IsInDistance(target, 700) and CanUseSpell(myHero,_W) == READY and WPred.HitChance == 1 and spellType == CHANELLING_SPELLS and ViktorMenu.Misc.InterruptW:Value() then
  CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
  elseif GoS:IsInDistance(target, 700) and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 and spellType == CHANELLING_SPELLS and ViktorMenu.Misc.InterruptR:Value() then
  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

GoS:AddGapcloseEvent(_W, 100, false) -- hi Copy-Pasters ^^
