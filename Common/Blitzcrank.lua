if GetObjectName(myHero) ~= "Blitzcrank" then return end

local BlitzcrankMenu = Menu("Blitzcrank", "Blitzcrank")
BlitzcrankMenu:SubMenu("Combo", "Combo")
BlitzcrankMenu.Combo:Boolean("Q", "Use Q", true)
BlitzcrankMenu.Combo:Boolean("W", "Use W", true)
BlitzcrankMenu.Combo:Boolean("E", "Use E", true)
BlitzcrankMenu.Combo:Boolean("R", "Use R", true)

BlitzcrankMenu:SubMenu("Harass", "Harass")
BlitzcrankMenu.Harass:Boolean("Q", "Use Q", true)
BlitzcrankMenu.Harass:Boolean("E", "Use E", true)
BlitzcrankMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

BlitzcrankMenu:SubMenu("Killsteal", "Killsteal")
BlitzcrankMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
BlitzcrankMenu.Killsteal:Boolean("R", "Killsteal with R", true)

BlitzcrankMenu:SubMenu("Misc", "Misc")
BlitzcrankMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
BlitzcrankMenu.Misc:Boolean("Autolvl", "Auto level", true)
BlitzcrankMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E", "W-Q-E"})
BlitzcrankMenu.Misc:Boolean("Interrupt", "Interrupt Dangerous Spells with E", true)

BlitzcrankMenu:SubMenu("Junglesteal", "Baron/Drake Steal")
BlitzcrankMenu.Junglesteal:Boolean("Q", "Use Q", true)
BlitzcrankMenu.Junglesteal:Boolean("R", "Use R", true)

BlitzcrankMenu:SubMenu("Drawings", "Drawings")
BlitzcrankMenu.Drawings:Boolean("Q", "Draw Q Range", true)
BlitzcrankMenu.Drawings:Boolean("R", "Draw R Range", true)

local InterruptMenu = Menu("Interrupt (R)", "Interrupt")
InterruptMenu:SubMenu("SupportedSpells", "Supported Spells")
InterruptMenu.SupportedSpells:Boolean("Q", "Use Q", true)
InterruptMenu.SupportedSpells:Boolean("R", "Use R", true)

CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]                   = {Name = "Caitlyn",      Spellslot = _R},
    ["Drain"]                                              = {Name = "FiddleSticks", Spellslot = _W},
    ["Crowstorm"]                                    = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]                       = {Name = "Galio",        Spellslot = _R},
    ["FallenOne"]                                      = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                                      = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                                         = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]                   = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]              = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                                = {Name = "Nunu",         Spellslot = _R},                        
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]                         = {Name = "Shen",         Spellslot = _R},
    ["UrgotSwap2"]                                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                                           = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]                               = {Name = "Warwick",      Spellslot = _R} 
}


GoS:DelayAction(function()

  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GoS:GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        else
        InterruptMenu:Info("nil", "No enemy to Interrupt found", true)
        end
    end
  end
		
end, 1)

OnProcessSpell(function(unit, spell)
  if unit and spell and spell.name then
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(GetMyHero()) then
      if CHANELLING_SPELLS[spell.name] then
      	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1500,250,975,100,true,true)
        if GoS:IsInDistance(unit, 975) and CanUseSpell(myHero,_Q) == READY and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() and InterruptMenu.SupportedSpells.Q:Value() and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        elseif GoS:IsInDistance(unit, 600) and CanUseSpell(myHero,_R) == READY and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() and InterruptMenu.SupportedSpells.Q:Value() then
        CastSpell(_R)
        end
      end
    end
  end
end)

OnLoop(function(myHero)

    if IOW:Mode() == "Combo" then
	
	        local target = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1800,250,975,80,true,true)
		
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 975) and BlitzcrankMenu.Combo.Q:Value() then
                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	        end
                          
                if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 800) and GoS:GetDistance(myHero, target) > 200 and BlitzcrankMenu.Combo.W:Value() then
                CastSpell(_W)
		end
			
                if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 250) and BlitzcrankMenu.Combo.E:Value() then
                CastSpell(_E)
		end
		              
		if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 600) and BlitzcrankMenu.Combo.R:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) < 80 then
                CastSpell(_R)
	        end
	                      
	end	
	
	if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= BlitzcrankMenu.Harass.Mana:Value() then
	
		local target = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1800,250,975,80,true,true)
		
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 975) and BlitzcrankMenu.Harass.Q:Value() then
                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	        end
		
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 250) and BlitzcrankMenu.Harass.E:Value() then
                CastSpell(_E)
		end
		
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1800,250,975,80,true,true)
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if Ignite and BlitzcrankMenu.Misc.Autoignite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
  	        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 975) and BlitzcrankMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero) + ExtraDmg) then 
                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                elseif CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(enemy, 600) and BlitzcrankMenu.Killsteal.R:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero) + ExtraDmg) then
                CastSpell(_R)
	        end
		
	end

if BlitzcrankMenu.Misc.Autolvl:Value() then    
   if BlitzcrankMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _E, _W, _Q, _Q , _R, _Q , _E, _Q , _E, _R, _E, _E, _W, _W, _R, _W, _W}
   elseif BlitzcrankMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
   elseif BlitzcrankMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _E, _W, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	
	local mobPos = GetOrigin(mob)
        local ExtraDmg = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	end	
	
	if GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron" then
	  if CanUseSpell(myHero, _Q) == READY and BlitzcrankMenu.Junglesteal.Q:Value() and GoS:ValidTarget(mob, 975) and GetCurrentHP(mob) < GoS:CalcDamage(myHero, mob, 0, 55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero) + ExtraDmg) then
	  CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
	  end
		
	  if CanUseSpell(myHero, _R) == READY and BlitzcrankMenu.Junglesteal.R:Value() and GoS:ValidTarget(mob, 600) and GetCurrentHP(mob) < GoS:CalcDamage(myHero, mob, 0, 125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero) + ExtraDmg) then
	  CastSpell(_R)
          end
        end
end

if BlitzcrankMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,975,1,128,0xff00ff00) end
if BlitzcrankMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,600,1,128,0xff00ff00) end

end)
