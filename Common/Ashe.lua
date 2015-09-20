if GetObjectName(myHero) ~= "Ashe" then return end

AsheMenu = Menu("Ashe", "Ashe")
AsheMenu:SubMenu("Combo", "Combo")
AsheMenu.Combo:Boolean("Q", "Use Q", true)
AsheMenu.Combo:Boolean("W", "Use W", true)
AsheMenu.Combo:Boolean("R", "Use R", true)
AsheMenu.Combo:Boolean("Items", "Use Items", true)
AsheMenu.Combo:Boolean("QSS", "Use QSS", true)
AsheMenu.Combo:Slider("QSSHP", "if HP % <", 75, 0, 100, 1)

AsheMenu:SubMenu("Harass", "Harass")
AsheMenu.Harass:Boolean("Q", "Use Q", true)
AsheMenu.Harass:Boolean("W", "Use W", true)
AsheMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

AsheMenu:SubMenu("Killsteal", "Killsteal")
AsheMenu.Killsteal:Boolean("W", "Killsteal with W", true)
AsheMenu.Killsteal:Boolean("R", "Killsteal with R", false)

AsheMenu:SubMenu("Misc", "Misc")
AsheMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
AsheMenu.Misc:Boolean("Autolvl", "Auto level", false)
AsheMenu.Misc:Boolean("Interrupt", "Interrupt Dangerous Spells with E", true)

AsheMenu:SubMenu("Drawings", "Drawings")
AsheMenu.Drawings:Boolean("W", "Draw W Range", true)

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
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,1200,50,true,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
		
	if SpellQREADY and GotBuff(myHero, "asheqcastready") > 0 and GoS:ValidTarget(target, 700) and AsheMenu.Combo.Q:Value() then
        CastSpell(_Q)
        end
						
        if SpellWREADY and WPred.HitChance == 1 and GoS:ValidTarget(target, 1200) and AsheMenu.Combo.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
						
        if SpellRREADY and RPred.HitChance == 1 and GoS:ValidTarget(target, 2000) and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 and AsheMenu.Combo.R:Value() then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	end
		
	if GetItemSlot(myHero,3153) > 0 and AsheMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and AsheMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and AsheMenu.Combo.Items:Value() and GoS:ValidTarget(target, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and AsheMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < AsheMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and AsheMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < AsheMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
    end

    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= AsheMenu.Harass.Mana:Value() then 
    
        local target = GetCurrentTarget()
        local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,1200,50,true,true)	
		
	if SpellQREADY and GotBuff(myHero, "asheqcastready") > 0 and GoS:ValidTarget(target, 700) and AsheMenu.Harass.Q:Value() then
        CastSpell(_Q)
        end
						
        if SpellWREADY and WPred.HitChance == 1 and GoS:ValidTarget(target, 1200) and AsheMenu.Harass.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	end
		
    end

    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2000,250,1200,50,true,true)
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,3000,130,false,true)
		
	if Ignite and AsheMenu.Misc.Autoignite:Value() then
          if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
	end
	
	if SpellWREADY and WPred.HitChance == 1 and GoS:ValidTarget(enemy, 1200) and AsheMenu.Killsteal.W:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 15*GetCastLevel(myHero,_W)+5+GetBaseDamage(myHero), 0) then 
	CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	end
		  
	if SpellRREADY and RPred.HitChance == 1 and GoS:ValidTarget(enemy, 3000) and AsheMenu.Killsteal.R:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 175*GetCastLevel(myHero,_R) + 75 + GetBonusAP(myHero)) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	end
		
    end

if AsheMenu.Misc.Autolvl:Value() then  
local leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} 
LevelSpell(leveltable[GetLevel(myHero)])
end

if AsheMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end

SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY

end)

addInterrupterCallback(function(target, spellType)
  local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,1000,130,false,true)
  if GoS:IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)
