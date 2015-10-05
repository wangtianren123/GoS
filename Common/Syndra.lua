if GetObjectName(myHero) ~= "Syndra" then return end

Balls = {}
	
local SyndraMenu = Menu("Syndra", "Syndra")
SyndraMenu:SubMenu("Combo", "Combo")
SyndraMenu.Combo:Boolean("EQ", "Use EQ Snipe", true)
SyndraMenu.Combo:Boolean("Q", "Use Q", true)
SyndraMenu.Combo:Boolean("W", "Use W", true)
SyndraMenu.Combo:Boolean("E", "Use E", true)
SyndraMenu.Combo:Boolean("R", "Use R", true)

SyndraMenu:SubMenu("Harass", "Harass")
SyndraMenu.Harass:Boolean("EQ", "Use EQ Snipe", true)
SyndraMenu.Harass:Boolean("Q", "Use Q", true)
SyndraMenu.Harass:Boolean("W", "Use W", true)
SyndraMenu.Harass:Boolean("E", "Use E", false)
SyndraMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)
SyndraMenu.Harass:Boolean("AutoQ", "Auto Q", true)
SyndraMenu.Harass:Slider("QMana", "Auto Q if Mana >", 70, 0, 80, 1)

SyndraMenu:SubMenu("Killsteal", "Killsteal")
SyndraMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
--SyndraMenu.Killsteal:Boolean("W", "Killsteal with W", true)
--SyndraMenu.Killsteal:Boolean("E", "Killsteal with E", true)

SyndraMenu:SubMenu("Misc", "Misc")
SyndraMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
SyndraMenu.Misc:Boolean("Autolvl", "Auto level", true)
SyndraMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E"})
SyndraMenu.Misc:Boolean("Interrupt", "Interrupt Spells (E)", true)

SyndraMenu:SubMenu("LaneClear", "LaneClear")
SyndraMenu.LaneClear:Boolean("Q", "Use Q", true)
SyndraMenu.LaneClear:Boolean("W", "Use W", true)
SyndraMenu.LaneClear:Boolean("E", "Use E", false)
SyndraMenu.LaneClear:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

SyndraMenu:SubMenu("JungleClear", "JungleClear")
SyndraMenu.JungleClear:Boolean("Q", "Use Q", true)
SyndraMenu.JungleClear:Boolean("W", "Use W", true)
SyndraMenu.JungleClear:Boolean("E", "Use E", true)

SyndraMenu:SubMenu("Drawings", "Drawings")
SyndraMenu.Drawings:Boolean("Q", "Draw Q Range", true)
SyndraMenu.Drawings:Boolean("W", "Draw W Range", true)
SyndraMenu.Drawings:Boolean("E", "Draw E Range", true)
SyndraMenu.Drawings:Boolean("R", "Draw R Range", true)

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
 
function addInterrupterCallback( callback0 )
        callback = callback0
end

OnLoop(function(myHero)
  if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,800,925,190,false,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,250,1250,45,false,true)
        local EQPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,1280,60,false,true)

	if CanUseSpell(myHero, _R) == READY and SyndraMenu.Combo.R:Value() and GoS:ValidTarget(target, 725) then
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end	
		if GetCurrentHP(target)+GetMagicShield(target)+GetDmgShield(target) < GoS:CalcDamage(myHero, target, 0, (45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero))*(table.getn(Balls)+3) + ExtraDmg) then
		CastTargetSpell(target, _R)
	        end
        end
        
        if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and  EQPred.HitChance == 1 and SyndraMenu.Combo.EQ:Value() then
        CastSkillShot(_Q,EQPred.PredPos.x, EQPred.PredPos.y, EQPred.PredPos.z)
        GoS:DelayAction(function() CastSkillShot(_E,EQPred.PredPos.x, EQPred.PredPos.y, EQPred.PredPos.z) end, 250)
        end

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and SyndraMenu.Combo.Q:Value() and GoS:ValidTarget(target, 790) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
	
	if table.getn(Balls) > 0 then
	 for _,Ball in pairs(Balls) do
	  if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1250) and SyndraMenu.Combo.E:Value() then
            local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, GetOrigin(Ball))
            if isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
          end
         end
        end
	
	if GetCastName(myHero, _W) == "syndrawcast" and SyndraMenu.Combo.W:Value() and GoS:ValidTarget(target, 925) then
        CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z)
        end
	  
       if CanUseSpell(myHero, _W) == READY and if GetCastName(myHero, _W) ~= "syndrawcast" and GoS:ValidTarget(target, 925) and SyndraMenu.Combo.W:Value() then

            if table.getn(Balls) > 0 then 
              for _,Ball in pairs(Balls) do
                if GoS:GetDistance(myHero, Ball) <= 925 then
                CastTargetSpell(Ball, _W)
                end
              end
            end	  
	    
            for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	      if GoS:GetDistance(myHero, minion) <= 925 then 
	      CastTargetSpell(minion, _W)	  
	      end
            end
             
            for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	      if GoS:GetDistance(myHero, mob) <= 925 then 
	      CastTargetSpell(mob, _W)	  
	      end
	    end

       end
	
  end
  
  if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SyndraMenu.Harass.Mana:Value() then
	
	local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,800,925,190,false,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,250,1250,45,false,true)
        local EQPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,1280,60,false,true)
	  
        if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and  EQPred.HitChance == 1 and SyndraMenu.Harass.EQ:Value() then
        CastSkillShot(_Q,EQPred.PredPos.x, EQPred.PredPos.y, EQPred.PredPos.z)
        GoS:DelayAction(function() CastSkillShot(_E,EQPred.PredPos.x, EQPred.PredPos.y, EQPred.PredPos.z) end, 250)
        end

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and SyndraMenu.Harass.Q:Value() and GoS:ValidTarget(target, 790) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
        if table.getn(Balls) > 0 then
	 for _,Ball in pairs(Balls) do
	  if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1250) and SyndraMenu.Harass.E:Value() then
            local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, GetOrigin(Ball))
            if isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
          end
         end
        end
	
	if GetCastName(myHero, _W) == "syndrawcast" and SyndraMenu.Harass.W:Value() and GoS:ValidTarget(target, 925) then
        CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z)
        end
	  
       if CanUseSpell(myHero, _W) == READY and GetCastName(myHero, _W) ~= "syndrawcast" and GoS:ValidTarget(target, 925) and SyndraMenu.Harass.W:Value() then

            if table.getn(Balls) > 0 then 
              for _,Ball in pairs(Balls) do
                if GoS:GetDistance(myHero, Ball) <= 925 then
                CastTargetSpell(Ball, _W)
                end
              end
            end	  
	    
            for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	      if GoS:GetDistance(myHero, minion) <= 925 then 
	      CastTargetSpell(minion, _W)	  
	      end
            end
             
            for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	      if GoS:GetDistance(myHero, mob) <= 925 then 
	      CastTargetSpell(mob, _W)	  
	      end
	    end

       end

   end

   if SyndraMenu.Harass.AutoQ:Value() then
        local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
  
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 790) and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= SyndraMenu.Harass.QMana:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
   end
	
   for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,600,790,125,false,true)
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
	        if Ignite and SyndraMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 790) and SyndraMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 45*GetCastLevel(myHero,_Q)+5+.6*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	        end
   end
  
for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
   if IOW:Mode() == "LaneClear" then

     local mobPos = GetOrigin(mob)	
     local QPred = GetMEC(125, GoS:GetAllMinions(MINION_JUNGLE)) 
     local WPred = GetMEC(190, GoS:GetAllMinions(MINION_JUNGLE))

		if CanUseSpell(myHero, _Q) == READY and SyndraMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 790) then
		CastSkillShot(_Q, QPred.x, QPred.y, QPred.z)
		end
		
		if GetCastName(myHero, _W) == "syndrawcast" and SyndraMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 925) then
                CastSkillShot(_W, WPred.x, WPred.y, WPred.z)
                end
	  
                if CanUseSpell(myHero, _W) == READY and GetCastName(myHero, _W) ~= "syndrawcast" and GoS:ValidTarget(mob, 925) and SyndraMenu.JungleClear.W:Value() then

                  if table.getn(Balls) > 0 then 
                   for _,Ball in pairs(Balls) do
                     if GoS:GetDistance(myHero, Ball) <= 925 then
                     CastTargetSpell(Ball, _W)
                     end
                   end
                 end	  
	    
                 for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	           if GoS:GetDistance(myHero, minion) <= 925 then 
	           CastTargetSpell(minion, _W)
                   end
                 end

	           if GoS:GetDistance(myHero, mob) <= 925 then 
	           CastTargetSpell(mob, _W)	  
	           end
             end
		
	  if table.getn(Balls) > 0 then
            for _,Ball in pairs(Balls) do
              if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(mob, 1250) and SyndraMenu.JungleClear.E:Value() then
                local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), mobPos, GetOrigin(Ball))
                 if isOnSegment and GoS:GetDistance(pointSegment, mob) < 125 then
                CastSkillShot(_E, GetOrigin(Ball).x, GetOrigin(Ball).y, GetOrigin(Ball).z)
                end
              end	
            end
          end
   end
end

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		
   if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.LaneClear.Mana:Value() then

     local minionPos = GetOrigin(minion)	
     local QPred = GetMEC(125, GoS:GetAllMinions(MINION_ENEMY)) 
     local WPred = GetMEC(190, GoS:GetAllMinions(MINION_ENEMY))

		if CanUseSpell(myHero, _Q) == READY and SyndraMenu.LaneClear.Q:Value() and GoS:ValidTarget(minion, 790) then
		CastSkillShot(_Q, QPred.x, QPred.y, QPred.z)
		end
		
		if GetCastName(myHero, _W) == "syndrawcast" and SyndraMenu.LaneClear.W:Value() and GoS:ValidTarget(minion, 925) then
                CastSkillShot(_W, WPred.x, WPred.y, WPred.z)
                end
	  
                if CanUseSpell(myHero, _W) == READY and GetCastName(myHero, _W) ~= "syndrawcast" and GoS:ValidTarget(minion, 925) and SyndraMenu.LaneClear.W:Value() then

                  if table.getn(Balls) > 0 then 
                   for _,Ball in pairs(Balls) do
                     if GoS:GetDistance(myHero, Ball) <= 925 then
                     CastTargetSpell(Ball, _W)
                     end
                   end
                 end	  
	   
	           if GoS:GetDistance(myHero, minion) <= 925 then 
	           CastTargetSpell(minion, _W)	  
	           end
             
                 for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	           if GoS:GetDistance(myHero, mob) <= 925 then 
	           CastTargetSpell(mob, _W)	  
	           end
	         end
             end
		
	  if table.getn(Balls) > 0 then
            for _,Ball in pairs(Balls) do
              if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(minion, 1250) and SyndraMenu.LaneClear.E:Value() then
                local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), minionPos, GetOrigin(Ball))
                 if isOnSegment and GoS:GetDistance(pointSegment, minion) < 125 then
                CastSkillShot(_E, GetOrigin(Ball).x, GetOrigin(Ball).y, GetOrigin(Ball).z)
                end
              end	
            end
          end
   end
end
  
if SyndraMenu.Misc.Autolvl:Value() then
   if SyndraMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
   elseif SyndraMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
   end
LevelSpell(leveltable[GetLevel(myHero)])
end

if SyndraMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,790,1,128,0xff00ff00) end
if SyndraMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,925,1,128,0xff00ff00) end
if SyndraMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,1,128,0xff00ff00) end
if SyndraMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,725,1,128,0xff00ff00) end

end)
	
OnCreateObj(function(Object) 
if GetObjectBaseName(Object) == "Seed" then
table.insert(Balls, Object)
GoS:DelayAction(function() table.remove(Balls, 1) end, 6900)
end
end)

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,250,1250,45,false,true)

  if GoS:IsInDistance(target, 700) and CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and SyndraMenu.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)

  elseif table.getn(Balls) > 0 then
    for _,Ball in pairs(Balls) do
      if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1250) and SyndraMenu.Misc.Interrupt:Value() then
        local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), GetOrigin(target), GetOrigin(Ball))
        if isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
        CastSkillShot(_E, GetOrigin(Ball).x, GetOrigin(Ball).y, GetOrigin(Ball).z)
        end
      end
    end
  end

end)

GoS:AddGapcloseEvent(_E, 500, false) -- hi Copy-Pasters ^^

-- Huge Credits To Inferno for MEC
local GetOrigin = GetOrigin
local SQRT = math.sqrt

function TargetDist(point, target)
    local origin = GetOrigin(target)
    local dx, dz = origin.x-point.x, origin.z-point.z
    return SQRT( dx*dx + dz*dz )
end

function ExcludeFurthest(point, tbl)
    local removalId = 1
    for i=2, #tbl do
        if TargetDist(point, tbl[i]) > TargetDist(point, tbl[removalId]) then
            removalId = i
        end
    end
    
    local newTable = {}
    for i=1, #tbl do
        if i ~= removalId then
            newTable[#newTable+1] = tbl[i]
        end
    end
    return newTable
end

function GetMEC(aoe_radius, listOfEntities, starTarget)
    local average = {x=0, y=0, z=0, count = 0}
    for i=1, #listOfEntities do
        local ori = GetOrigin(listOfEntities[i])
        average.x = average.x + ori.x
        average.y = average.y + ori.y
        average.z = average.z + ori.z
        average.count = average.count + 1
    end
    if starTarget then
        local ori = GetOrigin(starTarget)
        average.x = average.x + ori.x
        average.y = average.y + ori.y
        average.z = average.z + ori.z
        average.count = average.count + 1
    end
    average.x = average.x / average.count
    average.y = average.y / average.count
    average.z = average.z / average.count
    
    local targetsInRange = 0
    for i=1, #listOfEntities do
        if TargetDist(average, listOfEntities[i]) <= aoe_radius then
            targetsInRange = targetsInRange + 1
        end
    end
    if starTarget and TargetDist(average, starTarget) <= aoe_radius then
        targetsInRange = targetsInRange + 1
    end
    
    if targetsInRange == average.count then
        return average
    else
        return GetMEC(aoe_radius, ExcludeFurthest(average, listOfEntities), starTarget)
    end
end
