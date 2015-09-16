if GetObjectName(myHero) ~= "Xerath" then return end

XerathMenu = Menu("Xerath", "Xerath")
XerathMenu:SubMenu("Combo", "Combo")
XerathMenu.Combo:Boolean("Q", "Use Q", true)
XerathMenu.Combo:Boolean("W", "Use W", true)
XerathMenu.Combo:Boolean("E", "Use E", true)

XerathMenu:SubMenu("Harass", "Harass")
XerathMenu.Harass:Boolean("Q", "Use Q", true)
XerathMenu.Harass:Boolean("W", "Use W", true)
XerathMenu.Harass:Boolean("E", "Use E", true)
XerathMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

XerathMenu:SubMenu("Killsteal", "Killsteal")
XerathMenu.Killsteal:Boolean("W", "Killsteal with W", true)
XerathMenu.Killsteal:Boolean("E", "Killsteal with E", true)

XerathMenu:SubMenu("Misc", "Misc")
XerathMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
XerathMenu.Misc:Boolean("Autolvl", "Auto level", true)
XerathMenu.Misc:Boolean("Interrupt", "Interrupt Spells (E)", true)
XerathMenu.Misc:Boolean("AutoR", "Auto R Killable", true)
XerathMenu.Misc:Key("AutoRKey", "R Killable(hold)", string.byte("T"))

XerathMenu:SubMenu("Drawings", "Drawings")
XerathMenu.Drawings:Boolean("Qmin", "Draw Q Min Range", true)
XerathMenu.Drawings:Boolean("Qmax", "Draw Q Max Range", true)
XerathMenu.Drawings:Boolean("W", "Draw W Range", true)
XerathMenu.Drawings:Boolean("E", "Draw E Range", true)
XerathMenu.Drawings:Boolean("R", "Draw R Range", true)
XerathMenu.Drawings:Boolean("Text", "Draw Text", true)

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
    local myHeroPos = GoS:myHeroPos()	
    local _Qrange = 750 + math.min(700, i/2)
    local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
    local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
    local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
	
    if SpellEREADY and EPred.HitChance == 1 and XerathMenu.Combo.E:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
	
    if SpellWREADY and WPred.HitChance == 1 and XerathMenu.Combo.W:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end		

    if SpellQREADY and GoS:ValidTarget(target, 1500) and XerathMenu.Combo.Q:Value() then
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for m=250, 1500, 250 do
        GoS:DelayAction(function()
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, m)
      end	
    end        
    end

    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= XerathMenu.Harass.Mana:Value() then
    
	local target = GetCurrentTarget()
	local myHeroPos = GoS:myHeroPos()
	local _Qrange = 700 + math.min(700, i/2)
        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
	
    if SpellQREADY and GoS:ValidTarget(target, 1500) and XerathMenu.Harass.Q:Value() then
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for s=250, 1500, 250 do
        GoS:DelayAction(function()
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, s)
      end
    end

    
    if SpellEREADY and EPred.HitChance == 1 and XerathMenu.Harass.E:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
    if SpellWREADY and WPred.HitChance == 1 and XerathMenu.Harass.W:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end	
	
    end

if XerathMenu.Misc.Autolvl:Value() then

if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end

end

    for _,enemy in pairs(GoS:GetEnemyHeroes()) do
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,700,GetCastRange(myHero,_W),125,false,true)
       local EPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,GetCastRange(myHero,_E),60,true,true)
	   
        if Ignite and XerathMenu.Misc.Autoignite:Value() then
          if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
                
       if SpellWREADY and GoS:ValidTarget(enemy,GetCastRange(myHero,_W)) and XerathMenu.Killsteal.W:Value() and WPred.HitChance == 1 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_Q)+ 30 + 0.6*GetBonusAP(myHero)) then
       CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
       elseif SpellEREADY and GoS:ValidTarget(enemy, GetCastRange(myHero, _E)) and XerathMenu.Killsteal.E:Value() and EPred.HitChance == 1 and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_E)+ 50 + 0.45*GetBonusAP(myHero)) then  
       CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
       end
    end

if XerathMenu.Drawings.Qmin:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,750,3,100,0xff00ff00) end
if XerathMenu.Drawings.Qmax:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1500,3,100,0xff00ff00) end
if XerathMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if XerathMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if XerathMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
 if XerathMenu.Drawings.Text:Value() then
	for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy) then
		    local enemyPos = GetOrigin(enemy)
		    local drawpos = WorldToScreen(1,enemyPos.x, enemyPos.y, enemyPos.z)
		    local enemyText, color = GetDrawText(enemy)
		    DrawText(enemyText, 20, drawpos.x, drawpos.y, color)
		end
	end
 end

        local waitTickCount = GetTickCount() + 1400
        local target = GetCurrentTarget()
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,800 + 1050*GetCastLevel(myHero,_R),120,false,true)
	
	local ExtraDmg = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	end
	
  if waitTickCount < GetTickCount() then
	
    if SpellRREADY and RPred.HitChance == 1 and GoS:ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and GetCurrentHP(target)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero) + ExtraDmg) then
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	GoS:DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	GoS:DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
    elseif SpellRREADY and RPred.HitChance == 1 and GoS:ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and XerathMenu.Misc.AutoRKey:Value() and GetCurrentHP(target)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero) + ExtraDmg) then
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	GoS:DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	GoS:DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
    end
  end

SpellQREADY = CanUseSpell(myHero,_Q) == READY
SpellWREADY = CanUseSpell(myHero,_W) == READY
SpellEREADY = CanUseSpell(myHero,_E) == READY
SpellRREADY = CanUseSpell(myHero,_R) == READY
SpellIREADY = CanUseSpell(myHero,Ignite) == READY

end)

function GetDrawText(enemy)
	
	local ExtraDmg = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	end
	
	if SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero) + ExtraDmg) then
	return '1R = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 2*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg) then
	return '2R = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 3*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg) then
	return '3R = Kill!', ARGB(255, 200, 160, 0)
	end
	
end

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
  if GoS:IsInDistance(target, GetCastRange(myHero,_E)) and SpellEREADY and EPred.HitChance == 1 and Xerath.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)
