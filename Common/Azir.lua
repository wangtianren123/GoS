if GetObjectName(myHero) ~= "Azir" then return end

require('Deftlib')

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
        if GoS:IsInDistance(unit, 450) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
        Cast(_R,unit)
        end
      end
    end
  end
end)

OnDraw(function(myHero)
if AzirMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos(),950,1,0,0xff00ff00) end
if AzirMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos(),450,1,0,0xff00ff00) end
if AzirMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos(),1300,1,0,0xff00ff00) end
if AzirMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos(),950,1,0,0xff00ff00) end
end)

local AzirSoldiers = {}

OnTick(function(myHero)
	
       if IOW:Mode() == "Combo" then
	
	    local target = GetCurrentTarget()
		
	    if IsReady(_W) and GoS:ValidTarget(target,850) and AzirMenu.Combo.W:Value() then
	    Cast(_W,target)
	    end
		
	      for _,Soldier in pairs(AzirSoldiers) do
	         	
	        local QPred = GetPredictionForPlayer(GetOrigin(Soldier),target,GetMoveSpeed(target),1600,0,950,80,false,true)
		   
	        if GoS:ValidTarget(target, 1500) then
	        SoldierRange = GoS:GetDistance(Soldier, target)
		end
		
		if IsReady(_E) and GoS:ValidTarget(target, 1300) and GoS:EnemiesAround(GetOrigin(target), 666) < 2 and AzirMenu.Combo.E:Value() then 
		  local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(Soldier), GetOrigin(target))
                   if isOnSegment and GoS:GetDistance(target, pointSegment) < 100 then
		   CastTargetSpell(Soldier, _E)
		   end
	         end
		   
		   if IsReady(_Q) and SoldierRange > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and AzirMenu.Combo.Q:Value() then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 550 and SoldierRange < 400 and AzirMenu.Combo.AA:Value() then
		   AttackUnit(target)
	           end
	   
	         end
	
        end
	
	if IOW:Mode() == "Harass"  then
	local target = GetCurrentTarget()
		
		if IsReady(_W) and GoS:ValidTarget(target,850) and AzirMenu.Harass.W:Value() then
		Cast(_W,target)
		end	
		
	          for _,Soldier in pairs(AzirSoldiers) do
	          	
		   local QPred = GetPredictionForPlayer(GetOrigin(Soldier),target,GetMoveSpeed(target),1600,0,950,80,false,true)
				
	           if GoS:ValidTarget(target, 1500) then
		   SoldierRange = GoS:GetDistance(Soldier, target)
		   end
		   
		   if IsReady(_Q) and GoS:GetDistance(target) > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and AzirMenu.Harass.Q:Value()then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if GoS:ValidTarget(target, 1500) and GoS:GetDistance(myHero, target) > 550 and SoldierRange < 400 and AzirMenu.Harass.AA:Value() then
		   AttackUnit(target)
	           end
	   
	          end
	
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do

               for _,Soldier in pairs(AzirSoldiers) do
		   local QPred = GetPredictionForPlayer(GetOrigin(Soldier),enemy,GetMoveSpeed(enemy),1600,0,950,80,false,true)
		   if IsReady(_Q) and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 950) and AzirMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 20*GetCastLevel(myHero,_Q)+45+.5*GetBonusAP(myHero) + Ludens()) then 
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		 end

               if IsReady(_E) and GoS:ValidTarget(enemy, 1300) and GoS:EnemiesAround(GetOrigin(enemy), 666) < 2 and AzirMenu.Killsteal.E:Value() then 
		  local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(Soldier), GetOrigin(enemy))
                   if isOnSegment and GoS:GetDistance(enemy, pointSegment) < 100 then
		   CastTargetSpell(Soldier, _E)
		   end
		 end
              end

		if Ignite and AzirMenu.Misc.AutoIgnite:Value() then
                  if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
	        
	end
	
if AzirMenu.Combo.Flee:Value() then
	
	MoveToXYZ(mousePos())
        if IsReady(_W) and table.getn(AzirSoldiers) < 1 then 
        local movePos = myHeroPos() + (Vector(mousePos()) - myHeroPos()):normalized()*450
	CastSkillShot(_W, movePos.x, movePos.y, movePos.z) 
	end
	
	for _,Soldier in pairs(AzirSoldiers) do
	  local movePos = myHeroPos() + (Vector(mousePos()) - myHeroPos()):normalized()*950
	  if movePos then
          CastTargetSpell(Soldier, _E)
          GoS:DelayAction(function() CastSkillShot(_Q, movePos.x, movePos.y, movePos.z) end, 150)
          end
        end
			
end
	
if AzirMenu.Combo.Insec:Value() then
	
    local enemy = GoS:ClosestEnemy(mousePos())
    if not enemy or GoS:GetDistance(enemy) > 750 then
    MoveToXYZ(mousePos())
    return 
    end

    if table.getn(AzirSoldiers) < 1 and IsReady(_W) then
    CastSkillShot(_W, myHeroPos().x, myHeroPos().y, myHeroPos().z)
    end
     
      for _,Soldier in pairs(AzirSoldiers) do
      	
        local movePos = myHeroPos() + (Vector(enemy) - myHeroPos()):normalized() * 950
        if movePos then
        CastSkillShot(_Q, movePos.x, movePos.y, movePos.z)
        GoS:DelayAction(function() CastTargetSpell(Soldier, _E) end, 250)
          if GoS:GetDistance(myHero, enemy) < 250 then
          CastSkillShot(_R, GetOrigin(enemy).x, GetOrigin(enemy).y, GetOrigin(enemy).z)
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
