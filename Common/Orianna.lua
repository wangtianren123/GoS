if GetObjectName(myHero) ~= "Orianna" then return end

local Ball = nil
	
OriannaMenu = Menu("Orianna", "Orianna")
OriannaMenu:SubMenu("Combo", "Combo")
OriannaMenu.Combo:Boolean("Q", "Use Q", true)
OriannaMenu.Combo:Boolean("W", "Use W", true)
OriannaMenu.Combo:Boolean("E", "Use E", true)
OriannaMenu.Combo:Boolean("R", "Use R")
OriannaMenu.Combo.R:Slider("Rcatch", "if can catch X enemies", 2, 0, 5, 1)
OriannaMenu.Combo.R:Boolean("Rkill", "if Can Kill", true)
OriannaMenu.Misc:Key("FlashR", "R Flash Combo", string.byte("G"))
OriannaMenu.Combo.R:Slider("FlashRcatch", "if can catch X enemies", 3, 0, 5, 1)

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
OriannaMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
OriannaMenu.Misc:Boolean("Autolvl", "Auto level", true)
OriannaMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E", "Q-E-W"})
OriannaMenu.Misc:SubMenu("AutoUlt", "Auto Ult")
OriannaMenu.Misc.AutoUlt:Slider("1", "if Can Catch X Enemies", 3, 0, 5, 1)
OriannaMenu.Misc.AutoUlt:Slider("2", "if Can Kill X Enemies", 2, 0, 5, 1)

OriannaMenu:SubMenu("JungleClear", "JungleClear")
OriannaMenu.JungleClear:Boolean("Q", "Use Q", true)
OriannaMenu.JungleClear:Boolean("W", "Use W", true)
OriannaMenu.JungleClear:Boolean("E", "Use E", true)

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
 
function addInterrupterCallback( callback0 )
        callback = callback0
end


OnLoop(function(myHero)
	
	if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GetOrigin(Ball) or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and OriannaMenu.Combo.Q:Value() and GoS:ValidTarget(target, 825) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
	if CanUseSpell(myHero, _W) == READY and OriannaMenu.Combo.W:Value() and GoS:ValidTarget(target, 825) then
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) < 250 then
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
	
	if IOW:Mode() == "Harass" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GetOrigin(Ball) or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and OriannaMenu.Harass.Q:Value() and GoS:ValidTarget(target, 825) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
	if CanUseSpell(myHero, _W) == READY and OriannaMenu.Harass.W:Value() and GoS:ValidTarget(target, 825) then
	local BallPos = Ball or myHero
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) < 250 then
	 CastSpell(_W)
         end
        end

    if Ball ~= nil and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and OriannaMenu.Harass.E:Value() then
      local pointSegment,pointLine,isOnSegment  = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, Vector(Ball))
      if pointLine and GoS:GetDistance(pointSegment, target) < 80 then
      CastTargetSpell(myHero, _E)
      end
    end	
end

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

end

if GetObjectBaseName(Object) == "Orianna_Ball_Flash_Reverse" then
Ball = nil
if GetObjectBaseName(Object) == "yomu_ring_green" then
Ball = Object
end

end)
