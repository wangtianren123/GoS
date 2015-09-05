require('Dlib')

local version = 3
local UP=Updater.new("D3ftsu/GoS/master/Common/Ahri.lua", "Common\\Ahri", version)
if UP.newVersion() then UP.update() end

--------------- Thanks ilovesona for this ------------------------
DelayAction(function ()
        for _, imenu in pairs(menuTable) do
                local submenu = menu.addItem(SubMenu.new(imenu.name))
                for _,subImenu in pairs(imenu) do
                        if subImenu.type == SCRIPT_PARAM_ONOFF then
                                local ggeasy = submenu.addItem(MenuBool.new(subImenu.t, subImenu.value))
                                OnLoop(function(myHero) subImenu.value = ggeasy.getValue() end)
                        elseif subImenu.type == SCRIPT_PARAM_KEYDOWN then
                                local ggeasy = submenu.addItem(MenuKeyBind.new(subImenu.t, subImenu.key))
                                OnLoop(function(myHero) subImenu.key = ggeasy.getValue(true) end)
                        elseif subImenu.type == SCRIPT_PARAM_INFO then
                                submenu.addItem(MenuSeparator.new(subImenu.t))
                        end
                end
        end
        _G.DrawMenu = function ( ... )  end
end, 1000)

local root = menu.addItem(SubMenu.new("Ahri"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseW = Combo.addItem(MenuBool.new("Use W",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(MenuBool.new("Use R",true))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
local HUseW = Harass.addItem(MenuBool.new("Use W",true))
local HUseE = Harass.addItem(MenuBool.new("Use E",true))
local HMmana = Harass.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 5))

local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))
local KSW = KSmenu.addItem(MenuBool.new("Killsteal with W", true))
local KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", true))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscInterrupt = Misc.addItem(MenuBool.new("Interrupt", true))

local JungleClear = root.addItem(SubMenu.new("JungleClear"))
local JUseQ = JungleClear.addItem(MenuBool.new("Use Q",true))
local JUseW = JungleClear.addItem(MenuBool.new("Use W",true))
local JUseE = JungleClear.addItem(MenuBool.new("Use E",false))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsW = Drawings.addItem(MenuBool.new("Draw W Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))
local DrawingsText = Drawings.addItem(MenuBool.new("Draw Text", true))

myIAC = IAC()

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
    if IWalkConfig.Combo then
	local target = GetCurrentTarget()
	    
		local mousePos = GetMousePos()
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,880,90,false,true)
		local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1500,250,975,100,true,true)
		
        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 975) and EPred.HitChance == 1 and CUseE.getValue() then
        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end
					
		if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 1000) and CUseR.getValue() and (GetCurrentHP(target)/GetMaxHP(target))*100 < 50 then
		CastSkillShot(_R,mousePos.x,mousePos.y,mousePos.z)
		end
				
		if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 550) and CUseW.getValue() then
		CastSpell(_W)
		end
		
	    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 880) and QPred.HitChance == 1 and CUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
					
	end
	
	if IWalkConfig.Harass and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 >= HMmana.getValue() then
	local target = GetCurrentTarget()
		
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,880,90,false,true)
		local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1500,250,975,100,true,true)
		
        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 975) and EPred.HitChance == 1 and HUseE.getValue() then
        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end
				
		if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 550) and HUseW.getValue() then
		CastSpell(_W)
		end
		
	    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 880) and QPred.HitChance == 1 and HUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,880,90,false,true)
		local EPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1500,250,975,60,true,true)
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		if CanUseSpell(myHero, _W) and ValidTarget(enemy, 550) and KSW.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy, 880) and KSQ.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _E) and EPred.HitChance == 1 and ValidTarget(enemy, 975) and KSE.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
	end
	
if MiscEnableAutolvl.getValue() then  
local leveltable = { _Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Credits goes to Inferno for saving me 20 line xD
LevelSpell(leveltable[GetLevel(myHero)]) 
end

for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
		
    if IWalkConfig.LaneClear then
		local mobPos = GetOrigin(mob)
		
		if CanUseSpell(myHero, _Q) == READY and JUseQ.getValue() and ValidTarget(mob, 880) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and JUseW.getValue() and ValidTarget(mob, 550) then
		CastSpell(_W)
		end
		
	    if CanUseSpell(myHero, _E) == READY and JUseE.getValue() and ValidTarget(mob, 975) then
		CastSkillShot(_E,mobPos.x, mobPos.y, mobPos.z)
		end
		
	end
end

if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,880,3,100,0xff00ff00) end
if DrawingsW.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,975,3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end
if DrawingsText.getValue() then
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
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
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W + Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E + W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + E = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < ExtraDmg + CalcDamage(myHero, enemy, 0, 30 + 50*GetCastLevel(myHero,_Q) + 0.70*GetBonusAP(myHero) + 24 + 40*GetCastLevel(myHero,_W) + 0.64*GetBonusAP(myHero) + 35*GetCastLevel(myHero,_E) + 25 + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end

addInterrupterCallback(function(target, spellType)
local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1500,250,975,100,true,true)
  if IsInDistance(target, 975) and CanUseSpell(myHero,_E) == READY and MiscInterrupt.getValue() and spellType == CHANELLING_SPELLS then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)

AddGapcloseEvent(_E, 975, false)

notification("Ahri by Deftsu loaded.", 10000)
