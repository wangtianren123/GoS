require('Dlib')

local version = 2
local UP=Updater.new("D3ftsu/GoS/master/Common/Thresh.lua", "Common\\Thresh", version)
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

local root = menu.addItem(SubMenu.new("Thresh"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseQ2 = Combo.addItem(MenuBool.new("Jump to Target",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(MenuBool.new("Use R",true))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
local HUseE = Harass.addItem(MenuBool.new("Use E",true))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local AutoLantern = Misc.addItem(MenuKeyBind.new("Auto Lantern", 71))
local AutoR = Misc.addItem(SubMenu.new("Auto R", true))
local AutoREnabled = AutoR.addItem(SubMenu.new("Enabled", true))
local AutoRmin = AutoR.addItem(MenuSlider.new("Minimum Enemies in Range", 3, 1, 5, 1))
local MiscInterrupt = Misc.addItem(SubMenu.new("Interrupt"))
local InterruptQ = MiscInterrupt.addItem(MenuBool.new("Interrupt with Q", true))
local InterruptE = MiscInterrupt.addItem(MenuBool.new("Interrupt with E", true))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsW = Drawings.addItem(MenuBool.new("Draw W Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))

myIAC = IAC()

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
    if IWalkConfig.Combo then
	local target = GetCurrentTarget()
		    
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
		local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
				
        if GetCastName(myHero, _Q) ~= "threshqleap" and CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1100) and CUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif GetCastName(myHero, _Q) == "threshqleap" and CUseQ2.getValue() then
        CastSpell(_Q)
        end
			
		local xPos = GetOrigin(myHero).x + (GetOrigin(myHero).x - EPred.PredPos.x)
		local yPos = GetOrigin(myHero).y + (GetOrigin(myHero).y - EPred.PredPos.y)
		local zPos = GetOrigin(myHero).z + (GetOrigin(myHero).z - EPred.PredPos.z)
			
		if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and CUseE.getValue() and ValidTarget(target, 400) and GetCurrentHP(myHero)/GetMaxHP(myHero) >= 0.26 then
		CastSkillShot(_E, xPos, yPos, zPos)
		elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and CUseE.getValue() and ValidTarget(target, 400) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.26 then
        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end				
           
		if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 450) and CUseR.getValue() and GetCurrentHP(target)/GetMaxHP(target) < 0.5 then
		CastSpell(_R)
		end
    end
		
	if IWalkConfig.Harass then 
	local target = GetCurrentTarget()
	
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
		local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
				
        if GetCastName(myHero, _Q) ~= "threshqleap" and CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1100) and HUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		local xPos = GetOrigin(myHero).x + (GetOrigin(myHero).x - EPred.PredPos.x)
		local yPos = GetOrigin(myHero).y + (GetOrigin(myHero).y - EPred.PredPos.y)
		local zPos = GetOrigin(myHero).z + (GetOrigin(myHero).z - EPred.PredPos.z)
			
		if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and HUseE.getValue() and ValidTarget(target, 400) then
		CastSkillShot(_E, xPos, yPos, zPos)
		end
	end
	
    if AutoR.getValue() and CanUseSpell(myHero,_R) and EnemiesAround(GetMyHeroPos(), 450) >= AutoRmin.getValue() then
	CastSpell(_R)
	end
	
	if AutoLantern.getValue() then
	  for _, ally in pairs(GetAllyHeroes()) do
      local WPred = GetPredictionForPlayer(GetMyHeroPos(),ally,GetMoveSpeed(ally),math.huge,250,950,90,false,true)
      local AllyPos = GetOrigin(ally)
      local mousePos = GetMousePos()
        if CanUseSpell(myHero,_W) and IsObjectAlive(ally) and GetDistance(myHero, ally) < 950 then
        CastSkillShot(_W,WPred.PredPos.x, WPred.PredPos.y, WPred.PredPos.z)
	    else
	    MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
	    end
      end
	end

if MiscEnableAutolvl.getValue() then  
local leveltable = { _Q, _E, _W, _E, _E, _R, _Q, _Q, _Q, _E, _R, _Q, _E, _W, _W, _R, _W, _W} -- Credits goes to Inferno for saving me 20 line xD
LevelSpell(leveltable[GetLevel(myHero)]) 
end

local HeroPos = GetOrigin(myHero)
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,1100,3,100,0xff00ff00) end
if DrawingsW.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,950,3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,400,3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,450,3,100,0xff00ff00) end
end)

addInterrupterCallback(function(target, spellType)
local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,1100,70,true,true)
local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,400,200,false,true)
  if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and EPred.HitChance == 1 and InterruptE.getValue() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  elseif IsInDistance(target, GetCastRange(myHero,_Q)) and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 and InterruptQ.getValue() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
  end
end)

AddGapcloseEvent(_E, 400, false)


notification("Thresh by Deftsu loaded.", 10000)
