if GetObjectName(myHero) ~= "Orianna" then return end

local Ball = nil
	
OriannaMenu = Menu("Orianna", "Orianna")
OriannaMenu:SubMenu("Combo", "Combo")
OriannaMenu.Combo:Boolean("Q", "Use Q", true)
OriannaMenu.Combo:Boolean("W", "Use W", true)
OriannaMenu.Combo:Boolean("E", "Use E", true)
OriannaMenu.Combo:Boolean("AutoR", "Auto R", true)
OriannaMenu.Combo:Slider("Renemy", "if X Around", 3, 0, 5, 1)

OriannaMenu:SubMenu("Harass", "Harass")
OriannaMenu.Harass:Boolean("Q", "Use Q", true)
OriannaMenu.Harass:Boolean("W", "Use W", true)
OriannaMenu.Harass:Boolean("E", "Use E", false)
OriannaMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

OriannaMenu:SubMenu("Killsteal", "Killsteal")
OriannaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
OriannaMenu.Killsteal:Boolean("W", "Killsteal with W", true)
OriannaMenu.Killsteal:Boolean("E", "Killsteal with E", true)
OriannaMenu.Killsteal:Boolean("R", "Killsteal with R", true)

OriannaMenu:SubMenu("Misc", "Misc")
OriannaMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
OriannaMenu.Misc:Boolean("Autolvl", "Auto level", true)

OriannaMenu:SubMenu("JungleClear", "JungleClear")
OriannaMenu.JungleClear:Boolean("Q", "Use Q", true)
OriannaMenu.JungleClear:Boolean("W", "Use W", true)
OriannaMenu.JungleClear:Boolean("E", "Use E", true)

OriannaMenu:SubMenu("Drawings", "Drawings")
OriannaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
OriannaMenu.Drawings:Boolean("E", "Draw E Range", true)

OnLoop(function(myHero)

        if Ball and GoS:GetDistance(myHero, Ball) > 1250 then
        Ball = nil
        end
	
	if IOW:Mode() == "Combo" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(Ball or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if SpellQREADY and QPred.HitChance == 1 and OriannaMenu.Combo.Q:Value() and GoS:ValidTarget(target, 825) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
	if SpellWREADY and OriannaMenu.Combo.W:Value() and GoS:ValidTarget(target, 825) then
	local BallPos = Ball or myHero
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) < 245 then
	 CastSpell(_W)
         end
        end

    if Ball ~= nil and SpellEREADY and GoS:ValidTarget(target, 1000) and OriannaMenu.Combo.E:Value() then
      local x,i,z = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, Ball)
      if y and GoS:GetDistance(x, target) < 80 then
      CastTargetSpell(myHero, _E)
      end
    end	
end
	
	if IOW:Mode() == "Harass" then
	
        local target = GetCurrentTarget()
	local targetPos = GetOrigin(target)
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	local QPred = GetPredictionForPlayer(Ball or GoS:myHeroPos(),target,GetMoveSpeed(target),1200,0,825,80,false,true)

	if SpellQREADY and QPred.HitChance == 1 and OriannaMenu.Harass.Q:Value() and GoS:ValidTarget(target, 825) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)   
	end
	
	if SpellWREADY and OriannaMenu.Harass.W:Value() and GoS:ValidTarget(target, 825) then
	local BallPos = Ball or myHero
	 if GoS:GetDistance(Ball or GoS:myHeroPos(), target) < 245 then
	 CastSpell(_W)
         end
        end

    if Ball ~= nil and SpellEREADY and GoS:ValidTarget(target, 1000) and OriannaMenu.Harass.E:Value() then
      local x,i,z = VectorPointProjectionOnLineSegment(GoS:myHeroPos(), targetPos, Ball)
      if y and GoS:GetDistance(x, target) < 80 then
      CastTargetSpell(myHero, _E)
      end
    end	
end

end)

OnProcessSpell(function(unit, spell)
    if unit and spell and spell.name then
        if unit == myHero then
                if spell.name:lower():find("OrianaIzunaCommand") then 
		Ball = spell.endPos
		end
		
		if spell.name:lower():find("OrianaRedactCommand") then 
		Ball = spell.target
		end
        end
    end
end)
