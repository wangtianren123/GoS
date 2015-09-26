if GetObjectName(myHero) ~= "Syndra" then return end

local Balls = 3
if Balls > 7 then
Balls = 7
end
local lastBallPos = Vector(0,0,0)
	
local SyndraMenu = Menu("Syndra", "Syndra")
SyndraMenu:SubMenu("Combo", "Combo")
SyndraMenu.Combo:Boolean("Q", "Use Q", true)
SyndraMenu.Combo:Boolean("W", "Use W", true)
SyndraMenu.Combo:Boolean("E", "Use E", true)
SyndraMenu.Combo:Boolean("R", "Use R", true)

SyndraMenu:SubMenu("Harass", "Harass")
SyndraMenu.Harass:Boolean("Q", "Use Q", true)
SyndraMenu.Harass:Boolean("W", "Use W", true)
SyndraMenu.Harass:Boolean("E", "Use E", false)
SyndraMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)
SyndraMenu.Harass:Boolean("AutoQ", "Auto Q", true)
SyndraMenu.Harass:Slider("QMana", "Auto Q if Mana >", 70, 0, 80, 1)

SyndraMenu:SubMenu("Killsteal", "Killsteal")
SyndraMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)

SyndraMenu:SubMenu("Misc", "Misc")
SyndraMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
SyndraMenu.Misc:Boolean("Autolvl", "Auto level", true)
SyndraMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E"})
SyndraMenu.Misc:Boolean("Interrupt", "Interrupt Spells (E)", true)

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
 
local function addInterrupterCallback( callback0 )
        callback = callback0
end

OnLoop(function(myHero)
  if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,800,925,190,false,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,250,1250,45,false,true)
	
	if CanUseSpell(myHero, _R) == READY and SyndraMenu.Combo.R:Value() and GoS:ValidTarget(target, 725) then
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if GetCurrentHP(target)+GetMagicShield(target)+GetDmgShield(target) < GoS:CalcDamage(myHero, target, 0, (45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero))*Balls + ExtraDmg) then
		CastTargetSpell(target, _R)
	end
	
        end

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and SyndraMenu.Combo.Q:Value() and GoS:ValidTarget(target, 790) then
       CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
	
	if lastBallPos and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1250) and SyndraMenu.Combo.E:Value() then
          local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, lastBallPos)
          if isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
          end
        end
	
	if CanUseSpell(myHero, _W) == READY and SyndraMenu.Combo.W:Value() and GoS:ValidTarget(target, 925) then
	for _,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	  for i,mob in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
            if Balls > 0 then 
            CastTargetSpell(lastBallPos, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    elseif GoS:IsInDistance(minion, 925) then 
	    CastTargetSpell(minion, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    elseif GoS:IsInDistance(mob, 925) then 
	    CastTargetSpell(mob, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    end
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
	
	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and SyndraMenu.Harass.Q:Value() and GoS:ValidTarget(target, 790) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
        if lastBallPos and GoS:ValidTarget(target, 1250) and SyndraMenu.Harass.E:Value() then
         local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, lastBallPos)
         if CanUseSpell(myHero, _E) == READY and isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
         CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
         end
        end
	
	if CanUseSpell(myHero, _W) == READY and SyndraMenu.Harass.W:Value() and GoS:ValidTarget(target, 925) then
	for _,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	  for i,mob in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
            if Balls > 0 then 
            CastTargetSpell(lastBallPos, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    elseif GoS:IsInDistance(minion, 925) then 
	    CastTargetSpell(minion, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    elseif GoS:IsInDistance(mob, 925) then 
            CastTargetSpell(mob, _W)	  
	    GoS:DelayAction(function() CastSkillShot(_W, WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z) end, 200)
	    end
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
		
	        if Ignite and SyndraMenu.Misc.Autoignite:Value() then
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
		
		if CanUseSpell(myHero, _Q) == READY and SyndraMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 790) then
		CastSkillShot(_Q, mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and SyndraMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 925) then
		  if Balls > 0 then
		  CastTargetSpell(lastBallPos, _W)
		  GoS:DelayAction(function() CastSkillShot(_W, mobPos.x, mobPos.y, mobPos.z) end, 200)
		  else
		  CastTargetSpell(mob, _W)
		  GoS:DelayAction(function() CastSkillShot(_W, mobPos.x, mobPos.y, mobPos.z) end, 200)
		  end
		end
		
	        if lastBallPos and GoS:ValidTarget(mob, 1250) and SyndraMenu.JungleClear.E:Value() then
                  local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), mobPos, lastBallPos)
                  if CanUseSpell(myHero, _E) == READY and isOnSegment and GoS:GetDistance(pointSegment, mob) < 125 and EPred.HitChance == 1 then
                  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
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

if SyndraMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,790,0,1,0xff00ff00) end
if SyndraMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,925,0,1,0xff00ff00) end
if SyndraMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,700,0,1,0xff00ff00) end
if SyndraMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,725,0,1,0xff00ff00) end

end)
	
OnCreateObj(function(Object) 
if GetObjectBaseName(Object) == "Seed" then
lastBallPos = Vector(Object)
Balls = Balls + 1
GoS:DelayAction(function() Balls = Balls - 1 end, 6900)
end
end)

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,250,1250,45,false,true)
  if GoS:IsInDistance(target, 700) and CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and SyndraMenu.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  elseif lastBallPos and GoS:ValidTarget(target, 1250) and SyndraMenu.Misc.Interrupt:Value() then
    local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, lastBallPos)
    if CanUseSpell(myHero, _E) == READY and isOnSegment and GoS:GetDistance(pointSegment, target) < 125 and EPred.HitChance == 1 then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
  end
end)

GoS:AddGapcloseEvent(_E, 500, false) -- hi Copy-Pasters ^^
