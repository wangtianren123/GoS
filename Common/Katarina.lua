require('Dlib')

local version = 3
local UP=Updater.new("D3ftsu/GoS/master/Common/Katarina.lua", "Common\\Katarina", version)
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


local root = menu.addItem(SubMenu.new("Katarina"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseW = Combo.addItem(MenuBool.new("Use W",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(MenuBool.new("Use R",true))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
local HUseW = Harass.addItem(MenuBool.new("Use W",true))
local HUseE = Harass.addItem(MenuBool.new("Use E",true))
local HAutoQ = Harass.addItem(MenuBool.new("Auto Q",false))
local HAutoW = Harass.addItem(MenuBool.new("Auto W",true))

local KillSteal = root.addItem(SubMenu.new("KillSteal"))
local SmartKS = KillSteal.addItem(MenuBool.new("Smart KS", true))
local UseWards = KillSteal.addItem(MenuBool.new("Use Wards", true))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local WardJumpkey = Misc.addItem(MenuKeyBind.new("WardJump", 71))

local Farm = root.addItem(SubMenu.new("Farm"))
local XUseQ = Farm.addItem(MenuBool.new("LastHit with Q", false))
local XUseW = Farm.addItem(MenuBool.new("Lasthit with W", false))
local XUseE = Farm.addItem(MenuBool.new("Lasthit with E", false))
local LaneClear = Farm.addItem(SubMenu.new("LaneClear"))
local LCUseQ = LaneClear.addItem(MenuBool.new("Clear with Q", false))
local LCUseW = LaneClear.addItem(MenuBool.new("Clear with W", false))
local LCUseE = LaneClear.addItem(MenuBool.new("Clear with E", false))

local JungleClear = root.addItem(SubMenu.new("JungleClear"))
local JUseQ = JungleClear.addItem(MenuBool.new("Use Q",true))
local JUseW = JungleClear.addItem(MenuBool.new("Use W",true))
local JUseE = JungleClear.addItem(MenuBool.new("Use E",true))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsW = Drawings.addItem(MenuBool.new("Draw W Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))
local DrawingsText = Drawings.addItem(MenuBool.new("Draw Text", true))

myIAC = IAC()

local spellList = { Katarina = _E }
local myHero = GetMyHero()
local spellSlot = spellList[ GetObjectName(myHero) ]

if not spellSlot then return end

local GetOrigin = GetOrigin
local GetObjectName = GetObjectName
local GetObjectType = GetObjectType

local wardRange = 600
local jumpTarget
local wardLock
local mousePos
local wardpos
local maxPos 
local spellObj
local objectList = {}

local wardItems = {        
        { id = 3340, spellName = "TrinketTotemLvl1"},
        { id = 3350, spellName = "TrinketTotemLvl2"},
        { id = 3361, spellName = "TrinketTotemLvl3"},
        { id = 3362, spellName = "TrinketTotemLvl3B"},
        { id = 2045, spellName = "ItemGhostWard"},
        { id = 2049, spellName = "ItemGhostWard"},
        { id = 2050, spellName = "ItemMiniWard"},
        { id = 2044, spellName = "sightward"},
        { id = 2043, spellName = "VisionWard"}
}

local function GetDistanceSqr(p1,p2)
    p2 = p2 or GetOrigin(myHero)
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
end

local function IsInDistance(r, p1, p2, fast)
		local fast = fast or false

		if fast then

			local p1y = p1.z or p1.y
			local p2y = p2.z or p2.y
			return (p1.x + r >= p2.x) and (p1.x - r <= p2.x) and (p1y + r >= p2y) and (p1y - r <= p2y)
		else
    	return GetDistanceSqr(p1, p2) < r*r
    end
end

local function calcMaxPos(pos)
	local origin = GetOrigin(myHero)
	local vectorx = pos.x-origin.x
	local vectory = pos.y-origin.y
	local vectorz = pos.z-origin.z
	local dist= math.sqrt(vectorx^2+vectory^2+vectorz^2)
	return {x = origin.x + wardRange * vectorx / dist ,y = origin.y + wardRange * vectory / dist, z = origin.z + wardRange * vectorz / dist}
end

local function validTarget( object )
	local objType = GetObjectType(object)
		
	if GetObjectName(myHero) == "LeeSin" then
		return (objType == Obj_AI_Hero or objType == Obj_AI_Minion) and IsVisible(object) and GetTeam(object) == GetTeam(myHero)
	else		
		return (objType == Obj_AI_Hero or objType == Obj_AI_Minion) and IsVisible(object)
	end
end

local findWardSlot = function ()
	local slot = 0
	for i,wardItem in pairs(wardItems) do
		slot = GetItemSlot(myHero,wardItem.id)
		if slot > 0 and CanUseSpell(myHero, slot) == READY then return slot end
	end
end

local function putWard(pos0)	
	local slot = findWardSlot()

	local pos = pos0
	if not IsInDistance(wardRange, pos) then
		pos = calcMaxPos(pos)
	end

	if slot and slot > 0 then
		CastSkillShot(slot,pos.x,pos.y,pos.z)
	end
end

local spellLock = nil

function wardJump( pos )
	if not spellLock and CanUseSpell(myHero, spellSlot) == READY then
		if jumpTarget then
			CastTargetSpell(jumpTarget, spellSlot)
			spellLock = GetTickCount()
		elseif not wardLock then
			wardLock = GetTickCount()
			putWard(pos)
		end
	end
end

local function GetJumpTarget()
	local pos = mousePos
	if not IsInDistance(wardRange, mousePos, GetOrigin(myHero)) then
		pos = maxPos
	end
	for _,object in pairs(objectList) do
	  if validTarget(object) and IsInDistance(200, GetOrigin(object), pos) then
	   	return object
	  end
	end
	return nil
end

OnProcessSpell(function(unit,spell)

	if unit and unit == myHero and spell and not spell.name:lower():find("katarina") then
		spellObj = spell
		wardpos = spellObj.endPos
	end
end)

OnCreateObj(function(object)
	local objType = GetObjectType(object)
	if objType == Obj_AI_Hero or objType == Obj_AI_Minion then
		objectList[object] = object
	end
end)

OnDeleteObj(function(Object)
	local objType = GetObjectType(object)
	if objType == Obj_AI_Hero or objType == Obj_AI_Minion then
		objectList[object] = nil
	end
end)

OnLoop(function(myHero)

    mousePos = GetMousePos()
	maxPos = calcMaxPos(mousePos)

	jumpTarget = GetJumpTarget()


	if not spellLock and wardLock and jumpTarget and CanUseSpell(myHero, spellSlot) == READY then
		CastTargetSpell(jumpTarget, spellSlot)
		spellLock = GetTickCount()
	end

	if WardJumpkey.getValue() then
		wardJump(mousePos)
	end

	
	if wardLock and (wardLock + 500) < GetTickCount()  then
		wardLock = nil
	end

	
	if spellLock and (spellLock + 500) < GetTickCount()  then
		spellLock = nil
	end

	jumpTarget = nil
	spellObj = nil
	wardpos = nil
  
  if GotBuff(myHero,"katarinarsound") > 0 then
  myIAC:SetOrb(false)
  else 
  myIAC:SetOrb(true) 
  end
	
  if IWalkConfig.Combo then
      local target = GetCurrentTarget()
	  
      if CanUseSpell(myHero, _Q) == READY and CUseQ.getValue() and ValidTarget(target, GetCastRange(myHero, _Q)) then
      CastTargetSpell(target, _Q)
	  end
	  
      if CanUseSpell(myHero, _W) == READY and CUseW.getValue() and ValidTarget(target, GetCastRange(myHero, _W)) then
      CastSpell(_W)
	  end
	  
      if CanUseSpell(myHero, _E) == READY and CUseE.getValue() and ValidTarget(target, GetCastRange(myHero, _E)) then
      CastTargetSpell(target, _E)
	  end
	  
      if CUseR.getValue() and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R)  ~= ONCOOLDOWN and ValidTarget(target, 550) and GetCastLevel(myHero,_R) > 0 then
      CastSpell(_R)
      end
  end

  if IWalkConfig.Harass then
      local target = GetCurrentTarget()
	  
      if CanUseSpell(myHero, _Q) == READY and HUseQ.getValue() and ValidTarget(target, 675) then
      CastTargetSpell(target, _Q)
	  end
	  
      if CanUseSpell(myHero, _W) == READY and HUseW.getValue() and ValidTarget(target, 375) then
      CastSpell(_W)
	  end
	  
      if CanUseSpell(myHero, _E) == READY and HUseE.getValue() and ValidTarget(target, 700) then
      CastTargetSpell(target, _E)
      end
  end

local target = GetCurrentTarget()

if HAutoQ.getValue() and ValidTarget(target, 675) and GotBuff(myHero, "katarinarsound") < 1 then
CastTargetSpell(target, _Q)
end

if HAutoW.getValue() and ValidTarget(target, 375) and GotBuff(myHero, "katarinarsound") < 1 then
CastSpell(_W)
end

    for i,enemy in pairs(GetEnemyHeroes()) do
       if SmartKS.getValue() then
	   
                local ExtraDmg = 0
		        if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		        ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		        end
		
                if CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero)) and ValidTarget(enemy, 375) then 
				CastSpell(_W)
				
				elseif CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) and ValidTarget(enemy, 675) then 
				CastTargetSpell(enemy, _Q)
				
				elseif CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) and ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) and ValidTarget(enemy, 375) then 
				CastSpell(_W)
				CastTargetSpell(enemy, _Q)
		
				elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) and ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				CastSpell(_W)
				
				elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) and ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				CastTargetSpell(enemy, _Q)
				CastSpell(_W)
				end
				
	            if UseWards.getValue() and GetDistance(enemy) < 1275 and GetDistance(enemy) > 700  and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) then
			    wardJump(GetOrigin(enemy))
		        CastTargetSpell(enemy, _Q)
	            end
				
		end
	end

if MiscEnableAutolvl.getValue() then  
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

for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end

    if IWalkConfig.LaneClear then
		if CanUseSpell(myHero, _Q) == READY and LCUseQ.getValue() and ValidTarget(minion, 675) then
		CastTargetSpell(minion, _Q)
		end
		
		if CanUseSpell(myHero, _W) == READY and LCUseW.getValue() and ValidTarget(minion, 375) then
		CastSpell(_W)
		end
		
		if CanUseSpell(myHero, _E) == READY and LCUseE.getValue() and ValidTarget(minion, 700) then
		CastTargetSpell(minion, _E)
		end
	end
	
	if IWalkConfig.LastHit then 
		
	    if CanUseSpell(myHero, _W) == READY and XUseW.getValue() and ValidTarget(minion, 375) and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) then
		CastSpell(_W)
		elseif CanUseSpell(myHero, _Q) == READY and XUseQ.getValue() and ValidTarget(minion, 675) and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(minion, _Q)
		elseif CanUseSpell(myHero, _E) == READY and XUseE.getValue() and ValidTarget(minion, 700) and GetCurrentHP(minion) < CalcDamage(myHero, enemy, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(minion, _E)
		end
		
	end

end


for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
		
   if IWalkConfig.LaneClear then
		
		if CanUseSpell(myHero, _Q) == READY and JUseQ.getValue() and ValidTarget(mob, 675) then
		CastTargetSpell(mob, _Q)
		end
		
		if CanUseSpell(myHero, _W) == READY and JUseW.getValue() and ValidTarget(mob, 375) then
		CastSpell(_W)
		end
		
	    if CanUseSpell(myHero, _E) == READY and JUseE.getValue() and ValidTarget(mob, 700) then
		CastTargetSpell(mob, _E)
		end
		
	end
end

local HeroPos = GetOrigin(myHero)
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,675,3,100,0xff00ff00) end
if DrawingsW.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,375,3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,700,3,100,0xff00ff00) end
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
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + ExtraDmg2) then
		return 'W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + ExtraDmg2) then
		return 'W + Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E + W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + E = Kill!', ARGB(255, 255, 0, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 15*GetCastLevel(myHero,_Q)+0.15*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return '(Q + Passive) + W +E = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy) < ExtraDmg + CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 15*GetCastLevel(myHero,_Q)+0.15*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return '(Q + Passive) + W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero)) + CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero)) + CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero)) + (CalcDamage(myHero, enemy, 0, 15+20*GetCastLevel(myHero,_R)+0.25*GetBonusAP(myHero)+0.375*GetBonusDmg(myHero)) *10 + ExtraDmg2) then
		return 'Q + W + E + Ult ('.. string.format('%4.1f', ((GetCurrentHP(enemy) -  CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero)) - CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero)) - CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero))) / CalcDamage(myHero, enemy, 0, 15+20*GetCastLevel(myHero,_R)+0.25*GetBonusAP(myHero)+0.375*GetBonusDmg(myHero)))/4) .. ' Secs) = Kill!', ARGB(255, 255, 69, 0)
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end

notification("Katarina by Deftsu loaded.", 10000)
