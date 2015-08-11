require 'MapPositionGOS'
PrintChat("D3ftland Vayne By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Vayne", "Vayne")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("AutoE", "Auto E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Walltumble1", "Walltumble Mid", SCRIPT_PARAM_KEYDOWN, string.byte("T"))
Config.addParam("Walltumble2", "Walltumble Drake", SCRIPT_PARAM_KEYDOWN, string.byte("U"))
Config.addParam("R", "Use R (Soon)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Autolvl", "Gosu Autolvl", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE2","Draw E Push Distance", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
CheckLevel()

if Config.Autolvl then
LevelUp()
end

if Config.AutoE then
AutoE()
end

if IWalkConfig.Combo then
        
                local target = GetTarget(550, DAMAGE_PHYSICAL)
                local HeroPos = GetOrigin(myHero)
                local mousePos = GetMousePos()
                local AfterTumblePos = HeroPos + (Vector(mousePos) - HeroPos):normalized() * 300
                local DistanceAfterTumble = GetDistance(AfterTumblePos, Target)    
		if ValidTarget(target, 550) and Config.Q then
                
                       if  DistanceAfterTumble < 630*630 and DistanceAfterTumble > 300*300 then
                       CastSkillShot(_Q, mousePos.x, mousePos.y,   mousePos.z)
                       end
                       if GetDistance(myHero, Target) > 630*630 and DistanceAfterTumble < 630*630 then
                      CastSkillShot(_Q, mousePos.x, mousePos.y, mousePos.z)
                      end 
                end
end
   local HeroPos = GetOrigin(myHero)
   if CanUseSpell(myHero, _Q) == READY then
        if Config.Walltumble1 and HeroPos.x == 6962 and HeroPos.z == 8952 then
            CastSkillShot(_Q,6667.3271484375, 51, 8794.64453125)
        elseif Config.Walltumble1 then
            MoveToXYZ(6962, 51, 8952)
        end
    
        if Config.Walltumble2 and HeroPos.x == 12060 and HeroPos.z == 4806 then
            CastSkillShot(_Q,11745.198242188, 51, 4625.4379882813)
        elseif Config.Walltumble2 then
            MoveToXYZ(12060, 51, 4806)
        end
    end
end)

function AutoE()
	 for _,target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target,20000) then
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

function LevelUp()     

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

function Drawings()
-- Thanks Laiha senpai for this ♥
  for _, unit in pairs(GetEnemyHeroes()) do
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE2 then
local unitPos=GetOrigin(unit)
local vectorx = unitPos.x-GetOrigin(myHero).x
local vectory = unitPos.y-GetOrigin(myHero).y
local vectorz = unitPos.z-GetOrigin(myHero).z
local dist= math.sqrt(vectorx^2+vectory^2+vectorz^2)
                ourcoord={x = unitPos.x + 450 * vectorx / dist ,y = unitPos.y + 450 * vectory / dist, z = unitPos.z + 450 * vectorz / dist}
                DrawCircle(ourcoord.x,ourcoord.y,ourcoord.z,25,1,1,0xffffffff)myHeroPos = GetOrigin(myHero)
  end
end


if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end
AddGapcloseEvent(_E, 450, true)
