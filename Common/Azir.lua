if GetObjectName(myHero) ~= "Azir" then return end

local AzirSoldiers = {}

local AzirMenu = Menu("Azir", "Azir")
AzirMenu:SubMenu("Combo", "Combo")
AzirMenu.Combo:Boolean("Q", "Use Q", true)
AzirMenu.Combo:Boolean("W", "Use W", true)
AzirMenu.Combo:Boolean("E", "Use E", true)
--AzirMenu.Combo:Boolean("R", "Use R", true)
AzirMenu.Combo:Boolean("AA", "Use AA", true)
AzirMenu.Combo:Key("Flee", "Flee", string.byte("G"))
AzirMenu.Combo:Key("Insec", "Insec", string.byte("T"))

AzirMenu:SubMenu("Harass", "Harass")
AzirMenu.Harass:Boolean("Q", "Use Q", true)
AzirMenu.Harass:Boolean("W", "Use W", true)
AzirMenu.Harass:Boolean("AA", "Use AA", true)

AzirMenu:SubMenu("Killsteal", "Killsteal")
AzirMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AzirMenu.Killsteal:Boolean("E", "Killsteal with E", true)

AzirMenu:SubMenu("Misc", "Misc")
AzirMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
AzirMenu.Misc:Boolean("Autolvl", "Auto level", true)
AzirMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E"})

AzirMenu:SubMenu("Drawings", "Drawings")
AzirMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AzirMenu.Drawings:Boolean("W", "Draw W Range", true)
AzirMenu.Drawings:Boolean("E", "Draw E Range", true)
AzirMenu.Drawings:Boolean("R", "Draw R Range", true)
 
local InterruptMenu = Menu("Interrupt (R)", "Interrupt")

CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["Drain"]                       = {Name = "FiddleSticks", Spellslot = _W},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["FallenOne"]                   = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R},                        
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["UrgotSwap2"]                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                      = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R} 
}

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
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(GetMyHero()) and CanUseSpell(myHero, _R) == READY then
      if CHANELLING_SPELLS[spell.name] then
      	local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1400,500,950,700,false,true)
        if GoS:IsInDistance(unit, 450) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() and RPred.HitChance == 1 then 
        CastSkillShot(_R,GetOrigin(unit).x,GetOrigin(unit).y,GetOrigin(unit).z)
        end
      end
    end
  end
end)

OnLoop(function(myHero)
	
       if IOW:Mode() == "Combo" then
	
	    local target = GetCurrentTarget()
	    local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),math.huge,0,850,100,false,true)
	    local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1400,500,950,700,false,true)
		
	    if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target,850) and WPred.HitChance == 1 and AzirMenu.Combo.W:Value() then
	    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	    end
		
	    if table.getn(AzirSoldiers) > 0 then 
	      for _,Soldier in pairs(AzirSoldiers) do
	         	
	        local QPred = GetPredictionForPlayer(GetOrigin(Soldier),target,GetMoveSpeed(target),1600,0,950,80,false,true)
		   
	        if GoS:ValidTarget(target, 1500) then
	        SoldierRange = GoS:GetDistance(Soldier, target)
		end
		
		if CanUseSpell(myHero,_E) and GoS:ValidTarget(target, 1300) and table.getn(AzirSoldiers) > 0 and AzirMenu.Combo.E:Value() then 
		  local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(Soldier), GetOrigin(target))
                     if isOnSegment and GoS:GetDistance(target, pointSegment) < 100 then
		     CastTargetSpell(Soldier, _E)
		     end
		   end
		   
		   if CanUseSpell(myHero,_Q) and SoldierRange > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and AzirMenu.Combo.Q:Value() then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 550 and SoldierRange < 400 and AzirMenu.Combo.AA:Value() then
		   AttackUnit(target)
	           end
	   
	         end
	       end
	
        end
	
	if IOW:Mode() == "Harass"  then
	local target = GetCurrentTarget()
	    
		local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),math.huge,0,850,100,false,true)
		
		if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target,850) and WPred.HitChance == 1 and AzirMenu.Harass.W:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end	
		
		if table.getn(AzirSoldiers) > 0 then
	          for _,Soldier in pairs(AzirSoldiers) do
	          	
		   local QPred = GetPredictionForPlayer(GetOrigin(Soldier),target,GetMoveSpeed(target),1600,0,950,80,false,true)
				
	           if GoS:ValidTarget(target, 1500) then
		   SoldierRange = GoS:GetDistance(Soldier, target)
		   end
		   
		   if CanUseSpell(myHero,_Q) and GoS:GetDistance(target) > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and AzirMenu.Harass.Q:Value()then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 550 and SoldierRange < 400 and AzirMenu.Harass.AA:Value() then
		   AttackUnit(target)
	           end
	   
	          end
		end
		
			
		
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end

	     if table.getn(AzirSoldiers) > 0 then 
		for _,Soldier in pairs(AzirSoldiers) do
		   local QPred = GetPredictionForPlayer(GetOrigin(Soldier),enemy,GetMoveSpeed(enemy),1600,0,950,80,false,true)
		   if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 950) and AzirMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 20*GetCastLevel(myHero,_Q)+45+.5*GetBonusAP(myHero) + ExtraDmg) then 
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		end
              end

		if Ignite and AzirMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
	        
	end
	
if AzirMenu.Combo.Flee:Value() then
	
        local HeroPos = GetOrigin(myHero)
	local mousePos = GetMousePos()
	
	MoveToXYZ(GetMousePos())
        if table.getn(AzirSoldiers) < 1 then 
        local movePos = HeroPos + (Vector(mousePos) - HeroPos):normalized()*450
	CastSkillShot(_W, movePos.x, movePos.y, movePos.z) 
	end

	if table.getn(AzirSoldiers) > 0 then	
	for _,Soldier in pairs(AzirSoldiers) do
	  local movePos = HeroPos + (Vector(mousePos) - HeroPos):normalized()*950
	  if movePos then
          CastTargetSpell(Soldier, _E)
          GoS:DelayAction(function() CastSkillShot(_Q, movePos.x, movePos.y, movePos.z) end, 150)
          end
        end
        end
		
		
end
	
if AzirMenu.Combo.Insec:Value() then -- Thanks nebel kappa
	
    local HeroPos = GetOrigin(myHero)
    local mousePos = GetMousePos()
	
    local enemy = GoS:ClosestEnemy(mousePos)
    if not enemy or GoS:GetDistance(enemy) > 750 then
    MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
    return 
    end

    if table.getn(AzirSoldiers) < 1 and CanUseSpell(myHero, _W) == READY then
    CastSkillShot(_W, HeroPos.x, HeroPos.y, HeroPos.z)
    end
     
    if table.getn(AzirSoldiers) > 0 then
      for _,Soldier in pairs(AzirSoldiers) do
      	
        local movePos = HeroPos + (Vector(enemy) - HeroPos):normalized() * 950
        if movePos then
        CastSkillShot(_Q, movePos.x, movePos.y, movePos.z)
        GoS:DelayAction(function() CastTargetSpell(Soldier, _E) end, 250)
          if GoS:ValidTarget(enemy) and GoS:GetDistance(myHero, enemy) < 250 then
          CastSkillShot(_R, GetOrigin(enemy).x, GetOrigin(enemy).y, GetOrigin(enemy).z)
          end
        end
      end
    end

end
	
if AzirMenu.Misc.Autolvl:Value() then  
  if AzirMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_W, _Q, _E, _Q, _Q , _R, _Q , _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
  elseif AzirMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
  end
LevelSpell(leveltable[GetLevel(myHero)])
end

if AzirMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,950,1,128,0xff00ff00) end
if AzirMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,450,1,128,0xff00ff00) end
if AzirMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,1300,1,128,0xff00ff00) end
if AzirMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,950,1,128,0xff00ff00) end

end)

OnCreateObj(function(Object) 
if GetObjectBaseName(Object) == "AzirSoldier" then
table.insert(AzirSoldiers, Object)
end
end)

OnDeleteObj(function(Object) 
if GetObjectBaseName(Object) == "Azir_Base_P_Soldier_Ring.troy" then
table.remove(AzirSoldiers, 1)
end
end)
