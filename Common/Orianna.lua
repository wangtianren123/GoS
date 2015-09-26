if GetObjectName(myHero) ~= "Orianna" then return end

local Ball = nil
	
OriannaMenu = Menu("Orianna", "Orianna")
OriannaMenu:SubMenu("Combo", "Combo")
OriannaMenu.Combo:Boolean("Q", "Use Q", true)
OriannaMenu.Combo:Boolean("W", "Use W", true)
OriannaMenu.Combo:Boolean("E", "Use E", true)
OriannaMenu.Combo:SubMenu("R", "Use R")
OriannaMenu.Combo.R:Boolean("REnabled", "Enabled", true)
OriannaMenu.Combo.R:Boolean("Rkill", "if Can Kill", true)
OriannaMenu.Combo.R:Slider("Rcatch", "if can catch X enemies", 2, 0, 5, 1)
--OriannaMenu.Combo.R:Key("FlashR", "R Flash Combo", string.byte("G"))
--OriannaMenu.Combo.R:Slider("FlashRcatch", "if can catch X enemies", 3, 0, 5, 1)

OriannaMenu:SubMenu("Harass", "Harass")
OriannaMenu.Harass:Boolean("Q", "Use Q", true)
OriannaMenu.Harass:Boolean("W", "Use W", true)
OriannaMenu.Harass:Boolean("E", "Use E", false)
OriannaMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

OriannaMenu:SubMenu("Killsteal", "Killsteal")
OriannaMenu.Killsteal:Boolean("Q", "Killsteal with Q", false)
OriannaMenu.Killsteal:Boolean("W", "Killsteal with W", true)
OriannaMenu.Killsteal:Boolean("E", "Killsteal with E", false)

OriannaMenu:SubMenu("Misc", "Misc")
OriannaMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
OriannaMenu.Misc:Boolean("Autolvl", "Auto level", true)
OriannaMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E", "Q-E-W"})
OriannaMenu.Misc:Boolean("Interrupt", "Interrupt Dangerous Spells (R)", true)
OriannaMenu.Misc:SubMenu("AutoUlt", "Auto Ult")
OriannaMenu.Misc.AutoUlt:Boolean("Enabled", "Enabled", true)
OriannaMenu.Misc.AutoUlt:Slider("1", "if Can Catch X Enemies", 3, 0, 5, 1)
OriannaMenu.Misc.AutoUlt:Slider("2", "if Can Kill X Enemies", 2, 0, 5, 1)

OriannaMenu:SubMenu("JungleClear", "JungleClear")
OriannaMenu.JungleClear:Boolean("Q", "Use Q", true)
OriannaMenu.JungleClear:Boolean("W", "Use W", true)
OriannaMenu.JungleClear:Boolean("E", "Use E", true)

--[[OriannaMenu:SubMenu("LaneClear", "LaneClear")
OriannaMenu.LaneClear:Boolean("Q", "Use Q", true)
OriannaMenu.LaneClear:Boolean("W", "Use W", true)]]

OriannaMenu:SubMenu("Drawings", "Drawings")
OriannaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
OriannaMenu.Drawings:Boolean("W", "Draw W Radius", true)
OriannaMenu.Drawings:Boolean("E", "Draw E Range", true)
OriannaMenu.Drawings:Boolean("R", "Draw R Radius", true)
OriannaMenu.Drawings:Boolean("Ball", "Draw Ball Position", true)

CHANELLING_SPELLS = {
    ["Katarina"]                    = {_R},
    ["FiddleSticks"]                = {_R},
    ["VelKoz"]                      = {_R},
    ["Malzahar"]                    = {_R},
    ["Warwick"]                     = {_R},
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
 
local function addInterrupterCallback( callback0 )
        callback = callback0
end


OnLoop(function(myHero)
	
     if IOW:Mode() == "Combo" then
	    
	local myHero = myHero
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GetOrigin(Ball) or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if CanUseSpell(myHero, _R) == READY and OriannaMenu.Combo.R.REnabled:Value() then
	  if GoS:EnemiesAround(Ball or GoS:myHeroPos(), 400) >= OriannaMenu.Combo.R.Rcatch:Value() then
	  CastSpell(_R)
	  end
	end
	
	if CanUseSpell(myHero, _R) == READY then
	  if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and OriannaMenu.Combo.Q:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 825) < 2 and GoS:ValidTarget(target, 825) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	  end
	elseif CanUseSpell(myHero, _R) ~= READY then
          if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and OriannaMenu.Combo.Q:Value() and GoS:ValidTarget(target, 825) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	  end
	end
		
	
	if CanUseSpell(myHero, _W) == READY and OriannaMenu.Combo.W:Value() and GoS:ValidTarget(target, 1200) then
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) <= 250 then
	 CastSpell(_W)
         end
        end

        if Ball ~= nil and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and OriannaMenu.Combo.E:Value() then
          local pointSegment,pointLine,isOnSegment  = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, Vector(Ball))
          if pointLine and GoS:GetDistance(pointSegment, target) < 80 then
          CastTargetSpell(myHero, _E)
          end
        end	
     end
	
     if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= OriannaMenu.Harass.Mana:Value() then
	
	local myHero = myHero
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GetOrigin(Ball) or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and OriannaMenu.Harass.Q:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 825) < 2 and GoS:ValidTarget(target, 825) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
	if CanUseSpell(myHero, _W) == READY and OriannaMenu.Harass.W:Value() and GoS:ValidTarget(target, 825) then
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) <= 250 then
	 CastSpell(_W)
         end
        end

        if Ball ~= nil and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and OriannaMenu.Harass.E:Value() then
          local pointSegment,pointLine,isOnSegment  = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, Vector(Ball))
          if pointLine and GoS:GetDistance(pointSegment, target) <= 80 then
          CastTargetSpell(myHero, _E)
          end
        end	
     end
    
	local KillableEnemies = 0
	
        for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	  
	    local myHero = myHero
	    local QPred = GetPredictionForPlayer(GetOrigin(Ball) or GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1200,0,825,80,false,true)
	    local enemyPos = GetOrigin(enemy)
		
	    local ExtraDmg = 0
	    if GotBuff(myHero, "itemmagicshankcharge") > 99 then
      	    ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	    end
		
	    if Ignite and OriannaMenu.Misc.AutoIgnite:Value() then
              if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
              CastTargetSpell(enemy, Ignite)
              end
            end
						
  	    if IOW:Mode() == "Combo" and GoS:ValidTarget(enemy, 1200) and OriannaMenu.Combo.R.Rkill:Value() and GoS:GetDistance(Ball or GoS:myHeroPos(), enemy) < 400 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 75*GetCastLevel(myHero, _R)+75+0.7*GetBonusAP(myHero) + ExtraDmg) then 
            CastSpell(_R)
            end
		
	    if CanUseSpell(myHero, _R) == READY and OriannaMenu.Misc.AutoUlt.Enabled:Value() then
              if GoS:ValidTarget(enemy, 1200) and GoS:GetDistance(Ball or GoS:myHeroPos(), enemy) <= 400 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 75*GetCastLevel(myHero, _R)+75+0.7*GetBonusAP(myHero) + ExtraDmg) then 
              KillableEnemies = KillableEnemies	+ 1
              end
		  
	      if KillableEnemies >= OriannaMenu.Misc.AutoUlt.2:Value() then
	      CastSpell(_R)
	      end
	    end
		
	    if CanUseSpell(myHero, _W) == READY and OriannaMenu.Killsteal.W:Value() and GoS:ValidTarget(target, 1200) and GoS:GetDistance(Ball or GoS:myHeroPos(), enemy) <= 250 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 45*GetCastLevel(myHero,_W)+25+0.7*GetBonusAP(myHero) + ExtraDmg) then
	    CastSpell(_W)
	    elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 825) and OriannaMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero, _Q)+30+0.5*GetBonusAP(myHero) + ExtraDmg) then 
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, 1000) and OriannaMenu.Killsteal.E:Value() and Ball ~= nil then
              local pointSegment,pointLine,isOnSegment  = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), enemyPos, Vector(Ball))
              if pointLine and GoS:GetDistance(pointSegment, enemy) <= 80 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero, _R)+30+0.3GetBonusAP(myHero) + ExtraDmg) then
              CastTargetSpell(myHero, _E)
              end 
	    end
		
		local QThrowPos = GetMEC(400,enemy) 
		if IOW:Mode() == "Combo" and GoS:EnemiesAround(GoS:myHeroPos(), 825) >= 2 and GoS:ValidTarget(enemy, 825) and CanUseSpell(myHero, _R) == READY and OriannaMenu.Combo.Q:Value() then 
        CastSkillShot(_Q, QThrowPos.x, QThrowPos.y, QThrowPos.z)
        end
		
	end
	
	if CanUseSpell(myHero, _R) == READY and OriannaMenu.Misc.AutoUlt.Enabled:Value() then
	  if GoS:EnemiesAround(Ball or GoS:myHeroPos(), 400) >= OriannaMenu.Misc.AutoUlt.1:Value() then
	  CastSpell(_R)
	  end
	end
	
        for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
            if IOW:Mode() == "LaneClear" then
	        local mobPos = GetOrigin(mob)
	    
		if CanUseSpell(myHero, _W) == READY and OriannaMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 1200) and GoS:GetDistance(Ball or GoS:myHeroPos(), mob) <= 250 then
		CastSpell(_W)
		end
		
		if CanUseSpell(myHero, _Q) == READY and OriannaMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 825) then
		CastSkillShot(_Q, mobPos.x, mobPos.y, mobPos.z) 
		end
		
		if CanUseSpell(myHero, _E) == READY and OriannaMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 1000) and Ball ~= nil then
		  local pointSegment,pointLine,isOnSegment  = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), mobPos, Vector(Ball))
                  if pointLine and GoS:GetDistance(pointSegment, mob) <= 80
		  CastTargetSpell(myHero, _E)
		  end
		end
            end
	  
        end
	
if OriannaMenu.Misc.Autolvl:Value() then  
    if OriannaMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
    elseif OriannaMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _W, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
    elseif OriannaMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
    end
LevelSpell(leveltable[GetLevel(myHero)])
end

if OriannaMenu.Drawings.Ball:Value() then DrawCircle(GetOrigin(Ball).x or GoS:myHeroPos().x, GetOrigin(Ball).y or GoS:myHeroPos().y, GetOrigin(Ball).z or GoS:myHeroPos().z,150,0,1,0xffffffff) end
if OriannaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,825,0,1,0xff00ff00) end
if OriannaMenu.Drawings.W:Value() then DrawCircle(GetOrigin(Ball).x or GoS:myHeroPos().x, GetOrigin(Ball).y or GoS:myHeroPos().y, GetOrigin(Ball).z or GoS:myHeroPos().z,250,0,1,0xff00ff00) end
if OriannaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1000,0,1,0xff00ff00) end
if OriannaMenu.Drawings.R:Value() then DrawCircle(GetOrigin(Ball).x or GoS:myHeroPos().x, GetOrigin(Ball).y or GoS:myHeroPos().y, GetOrigin(Ball).z or GoS:myHeroPos().z,400,0,1,0xff00ff00) end

end)

OnProcessSpell(function(unit, spell)
    if unit and spell and spell.name then
      if unit == myHero then
        if spell.name:lower():find("orianaizunacommand") then 
	Ball = spell.endPos
	end
		
	if spell.name:lower():find("orianaredactcommand") then 
	Ball = spell.target
	end
      end
    end
end)

OnCreateObj(function(Object) 

if GetObjectBaseName(Object) == "Orianna_Ball_Flash_Reverse" then
Ball = nil
end

if GetObjectBaseName(Object) == "yomu_ring_green" then
Ball = Object
end

end)

local addInterrupterCallback(function(target, spellType)
  if CanUseSpell(myHero, _R) == READY and GoS:GetDistance(Ball or GoS:myHeroPos(), enemy) <= 400 and OriannaMenu.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSpell(_R)
  end
end)

-- Huge Credits To Inferno for MEC
local GetOrigin = GetOrigin
local SQRT = math.sqrt

local function TargetDist(point, target)
    local origin = GetOrigin(target)
    local dx, dz = origin.x-point.x, origin.z-point.z
    return SQRT( dx*dx + dz*dz )
end

local function ExcludeFurthest(point, tbl)
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

local function GetMEC(aoe_radius, listOfEntities, starTarget)
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
