if GetObjectName(myHero) ~= "Cassiopeia" then return end

CassiopeiaMenu = Menu("Cassiopeia", "Cassiopeia")
CassiopeiaMenu:SubMenu("Combo", "Combo")
CassiopeiaMenu.Combo:Boolean("Q", "Use Q", true)
CassiopeiaMenu.Combo:Boolean("W", "Use W", true)
CassiopeiaMenu.Combo:Boolean("E", "Use E", true)
CassiopeiaMenu.Combo:Boolean("R", "Use R", true)

CassiopeiaMenu:SubMenu("Harass", "Harass")
CassiopeiaMenu.Harass:Boolean("Q", "Use Q", true)
CassiopeiaMenu.Harass:Boolean("W", "Use W", true)
CassiopeiaMenu.Harass:Boolean("E", "Use E", true)

CassiopeiaMenu:SubMenu("Killsteal", "Killsteal")
CassiopeiaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
CassiopeiaMenu.Killsteal:Boolean("W", "Killsteal with W", true)
CassiopeiaMenu.Killsteal:Boolean("E", "Killsteal with E", true)

CassiopeiaMenu:SubMenu("Misc", "Misc")
CassiopeiaMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
CassiopeiaMenu.Misc:Boolean("Autolvl", "Auto level", false)
CassiopeiaMenu.Misc:Boolean("Interrupt", "Interrupt Spells with R", true)
CassiopeiaMenu.Misc:Slider("HP", "if HP % <", 50, 1, 100, 1)

CassiopeiaMenu:SubMenu("Farm", "Farm")
CassiopeiaMenu.Misc:Boolean("AutoE", "Auto E if pois", true)
CassiopeiaMenu.Farm:SubMenu("LastHit2", "LastHit with E")
CassiopeiaMenu.Farm.LastHit2:Boolean("EX", "Enabled", true)
CassiopeiaMenu.Farm.LastHit2:Boolean("EXP", "Only if pois", true)
CassiopeiaMenu.Farm:SubMenu("LaneClear", "LaneClear")
CassiopeiaMenu.Farm.LaneClear:Boolean("E", "Use E", true)
CassiopeiaMenu.Farm.LaneClear:Slider("Mana", "Min Mana %", 50, 1, 100, 1)

CassiopeiaMenu:SubMenu("JungleClear", "JungleClear")
CassiopeiaMenu.JungleClear:Boolean("Q", "Use Q", true)
CassiopeiaMenu.JungleClear:Boolean("W", "Use W", true)
CassiopeiaMenu.JungleClear:Boolean("E", "Use E", true)

CassiopeiaMenu:SubMenu("Drawings", "Drawings")
CassiopeiaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
CassiopeiaMenu.Drawings:Boolean("W", "Draw W Range", false)
CassiopeiaMenu.Drawings:Boolean("E", "Draw E Range", false)
CassiopeiaMenu.Drawings:Boolean("R", "Draw R Range", false)

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

		local unit = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,300,800,180,false,true)
		
		local poisoned = false
		for i=0, 63 do
		    if unit and GoS:ValidTarget(unit, 700) and GetBuffCount(unit,i) > 0 and GetBuffName(unit,i):lower():find("poison") then
		        poisoned = true
		    end
		end
      
		if IsFacing(unit, 800) and GoS:ValidTarget(unit, 800) and CassiopeiaMenu.Combo.R:Value() and 100*GetCurrentHP(unit)/GetMaxHP(unit) <= 60 then
		CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end
		
	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Combo.E:Value() and GoS:ValidTarget(unit, 700) and poisoned then
		CastTargetSpell(unit, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.Combo.Q:Value() and GoS:ValidTarget(unit, 850) and QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.Combo.W:Value() and GoS:ValidTarget(unit, 925) and WPred.HitChance == 1 and not poisoned then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
    end

    if IOW:Mode() == "Harass" then
	
		local unit = GetCurrentTarget()
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),math.huge,300,800,180,false,true)
		
		local poisoned = false
		for i=0, 63 do
		    if unit and GoS:ValidTarget(unit, 700) and GetBuffCount(unit,i) > 0 and GetBuffName(unit,i):lower():find("poison") then
			poisoned = true
		    end
		end
		
	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Harass.E:Value() and GoS:ValidTarget(unit, 700) and poisoned then
		CastTargetSpell(unit, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.Harass.Q:Value() and GoS:ValidTarget(unit, 850) and QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.Harass.W:Value() and GoS:ValidTarget(unit, 925) and WPred.HitChance == 1 then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
    end

	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,600,850,75,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2500,500,925,90,false,true)
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,300,800,180,false,true)
		
		if Ignite and CassiopeiaMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
		end
		
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 850) and CassiopeiaMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40*GetCastLevel(myHero,_Q)+35+.45*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(enemy, 850) and CassiopeiaMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 15*GetCastLevel(myHero,_W)+15+0.3*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, 700) and CassiopeiaMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _E)
		end
		
	end

if CassiopeiaMenu.Misc.Autolvl:Value() then    
local leveltable = {_Q, _E, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W} 
LevelSpell(leveltable[GetLevel(myHero)])
end

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do

                local unit = minion
		local poisoned = false
		for i=0, 63 do
		    if unit and GoS:ValidTarget(unit, 700) and GetBuffCount(unit,i) > 0 and GetBuffName(unit,i):lower():find("poison") then
			poisoned = true
		    end
		end
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end

        if IOW:Mode() == "LaneClear" then
		  if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LaneClear.E:Value() and GoS:IsInDistance(minion, 700) and poisoned and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= CassiopeiaMenu.Farm.LaneClear.Mana:Value() then
		  CastTargetSpell(minion, _E)
	          end
	end
	
	if IOW:Mode() == "LastHit" then
	          if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LastHit2.EX:Value() and CassiopeiaMenu.Farm.LastHit2.EXP:Value() and GoS:IsInDistance(minion, 700) and poisoned and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		  CastTargetSpell(minion, _E)
		  elseif CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.Farm.LastHit2.EX:Value() and not CassiopeiaMenu.Farm.LastHit2.EXP:Value() and GoS:IsInDistance(minion, 700) and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) then
		  CastTargetSpell(minion, _E)
		  end
	end
	
	    if CassiopeiaMenu.Misc.AutoE:Value() then
	      if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(minion, 700) and poisoned and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 25*GetCastLevel(myHero,_E)+30+0.55*GetBonusAP(myHero) + ExtraDmg) and IOW:Mode() ~= "Combo" then
	      CastTargetSpell(minion, _E)
	      end
	    end
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
        
	        local mobPos = GetOrigin(mob)
                local unit = mob
     	        local poisoned = false
	        local poisoned = false
		for i=0, 63 do
		    if unit and GoS:ValidTarget(unit, 700) and GetBuffCount(unit,i) > 0 and GetBuffName(unit,i):lower():find("poison") then
			poisoned = true
		    end
		end
		
        if IOW:Mode() == "LaneClear" then
		
	        if CanUseSpell(myHero, _E) == READY and CassiopeiaMenu.JungleClear.E:Value() and GoS:IsInDistance(mob, 700) and poisoned then
		CastTargetSpell(mob, _E)
		end
			
		if CanUseSpell(myHero, _Q) == READY and CassiopeiaMenu.JungleClear.Q:Value() and GoS:IsInDistance(mob, 850) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and CassiopeiaMenu.JungleClear.W:Value() and GoS:IsInDistance(mob, 925) then
		CastSkillShot(_W,mobPos.x, mobPos.y, mobPos.z)
		end
	end
end

if CassiopeiaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CassiopeiaMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CassiopeiaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CassiopeiaMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff00ff00) end

SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY

end)

addInterrupterCallback(function(target, spellType)
  local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,800,180,false,true)
  if GoS:IsInDistance(target, 800) and IsFacing(target, 800) and CassiopeiaMenu.Misc.Interrupt:Value() and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) <= CassiopeiaMenu.Misc.HP:Value() and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

--------------------------------------Thanks Maxxxel For this <3--------------------------------
local myHero = GetMyHero()
local lastattackposition={true,true,true}

function IsFacing(targetFace,range,unit) 
	range=range or 99999
	unit=unit or myHero
	targetFace=targetFace
	if (targetFace and unit)~=nil and (ValidtargetUnit(targetFace,range,unit)) and GetDistance2(targetFace,unit)<=range then
		local unitXYZ= GetOrigin(unit)
		local targetFaceXYZ=GetOrigin(targetFace)
		local lastwalkway={true,true,true}
		local walkway = GetPredictionForPlayer(GetOrigin(unit),targetFace,GetMoveSpeed(targetFace),0,1000,2000,0,false,false)

		if walkway.PredPos.x==targetFaceXYZ.x then

			if lastwalkway.x~=nil then

				local d1 = GetDistance2(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1


    	elseif lastwalkway.x==nil then
    		if lastattackposition.x~=nil and lastattackposition.name==GetObjectName(targetFace) then
					local d1 = GetDistance2(targetFace,unit)
    			local d2 = GetDistance2XYZ(lastattackposition.x,lastattackposition.z,unitXYZ.x,unitXYZ.z)
    			return d2 < d1
    		end
    	end
    elseif walkway.PredPos.x~=targetFaceXYZ.x then
    	lastwalkway={x=walkway.PredPos.x,y=walkway.PredPos.y,z=walkway.PredPos.z} 

    	if lastwalkway.x~=nil then
		local d1 = GetDistance2(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1
    	end
    end
	end
end


function ValidtargetUnit(targetFace,range,unit)
    range = range or 25000
    unit = unit or myHero
    if targetFace == nil or GetOrigin(targetFace) == nil or IsImmune(targetFace,unit) or IsDead(targetFace) or not IsVisible(targetFace) or GetTeam(targetFace) == GetTeam(unit) or GetDistance2(targetFace,unit)>range then return false end
    return true
end

function GetDistance2(p1,p2)
    p1 = GetOrigin(p1) or p1
    p2 = GetOrigin(p2) or p2
    return math.sqrt(GetDistance2Sqr(p1,p2))
end

function GetDistance2Sqr(p1,p2)
    p2 = p2 or GetMyHeroPos()
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
end

function GetDistance2XYZ(x,z,x2,z2)
	if (x and z and x2 and z2)~=nil then
		a=x2-x
		b=z2-z
		if (a and b)~=nil then
			a2=a*a
			b2=b*b
			if (a2 and b2)~=nil then
				return math.sqrt(a2+b2)
			else
				return 99999
			end
		else
			return 99999
		end
	end	
end

OnProcessSpell(function(Object,spellProc)
	local Obj_Type = GetObjectType(Object)
	if Object~=nil and Obj_Type==Obj_AI_Hero then
		if spellProc.name~=nil then
			for i,enemy in pairs(GoS:GetEnemyHeroes()) do
				if ValidtargetUnit(enemy,25000) then
					local targetFaceXYZ=GetOrigin(enemy)
					if (spellProc.name:find("Attack") and spellProc.BaseName~=nil and spellProc.BaseName:find(GetObjectName(enemy))) then 

						if spellProc.startPos.x==targetFaceXYZ.x and spellProc.startPos.y==targetFaceXYZ.y and spellProc.startPos.z==targetFaceXYZ.z then 
							if spellProc.endPos.x ~=targetFaceXYZ.x and spellProc.endPos.y ~=targetFaceXYZ.y and spellProc.endPos.z ~=targetFaceXYZ.z then 

								lastattackposition={x=spellProc.endPos.x,y=spellProc.endPos.y,z=spellProc.endPos.z,Name=GetObjectName(enemy)}
								break
							else
								break
							end
						else
							break
						end
					else
						break
					end
				else
					break
				end
			end
		end
	end
end)
