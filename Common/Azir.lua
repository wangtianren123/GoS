require('Dlib')

local version = 1
local UP=Updater.new("D3ftsu/GoS/master/Common/Azir.lua", "Common\\Azir", version)
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

myIAC = IAC()

local root = menu.addItem(SubMenu.new("Azir"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseAA = Combo.addItem(MenuBool.new("Use AA",true))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseW = Combo.addItem(MenuBool.new("Use W",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(MenuBool.new("Use R",true))
local Escape = Combo.addItem(MenuKeyBind.new("Escape", 71))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseAA = Harass.addItem(MenuBool.new("Use AA", true))
local HUseQ = Harass.addItem(MenuBool.new("Use Q", true))
local HUseW = Harass.addItem(MenuBool.new("Use W", true))

local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscInterrupt = Misc.addItem(MenuBool.new("Interrupt", true))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsW = Drawings.addItem(MenuBool.new("Draw W Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))

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

AzirSoldiers = {}

OnLoop(function(myHero)
  if IWalkConfig.Combo then
	local target = GetCurrentTarget()
	
	    local SoldierRange = 0
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,0,950,80,false,true)
	    local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,0,600,100,false,true)
	    local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,500,950,700,false,true)
		
	    for i = 1, #AzirSoldiers do 
	           if ValidTarget(target, 1500) and table.getn(AzirSoldiers) > 0 then
		   SoldierRange = GetDistance(AzirSoldiers[i], target)
		   end
		
		   if CanUseSpell(myHero,_E) and ValidTarget(target, 1300) and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and CUseE.getValue() then 
		   CastSpell(_E)
		   end
		   
		   if CanUseSpell(myHero,_Q) and SoldierRange > 400 and ValidTarget(target, 950) and QPred.HitChance == 1 and CUseQ.getValue() then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if ValidTarget(target, 1500) and GetDistance(target) > 550 and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and CUseAA.getValue() then
		   AttackUnit(target)
		   end
	    end
	
		if CanUseSpell(myHero,_W) == READY and ValidTarget(target,500) and WPred.HitChance == 1 and CUseW.getValue() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if ValidTarget(target, 1500) and table.getn(AzirSoldiers) < 1 and QPred.HitChance == 1 and CUseW.getValue() then
		CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	
  end
	
	if IWalkConfig.Harass then
	local target = GetCurrentTarget()
	    
		local SoldierRange = 0
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,0,950,80,false,true)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,0,600,100,false,true)
		
	    for i = 1, #AzirSoldiers do 
	           if ValidTarget(target, 1500) and table.getn(AzirSoldiers) > 0 then
		   SoldierRange = GetDistance(AzirSoldiers[i], target)
		   end
		   
		   if CanUseSpell(myHero,_Q) and GetDistance(target) > 400 and ValidTarget(target, 950) and QPred.HitChance == 1 and HUseQ.getValue() then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
	    end
		
		if ValidTarget(target, 1500) and GetDistance(target) > 550 and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and HUseAA.getValue() then
		AttackUnit(target)
		end
		
		if CanUseSpell(myHero,_W) == READY and ValidTarget(target,500) and WPred.HitChance == 1 and HUseW.getValue() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if ValidTarget(target, 1500) and table.getn(AzirSoldiers) < 1 and QPred.HitChance == 1 and HUseW.getValue() then
		CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,0,950,80,false,true)

		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy, 950) and KSQ.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20*GetCastLevel(myHero,_Q)+45+.5*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
	end
	
	if Escape.getValue() then
	local mousePos = GetMousePos()
	
	        if table.getn(AzirSoldiers) < 1 then CastSkillShot(_W, mousePos.x, mousePos.y, mousePos.z) end
		if CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) == READY then
		CastSkillShot(_Q, mousePos.x, mousePos.y, mousePos.z)
		CastSpell(_E)
		elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY then
		CastSpell(_E)
		else 
		MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
		end
	end
	
if MiscEnableAutolvl.getValue() then  

if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_Q)
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
        LevelSpell(_W)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_Q)
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

local HeroPos = GetOrigin(myHero)
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if DrawingsW.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end

end)

OnCreateObj(function(Object) 
if GetObjectBaseName(Object) == "AzirSoldier" then
table.insert(AzirSoldiers, Object)
end
end)

OnDeleteObj(function(Object) 
if GetObjectBaseName(Object) == "Azir_Base_P_Soldier_Ring.troy" then
table.remove(AzirSoldiers, 1)
end
end)

addInterrupterCallback(function(target, spellType)
  local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,500,950,700,false,true)
  if IsInDistance(target, 450) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS and MiscInterrupt.getValue() then
  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

AddGapcloseEvent(_R, 450, false)

notification("Azir by Deftsu loaded.", 10000)
