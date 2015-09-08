AhriMenu = Menu("Ahri", "Ahri")
AhriMenu:SubMenu("Combo", "Combo")
AhriMenu.Combo:Boolean("Q", "Use Q", true)
AhriMenu.Combo:Boolean("W", "Use W", true)
AhriMenu.Combo:Boolean("E", "Use E", true)
AhriMenu.Combo:Boolean("R", "Use R", true)

AhriMenu:SubMenu("Harass", "Harass")
AhriMenu.Harass:Boolean("Q", "Use Q", true)
AhriMenu.Harass:Boolean("W", "Use W", true)
AhriMenu.Harass:Boolean("E", "Use E", true)
AhriMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

AhriMenu:SubMenu("Killsteal", "Killsteal")
AhriMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
AhriMenu.Killsteal:Boolean("W", "Killsteal with W", true)
AhriMenu.Killsteal:Boolean("E", "Killsteal with E", false)

AhriMenu:SubMenu("Misc", "Misc")
AhriMenu.Misc:Boolean("Autolvl", "Auto level", false)
AhriMenu.Misc:Boolean("Interrupt", "Interrupt Spells (E)", true)

AhriMenu:SubMenu("JungleClear", "JungleClear")
AhriMenu.JungleClear:Boolean("Q", "Use Q", true)
AhriMenu.JungleClear:Boolean("W", "Use W", true)
AhriMenu.JungleClear:Boolean("E", "Use E", true)

AhriMenu:SubMenu("Drawings", "Drawings")
AhriMenu.Drawings:Boolean("Q", "Draw Q Range", true)
AhriMenu.Drawings:Boolean("W", "Draw W Range", true)
AhriMenu.Drawings:Boolean("E", "Draw E Range", true)
AhriMenu.Drawings:Boolean("R", "Draw R Range", true)
AhriMenu.Drawings:Boolean("Text", "Draw Text", true)

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
		        local mousePos = GetMousePos()
	                local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,880,50,false,true)
		        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1550,250,1000,60,true,true)
		
                        if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and EPred.HitChance == 1 and AhriMenu.Combo.E:Value() then
                        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                        end
					
		        if CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 900) and AhriMenu.Combo.R:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 then
		        CastSkillShot(_R,mousePos.x,mousePos.y,mousePos.z)
		        end
				
		        if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 700) and AhriMenu.Combo.W:Value() then
		        CastSpell(_W)
		        end
		
	                if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 880) and QPred.HitChance == 1 and AhriMenu.Combo.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
					
    end
	
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AhriMenu.Harass.Mana:Value() then
	
                        local target = GetCurrentTarget()
		        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,880,50,false,true)
		        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1550,250,1000,60,true,true)
		
                        if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and EPred.HitChance == 1 and AhriMenu.Harass.E:Value() then
                        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                        end
				
		        if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 700) and AhriMenu.Harass.W:Value() then
		        CastSpell(_W)
		        end
		
	                if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 880) and QPred.HitChance == 1 and AhriMenu.Harass.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
		
    end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		
	        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,880,50,false,true)
		local EPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1550,250,1000,60,true,true)
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if CanUseSpell(myHero, _W) and GoS:ValidTarget(enemy, 700) and AhriMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 880) and AhriMenu.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _E) and EPred.HitChance == 1 and GoS:ValidTarget(enemy, 975) and AhriMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
	end
	
	end
	
if AhriMenu.Misc.Autolvl:Value() then  

if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end

end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
        if IOW:Mode() == "LaneClear" then
		local mobPos = GetOrigin(mob)
		
		if CanUseSpell(myHero, _Q) == READY and AhriMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 880) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and AhriMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 700) then
		CastSpell(_W)
		end
		
	        if CanUseSpell(myHero, _E) == READY and AhriMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 975) then
		CastSkillShot(_E,mobPos.x, mobPos.y, mobPos.z)
		end
		
        end
end

if AhriMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,880,3,100,0xff00ff00) end
if AhriMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,550,3,100,0xff00ff00) end
if AhriMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,975,3,100,0xff00ff00) end
if AhriMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,550,3,100,0xff00ff00) end
if AhriMenu.Drawings.Text:Value() then
	for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy) then
		    local enemyPos = GetOrigin(enemy)
		    local drawpos = WorldToScreen(1,enemyPos.x, enemyPos.y, enemyPos.z)
		    local enemyText, color = GetDrawText(enemy)
		    DrawText(enemyText, 20, drawpos.x, drawpos.y, color)
		end
	end
end
end)

function GetDrawText(enemy)
	local ExtraDmg = 0
	--if Ignite and CanUseSpell(myHero, Ignite) == READY then
	--ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	--end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + ExtraDmg2) then
	return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg2) then
	return 'W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
	return 'E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg2) then
	return 'W + Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
	return 'E + W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
	return 'Q + W + E = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < ExtraDmg + GoS:CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
	return 'Q + W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	else
	return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1500,250,1000,100,true,true)
  if GoS:IsInDistance(target, 1000) and CanUseSpell(myHero,_E) == READY and AhriMenu.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)
