if GetObjectName(myHero) ~= "Thresh" then return end

ThreshMenu = Menu("Thresh", "Thresh")
ThreshMenu:SubMenu("Combo", "Combo")
ThreshMenu.Combo:Boolean("Q", "Use Q", true)
ThreshMenu.Combo:Boolean("Q2", "Jump to Target", true)
ThreshMenu.Combo:Boolean("E", "Use E", true)
ThreshMenu.Combo:Boolean("R", "Use R", true)

ThreshMenu:SubMenu("Harass", "Harass")
ThreshMenu.Harass:Boolean("Q", "Use Q", true)
ThreshMenu.Harass:Boolean("E", "Use E", true)

ThreshMenu:SubMenu("Misc", "Misc")
ThreshMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
ThreshMenu.Misc:Boolean("Autolvl", "Auto level", true)
ThreshMenu.Misc:Key("Lantern", "Throw Lantern", string.byte("G"))
ThreshMenu.Misc:Boolean("AutoR", "Auto R", true)
ThreshMenu.Misc:Slider("AutoRmin", "Minimum Enemies in Range", 3, 1, 5, 1)
ThreshMenu.Misc:SubMenu("Interrupt", "Interrupt")
ThreshMenu.Misc.Interrupt:Boolean("Q", "Interrupt with Q", true)
ThreshMenu.Misc.Interrupt:Boolean("E", "Interrupt with E", true)

ThreshMenu:SubMenu("Drawings", "Drawings")
ThreshMenu.Drawings:Boolean("Q", "Draw Q Range", true)
ThreshMenu.Drawings:Boolean("W", "Draw W Range", true)
ThreshMenu.Drawings:Boolean("E", "Draw E Range", true)
ThreshMenu.Drawings:Boolean("R", "Draw R Range", true)

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
                local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
		local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
				
                if GetCastName(myHero, _Q) ~= "threshqleap" and SpellQREADY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1100) and ThreshMenu.Combo.Q:Value() then
                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif GetCastName(myHero, _Q) == "threshqleap" and ThreshMenu.Combo.Q2:Value() then
                CastSpell(_Q)
                end
			
		local xPos = GetOrigin(myHero).x + (GetOrigin(myHero).x - EPred.PredPos.x)
		local yPos = GetOrigin(myHero).y + (GetOrigin(myHero).y - EPred.PredPos.y)
		local zPos = GetOrigin(myHero).z + (GetOrigin(myHero).z - EPred.PredPos.z)
			
		if SpellEREADY and EPred.HitChance == 1 and ThreshMenu.Combo.E:Value() and GoS:ValidTarget(target, 400) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) >= 26 then
		CastSkillShot(_E, xPos, yPos, zPos)
		elseif SpellEREADY and EPred.HitChance == 1 and ThreshMenu.Combo.E:Value() and GoS:ValidTarget(target, 400) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 26 then
                CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end				
           
		if SpellRREADY and GoS:ValidTarget(target, 450) and ThreshMenu.Combo.R:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 then
		CastSpell(_R)
		end
		
    end
		
	if IOW:Mode() == "Harass" then
	
	        local target = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
		local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
				
                if GetCastName(myHero, _Q) ~= "threshqleap" and SpellQREADY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1100) and ThreshMenu.Harass.Q:Value() then
                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		local xPos = GetOrigin(myHero).x + (GetOrigin(myHero).x - EPred.PredPos.x)
		local yPos = GetOrigin(myHero).y + (GetOrigin(myHero).y - EPred.PredPos.y)
		local zPos = GetOrigin(myHero).z + (GetOrigin(myHero).z - EPred.PredPos.z)
			
		if SpellEREADY and EPred.HitChance == 1 and ThreshMenu.Harass.E:Value() and GoS:ValidTarget(target, 400) then
		CastSkillShot(_E, xPos, yPos, zPos)
		end
	end
	
        if ThreshMenu.Misc.AutoR:Value() and SpellRREADY and GoS:EnemiesAround(GoS:myHeroPos(), 450) >= ThreshMenu.Misc.AutoRmin:Value() then
	CastSpell(_R)
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	   
		if Ignite and ThreshMenu.Misc.Autoignite:Value() then
                  if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
	end
	
	if ThreshMenu.Misc.Lantern:Value() then
	  for _, ally in pairs(GoS:GetAllyHeroes()) do
            local WPred = GetPredictionForPlayer(GoS:myHeroPos(),ally,GetMoveSpeed(ally),3300,250,950,90,false,true)
            local AllyPos = GetOrigin(ally)
            local mousePos = GetMousePos()
            if CanUseSpell(myHero,_W) and IsObjectAlive(ally) and ally ~= myHero and GoS:GetDistance(myHero, ally) < 950 then
            CastSkillShot(_W,WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z)
	    else
	    MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
	    end
         end
	end

if ThreshMenu.Misc.Autolvl:Value() then  
local leveltable = {_Q, _E, _W, _E, _E, _R, _Q, _Q, _Q, _E, _R, _Q, _E, _W, _W, _R, _W, _W} -- Credits goes to Inferno for saving me 20 line xD
LevelSpell(leveltable[GetLevel(myHero)]) 
end

if ThreshMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,1100,3,100,0xff00ff00) end
if ThreshMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,950,3,100,0xff00ff00) end
if ThreshMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,400,3,100,0xff00ff00) end
if ThreshMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,450,3,100,0xff00ff00) end

SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY

end)

addInterrupterCallback(function(target, spellType)
  local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
  if GoS:IsInDistance(target, GetCastRange(myHero,_E)) and SpellEREADY and EPred.HitChance == 1 and ThreshMenu.Misc.Interrupt.E:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  elseif GoS:IsInDistance(target, GetCastRange(myHero,_Q)) and SpellQREADY and QPred.HitChance == 1 and ThreshMenu.Misc.Interrupt.Q:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
  end
end)

GoS:AddGapcloseEvent(_E, 450, false) -- hi Copy-Pasters ^^
