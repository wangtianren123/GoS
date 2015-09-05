require('Dlib')

local version = 5
local UP=Updater.new("D3ftsu/GoS/master/Common/Blitzcrank.lua", "Common\\Blitzcrank", version)
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

local root = menu.addItem(SubMenu.new("Blitzcrank"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseW = Combo.addItem(MenuBool.new("Use W",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(MenuBool.new("Use R",true))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
local HUseE = Harass.addItem(MenuBool.new("Use E",true))
local HMmana = Harass.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 1))

local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", false))
local KSR = KSmenu.addItem(MenuBool.new("Killsteal with R", false))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscInterrupt = Misc.addItem(MenuBool.new("Interrupt", true))

local JungleSteal = root.addItem(SubMenu.new("Baron/Drake Steal"))
local JUseQ = JungleSteal.addItem(MenuBool.new("Use Q",true))
local JUseR = JungleSteal.addItem(MenuBool.new("Use R",true))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))

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
	              	
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,550,1000,80,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1000) and CUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	    end
                          
        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 800) and GetDistance(myHero, target) > 200 and CUseW.getValue() then
        CastSpell(_W)
		end
			
        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 250) and CUseE.getValue() then
        CastSpell(_E)
		end
		              
		if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 600) and CUseR.getValue() then
        CastSpell(_R)
	    end
	                      
	end	
	
	if IWalkConfig.Harass and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 >= HMmana.getValue() then
	local target = GetCurrentTarget()
		
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,550,1000,80,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1000) and HUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	    end
		
		if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 250) and HUseE.getValue() then
        CastSpell(_E)
		end
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1800,550,1000,80,true,true)
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
  	    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy, 1000) and KSQ.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero) + ExtraDmg) then 
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        elseif CanUseSpell(myHero, _R) == READY and ValidTarget(enemy, 600) and KSR.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero) + ExtraDmg) then
        CastSpell(_R)
	    end
	end
	
if MiscEnableAutolvl.getValue() then  
local leveltable = { _Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Credits goes to Inferno for saving me 20 line xD
LevelSpell(leveltable[GetLevel(myHero)]) 
end

for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
	local mobPos = GetOrigin(mob)
	
    local ExtraDmg = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	end	
	
	if GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron" then
	  if CanUseSpell(myHero, _Q) == READY and JUseQ.getValue() and ValidTarget(mob, 1000) and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, 55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero) + ExtraDmg) then
	  CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
	  end
		
	  if CanUseSpell(myHero, _R) == READY and JUseR.getValue() and ValidTarget(mob, 600) and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, 125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero) + ExtraDmg) then
	  CastSpell(_R)
          end
        end
end

local HeroPos = GetOrigin(myHero)		
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,1000,3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,600,3,100,0xff00ff00) end
end)

addInterrupterCallback(function(target, spellType)
local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1500,250,975,100,true,true)
  if IsInDistance(target, 1000) and CanUseSpell(myHero,_Q) == READY and MiscInterrupt.getValue() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
  elseif IsInDistance(target, 600) and CanUseSpell(myHero,_R) == READY and MiscInterrupt.getValue() and spellType == CHANELLING_SPELLS then
  CastSpell(_R)
  end
end)

AddGapcloseEvent(_Q, 1000, false)

notification("Blitzcrank by Deftsu loaded.", 10000)
