require 'MapPositionGOS'
PrintChat("D3ftland Vayne By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Vayne", "Vayne")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R (logic)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item1","Use BotRK",SCRIPT_PARAM_ONOFF,true)
Config.addParam("Item2","Use Bilgewatter",SCRIPT_PARAM_ONOFF,true)
Config.addParam("Item3","Use Youmuu",SCRIPT_PARAM_ONOFF,true)
Config.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("AutoE", "Auto E", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Walltumble1", "Walltumble Mid", SCRIPT_PARAM_KEYDOWN, string.byte("T"))
MiscConfig.addParam("Walltumble2", "Walltumble Drake", SCRIPT_PARAM_KEYDOWN, string.byte("U"))
MiscConfig.addParam("Autolvl", "Gosu Autolvl", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawWT","Draw WT Positions",SCRIPT_PARAM_ONOFF,true)

myIAC=IAC()

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
	local target = GetTarget(700, DAMAGE_PHYSICAL)
	
		if GetItemSlot(myHero,3153) > 0 and Config.Item1 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and Config.Item2 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and Config.Item3 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
		if GetItemSlot(myHero,3140) > 0 and Config.Item4 and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < 75 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and Config.Item4 and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < 75 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
		if Config.E then
		AutoE()
		end
		
	  for i,enemy in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero, _R) == READY and (GetCurrentHP(enemy)/GetMaxHP(enemy))*100 < 75 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < 55 and EnemiesAround(GetMyHeroPos(), 1000) >= 2 and AlliesAround(GetMyHeroPos(), 1000) > 1 then
		CastSpell(_R)
		end
	  end
		
	end
	
	if MiscConfig.AutoE then
	AutoE()
	end
	
	local HeroPos = GetOrigin(myHero)
   
        if MiscConfig.Walltumble1 and HeroPos.x == 6962 and HeroPos.z == 8952 then
            CastSkillShot(_Q,6667.3271484375, 51, 8794.64453125)
        elseif MiscConfig.Walltumble1 then
            MoveToXYZ(6962, 51, 8952)
        end
    
        if MiscConfig.Walltumble2 and HeroPos.x == 12060 and HeroPos.z == 4806 then
            CastSkillShot(_Q,11745.198242188, 51, 4625.4379882813)
        elseif MiscConfig.Walltumble2 then
            MoveToXYZ(12060, 51, 4806)
        end
		

if DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if DrawingsConfig.DrawWT then
DrawCircle(6962, 51, 8952,100,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,100,1,1,0xffffffff)
end
end)

OnProcessSpell(function(unit, spell)
  if unit and spell and spell.name then
      if unit == myHero then
        if spell.name:lower():find("attack") then 
		   DelayAction(function() 
                              if CanUseSpell(myHero,_Q) == READY and IWalkConfig.Combo and Config.Q then
							  Tumble()
                              end
                       end, spell.windUpTime + GetLatency()/2000)
		end
	end
  end
end)

function Tumble()
  local HeroPos = GetOrigin(myHero)
  local AfterTumblePos = HeroPos + (Vector(mousePos) - HeroPos):normalized() * 300
  local DistanceAfterTumble = GetDistance(AfterTumblePos, unit)
  if DistanceAfterTumble < 630 and DistanceAfterTumble > 300 then
  CastSkillShot(_Q,GenerateMovePos().x, GenerateMovePos().y, GenerateMovePos().z)
  end
  
  if GetDistance(myHero, unit) > 630 and DistanceAfterTumble < 630 then
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

if MiscConfig.Autolvl then  

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end

end

addInterrupterCallback(function(target, spellType)
  if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and spellType == CHANELLING_SPELLS then
    CastTargetSpell(target, _E)
  end
end)

function AlliesAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GetAllyHeroes()) do 
        if v and ValidTarget(v) and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
            c = c + 1
        end
    end
    return c
end
