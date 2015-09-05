require('MapPositionGOS')
require('Dlib')

local version = 15
local UP=Updater.new("D3ftsu/GoS/master/Common/Vayne.lua", "Common\\Vayne", version)
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

local root = menu.addItem(SubMenu.new("Vayne"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CUseE = Combo.addItem(MenuBool.new("Use E",true))
local CUseR = Combo.addItem(SubMenu.new("Use R"))
local REnabled = CUseR.addItem(MenuBool.new("Enabled",true))
local KeepInvis = CUseR.addItem(MenuBool.new("Keep Invisibility",true))
local KeepInvisdis = CUseR.addItem(MenuSlider.new("Only if Distance <", 230, 0, 550, 1))
local Deftsukappa = CUseR.addItem(MenuSeparator.new(""))
local Rifthp = CUseR.addItem(MenuSlider.new("if Target Health % <", 70, 1, 100, 1))
local Rifhp = CUseR.addItem(MenuSlider.new("if Health % <", 55, 1, 100, 1))
local Rminally = CUseR.addItem(MenuSlider.new("Minimum Allies in Range", 2, 0, 4, 1))
local Rallyrange = CUseR.addItem(MenuSlider.new("Range", 1000, 1, 3000, 50))
local Rminenemy = CUseR.addItem(MenuSlider.new("Minimum Enemies in Range", 2, 1, 5, 1))
local Renemyrange = CUseR.addItem(MenuSlider.new("Range", 1000, 1, 3000, 50))
local CItems = Combo.addItem(MenuBool.new("Use Items",true))
local CQSS = Combo.addItem(MenuBool.new("Use QSS", true))
local QSSHP = Combo.addItem(MenuSlider.new("if My Health % is Less Than", 75, 0, 100, 5))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscAutoE = Misc.addItem(MenuBool.new("Auto Wall Condemn", true))
local MiscInterrupt = Misc.addItem(MenuBool.new("Interrupt", true))
local WallTumble1 = Misc.addItem(MenuKeyBind.new("WallTumble Mid", 84))
local WallTumble2 = Misc.addItem(MenuKeyBind.new("WallTumble Drake", 85))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", false))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", false))
local DrawingsWT = Drawings.addItem(MenuBool.new("Draw WallTumble Positions", true))

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

local mousePos = GetMousePos()

OnLoop(function(myHero)
    if IWalkConfig.Combo then
	local target = GetCurrentTarget()
	    
	if myIAC:IsWindingUp() and CUseQ.getValue() and ValidTarget(target, 700) then
        DelayAction(function() 
	Tumble()
        end, GetWindUp(GetMyHero()) + (GetLatency()*2))
	DelayAction(function() 
	AttackUnit(target)
        end, 250)
        end
	
	if GetItemSlot(myHero,3153) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and CItems.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and CQSS.getValue() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and CQSS.getValue() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	if CUseE.getValue() then
	AutoE()
        end

        if CanUseSpell(myHero, _R) == READY and IWalkConfig.Combo and (GetCurrentHP(target)/GetMaxHP(target))*100 <= Rifthp.getValue() and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 <= Rifhp.getValue() and EnemiesAround(GetMyHeroPos(), Renemyrange.getValue()) >= Rminenemy.getValue() and AlliesAround(GetMyHeroPos(), Rallyrange.getValue()) >= Rminally.getValue() then
        CastSpell(_R)
	end
		  
	if GotBuff(myHero, "vaynetumblefade") > 0 and KeepInvis.getValue() and GetDistance(myHero, target) < KeepInvisdis.getValue() then 
	myIAC:SetAA(false)
	elseif GotBuff(myHero, "vaynetumblefade") < 1 then
	myIAC:SetAA(true)
	end
    end
	
	if MiscAutoE.getValue() then
	AutoE()
	end
	
	local HeroPos = GetOrigin(myHero)
   
        if WallTumble1.getValue() and HeroPos.x == 6962 and HeroPos.z == 8952 then
            CastSkillShot(_Q,6667.3271484375, 51, 8794.64453125)
        elseif WallTumble1.getValue() then
            MoveToXYZ(6962, 51, 8952)
        end
    
        if WallTumble2.getValue() and HeroPos.x == 12060 and HeroPos.z == 4806 then
            CastSkillShot(_Q,11745.198242188, 51, 4625.4379882813)
        elseif WallTumble2.getValue() then
            MoveToXYZ(12060, 51, 4806)
        end
		

if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if DrawingsWT.getValue() then
DrawCircle(6962, 51, 8952,100,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,100,1,1,0xffffffff)
end
end)

function Tumble()
  local HeroPos = GetOrigin(myHero)
  local AfterTumblePos = HeroPos + (Vector(mousePos) - HeroPos):normalized() * 300
  local DistanceAfterTumble = GetDistance(AfterTumblePos, target)
  if DistanceAfterTumble < 630 and DistanceAfterTumble > 200 then
  CastSkillShot(_Q,GenerateMovePos().x, GenerateMovePos().y, GenerateMovePos().z)
  end
  
  if GetDistance(myHero, target) > 630 and DistanceAfterTumble < 630 then
  CastSkillShot(_Q,GenerateMovePos().x, GenerateMovePos().y, GenerateMovePos().z)
  end
end

function AutoE()
	 for _,target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target,1000) then
			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz
			local distance1=24
			local distance2=118
			local distance3=212
			local distance4=306
			local distance5=400
 
			local enemyposition = GetOrigin(target)
			enemyposx=enemyposition.x
			enemyposy=enemyposition.y
			enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
 
			local self=GetOrigin(myHero)
			selfx = self.x
			selfy = self.y
    	                selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
    	
			local Pos1 = TargetPos-(TargetPos-HeroPos)*(-distance1/GetDistance(target))
			local Pos2 = TargetPos-(TargetPos-HeroPos)*(-distance2/GetDistance(target))
			local Pos3 = TargetPos-(TargetPos-HeroPos)*(-distance3/GetDistance(target))
			local Pos4 = TargetPos-(TargetPos-HeroPos)*(-distance4/GetDistance(target))
			local Pos5 = TargetPos-(TargetPos-HeroPos)*(-distance5/GetDistance(target))
 
				if MapPosition:inWall(Pos1)==true then
					if GetDistance(target)<=550 then
					CastTargetSpell(target, _E) 
					end
				end
				
				if MapPosition:inWall(Pos2)==true then
					if GetDistance(target)<=550 then
					CastTargetSpell(target, _E) 
					end
				end
				
				if MapPosition:inWall(Pos3)==true then
					if GetDistance(target)<=550 then
					CastTargetSpell(target, _E) 
					end
				end
				
				if MapPosition:inWall(Pos4)==true then
					if GetDistance(target)<=550 then
					CastTargetSpell(target, _E) 
					end
				end
				
				if MapPosition:inWall(Pos5)==true then
					if GetDistance(target)<=550 then
					CastTargetSpell(target, _E) 
					end
				end
				
		end
	end
end

if MiscEnableAutolvl.getValue() then  
local leveltable = { _Q, _W, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- Credits goes to Inferno for saving me 20 line xD
LevelSpell(leveltable[GetLevel(myHero)]) 
end


addInterrupterCallback(function(target, spellType)
  if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and spellType == CHANELLING_SPELLS and MiscInterrupt.getValue() then
    CastTargetSpell(target, _E)
  end
end)

function AlliesAround(pos, range)
    local s = 0
    if pos == nil then return 0 end
    for sk,sv in pairs(GetAllyHeroes()) do 
        if sv and ValidTarget(sv) and GetDistanceSqr(pos,GetOrigin(sv)) < range*range then
            s = s + 1
        end
    end
    return s
end

AddGapcloseEvent(_E, 475, true)

notification("Vayne by Deftsu loaded.", 10000)
