if GetObjectName(myHero) ~= "Katarina" then return end

KatarinaMenu = Menu("Katarina", "Katarina")
KatarinaMenu:SubMenu("Combo", "Combo")
KatarinaMenu.Combo:Boolean("Q", "Use Q", true)
KatarinaMenu.Combo:Boolean("W", "Use W", true)
KatarinaMenu.Combo:Boolean("E", "Use E", true)
KatarinaMenu.Combo:Boolean("R", "Use R", true)
KatarinaMenu.Combo:Key("WardJumpkey", "Ward Jump!", string.byte("G"))

KatarinaMenu:SubMenu("Harass", "Harass")
KatarinaMenu.Harass:Boolean("Q", "Use Q", true)
KatarinaMenu.Harass:Boolean("W", "Use W", true)
KatarinaMenu.Harass:Boolean("E", "Use E", true)
KatarinaMenu.Harass:Boolean("AutoQ", "Auto Q", true)
KatarinaMenu.Harass:Boolean("AutoW", "Auto W", true)

KatarinaMenu:SubMenu("Killsteal", "Killsteal")
KatarinaMenu.Killsteal:Boolean("SmartKS", "Smart KS", true)
KatarinaMenu.Killsteal:Boolean("UseWards", "Use Wards", true)

KatarinaMenu:SubMenu("Misc", "Misc")
KatarinaMenu.Misc:Boolean("Autoignite", "Auto Ignite", true)
KatarinaMenu.Misc:Boolean("Autolvl", "Auto level", true)

KatarinaMenu:SubMenu("JungleClear", "JungleClear")
KatarinaMenu.JungleClear:Boolean("Q", "Use Q", true)
KatarinaMenu.JungleClear:Boolean("W", "Use W", true)
KatarinaMenu.JungleClear:Boolean("E", "Use E", true)

KatarinaMenu:SubMenu("Drawings", "Drawings")
KatarinaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
KatarinaMenu.Drawings:Boolean("W", "Draw W Range", true)
KatarinaMenu.Drawings:Boolean("E", "Draw E Range", true)
KatarinaMenu.Drawings:Boolean("R", "Draw R Range", true)
KatarinaMenu.Drawings:Boolean("Text", "Draw Text", true)

KatarinaMenu:SubMenu("Farm", "Farm")
KatarinaMenu.Farm:Boolean("Q", "Lasthit with Q", false)
KatarinaMenu.Farm:Boolean("W", "Lasthit with W", false)
KatarinaMenu.Farm:Boolean("E", "Lasthit with E", false)
KatarinaMenu.Farm:Boolean("QLC", "Clear with Q", false)
KatarinaMenu.Farm:Boolean("WLC", "Clear with W", false)
KatarinaMenu.Farm:Boolean("ELC", "Clear with E", false)

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

local function ValidTarget( object )
	local objType = GetObjectType(object)
	if GetObjectName(myHero) == "Katarina" then
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
	  if ValidTarget(object) and IsInDistance(200, GetOrigin(object), pos) then
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

        if unit and unit == myHero and spellspell.name:lower():find("katarinar") then
        waitTickCount = GetTickCount() + 2500
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

	if KatarinaMenu.Combo.WardJumpkey:Value() then
	wardJump(mousePos)
	MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
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
  
  if GotBuff(myHero, "katarinarsound") < 1 then 
  IOW:EnableOrbwalking() 
  end

  if IOW:Mode() == "Combo" then
       
      if waitTickCount > GetTickCount() then return end
      local target = GetCurrentTarget()
	  
      if SpellQREADY and KatarinaMenu.Combo.Q:Value() and GoS:ValidTarget(target, 675) then
      CastTargetSpell(target, _Q)
      end
	  
      if SpellWREADY and KatarinaMenu.Combo.W:Value() and GoS:ValidTarget(target, 375) then
      CastSpell(_W)
      end
	  
      if SpellEREADY and KatarinaMenu.Combo.E:Value() and GoS:ValidTarget(target, 700) then
      CastTargetSpell(target, _E)
      end
	  
      if KatarinaMenu.Combo.R:Value() and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R)  ~= ONCOOLDOWN and GoS:ValidTarget(target, 550) and GetCastLevel(myHero,_R) > 0 then
      HoldPosition()
      --IOW:DisableOrbwalking() 
      waitTickCount = GetTickCount() + 50
      CastSpell(_R)
      end
  end

  if IOW:Mode() == "Harass" then
      local target = GetCurrentTarget()
	  
      if SpellQREADY and KatarinaMenu.Harass.Q:Value() and GoS:ValidTarget(target, 675) then
      CastTargetSpell(target, _Q)
      end
	  
      if SpellWREADY and KatarinaMenu.Harass.W:Value() and GoS:ValidTarget(target, 375) then
      CastSpell(_W)
      end
	  
      if SpellEREADY and KatarinaMenu.Harass.E:Value() and GoS:ValidTarget(target, 700) then
      CastTargetSpell(target, _E)
      end
  end

local target = GetCurrentTarget()

if KatarinaMenu.Harass.AutoQ:Value() and GoS:ValidTarget(target, 675) and GotBuff(myHero, "katarinarsound") < 1 then
CastTargetSpell(target, _Q)
end

if KatarinaMenu.Harass.AutoW:Value() and GoS:ValidTarget(target, 375) and GotBuff(myHero, "katarinarsound") < 1 then
CastSpell(_W)
end

    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
       if KatarinaMenu.Killsteal.SmartKS:Value() then
	   
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	        ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
				
		if Ignite and KatarinaMenu.Misc.Autoignite:Value() then
                  if SpellIREADY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
                                if SpellWREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero)) and GoS:ValidTarget(enemy, 375) then 
				CastSpell(_W)
				
				elseif SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) and GoS:ValidTarget(enemy, 675) then 
				CastTargetSpell(enemy, _Q)
				
				elseif SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) and GoS:ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				
				elseif SpellQREADY and SpellWREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) and GoS:ValidTarget(enemy, 375) then 
				CastSpell(_W)
				CastTargetSpell(enemy, _Q)
		
				elseif SpellEREADY and SpellWREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) and GoS:ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				CastSpell(_W)
				
				elseif SpellQREADY and SpellWREADY and SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) and GoS:ValidTarget(enemy, 700) then 
				CastTargetSpell(enemy, _E)
				CastTargetSpell(enemy, _Q)
				CastSpell(_W)
				end
				
	                        if KatarinaMenu.Killsteal.UseWards:Value() and GoS:ValidTarget(enemy, 1275) and GoS:GetDistance(enemy) > 700 and SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) then
			        wardJump(GetOrigin(enemy))
		                CastTargetSpell(enemy, _Q)
	                        end
				
	end
     end

if KatarinaMenu.Misc.Autolvl:Value() then
 
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

for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end

        if IOW:Mode() == "LaneClear" then
		if SpellQREADY and KatarinaMenu.Farm.QLC:Value() and GoS:ValidTarget(minion, 675) then
		CastTargetSpell(minion, _Q)
		end
		
		if SpellWREADY and KatarinaMenu.Farm.WLC:Value() and GoS:ValidTarget(minion, 375) then
		CastSpell(_W)
		end
		
		if SpellEREADY and KatarinaMenu.Farm.ELC:Value() and GoS:ValidTarget(minion, 700) then
		CastTargetSpell(minion, _E)
		end
	end
	
	if IOW:Mode() == "LastHit" then
		
	        if SpellWREADY and KatarinaMenu.Farm.W:Value() and GoS:ValidTarget(minion, 375) and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 5 + 35*GetCastLevel(myHero,_W) + 0.25*GetBonusAP(myHero) + 0.60*GetBonusDmg(myHero) + ExtraDmg) then
		CastSpell(_W)
		elseif SpellQREADY and KatarinaMenu.Farm.Q:Value() and GoS:ValidTarget(minion, 675) and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 35 + 25*GetCastLevel(myHero,_Q) + 0.45*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(minion, _Q)
		elseif SpellEREADY and KatarinaMenu.Farm.E:Value() and GoS:ValidTarget(minion, 700) and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 0, 10 + 30*GetCastLevel(myHero,_E) + 0.25*GetBonusAP(myHero) + ExtraDmg) then
		CastTargetSpell(minion, _E)
		end
		
	end

end
	
for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
   if IOW:Mode() == "LaneClear" then
		
		if SpellQREADY and KatarinaMenu.JungleClear.Q:Value() and GoS:ValidTarget(mob, 675) then
		CastTargetSpell(mob, _Q)
		end
		
		if SpellWREADY and KatarinaMenu.JungleClear.W:Value() and GoS:ValidTarget(mob, 375) then
		CastSpell(_W)
		end
		
	        if SpellEREADY and KatarinaMenu.JungleClear.E:Value() and GoS:ValidTarget(mob, 700) then
		CastTargetSpell(mob, _E)
		end
		
	end
end

if KatarinaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,675,3,100,0xff00ff00) end
if KatarinaMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,375,3,100,0xff00ff00) end
if KatarinaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,700,3,100,0xff00ff00) end
if KatarinaMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,550,3,100,0xff00ff00) end
  if KatarinaMenu.Drawings.Text:Value() then
	for _, enemy in pairs(GoS:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy) then
		        local enemyPos = GetOrigin(enemy)
			local drawpos = WorldToScreen(1,enemyPos.x, enemyPos.y, enemyPos.z)
			local enemyText, color = GetDrawText(enemy)
			DrawText(enemyText, 20, drawpos.x, drawpos.y, color)
		end
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
	if Ignite and SpellIREADY then
	ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if SpellQREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellWREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + ExtraDmg2) then
		return 'W = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and SpellWREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + ExtraDmg2) then
		return 'W + Q = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellWREADY and SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E + W = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and SpellWREADY and SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + E = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and SpellWREADY and SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 15*GetCastLevel(myHero,_Q)+0.15*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return '(Q + Passive) + W +E = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and SpellQREADY and SpellWREADY and SpellEREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < ExtraDmg + GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero) + 15*GetCastLevel(myHero,_Q)+0.15*GetBonusAP(myHero) + 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero) + 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero) + ExtraDmg2) then
		return '(Q + Passive) + W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif SpellQREADY and SpellWREADY and SpellEREADY and SpellRREADY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero)) + GoS:CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero)) + GoS:CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero)) + (GoS:CalcDamage(myHero, enemy, 0, 15+20*GetCastLevel(myHero,_R)+0.25*GetBonusAP(myHero)+0.375*GetBonusDmg(myHero)) *10 + ExtraDmg2) then
		return 'Q + W + E + Ult ('.. string.format('%4.1f', ((GetCurrentHP(enemy) -  GoS:CalcDamage(myHero, enemy, 0, 35+25*GetCastLevel(myHero,_Q)+0.45*GetBonusAP(myHero)) - GoS:CalcDamage(myHero, enemy, 0, 5+35*GetCastLevel(myHero,_W)+0.25*GetBonusAP(myHero)+0.6*GetBonusDmg(myHero)) - GoS:CalcDamage(myHero, enemy, 0, 10+30*GetCastLevel(myHero,_E)+0.25*GetBonusAP(myHero))) / GoS:CalcDamage(myHero, enemy, 0, 15+20*GetCastLevel(myHero,_R)+0.25*GetBonusAP(myHero)+0.375*GetBonusDmg(myHero)))/4) .. ' Secs) = Kill!', ARGB(255, 255, 69, 0)
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end
