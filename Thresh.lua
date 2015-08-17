Config = scriptConfig("Thresh", "Thresh")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
InterruptConfig = scriptConfig("Interrupt", "Interrupt Spells")
InterruptConfig.addParam("Q", "Interrupt With Q", SCRIPT_PARAM_ONOFF, true)
InterruptConfig.addParam("E", "Interrupt With E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, false)
ExtraConfig = scriptConfig("Extra", "Extra")
ExtraConfig.addParam("Autolvl", "Autolvl", SCRIPT_PARAM_ONOFF, false)
ExtraConfig.addParam("AutoR", "Auto R", SCRIPT_PARAM_ONOFF, true)
ExtraConfig.addParam("SaveAlly", "SaveAlly", SCRIPT_PARAM_KEYDOWN, string.byte("G"))

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
Drawings()
AutoR()
SaveAlly()

if ExtraConfig.Autolvl then
LevelUp()
end


        local target = GetTarget(GetCastRange(myHero,_Q), DAMAGE_MAGIC)
        if IWalkConfig.Combo then
		    
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,GetCastRange(myHero,_Q),80,true,true)
			local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,GetCastRange(myHero,_E),200,false,true)
				
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q and ValidTarget(target, GetCastRange(myHero,_Q)) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			elseif GetCastName(myHero, _Q) == "threshqleap" and Config.Q then
            CastSpell(_Q)
            end
			
			xPos = GetOrigin(myHero).x + (GetOrigin(myHero).x - EPred.PredPos.x)
			yPos = GetOrigin(myHero).y + (GetOrigin(myHero).y - EPred.PredPos.y)
			zPos = GetOrigin(myHero).z + (GetOrigin(myHero).z - EPred.PredPos.z)
			
			if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ValidTarget(target, GetCastRange(myHero,_E)) and GetCurrentHP(myHero)/GetMaxHP(myHero) >= 0.26 then
			CastSkillShot(_E, xPos, yPos, zPos)
		    elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ValidTarget(target, GetCastRange(myHero,_E)) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.26 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		    end				
           
		    if CanUseSpell(myHero, _R) == READY and ValidTarget(target, GetCastRange(myHero,_R)) and Config.R then
		    CastSpell(_R)
			end
        end
		
		local target = GetTarget(GetCastRange(myHero,_Q), DAMAGE_MAGIC)
		if IWalkConfig.Harass then 
		
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,GetCastRange(myHero,_Q),80,true,true)
		    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q and ValidTarget(target, GetCastRange(myHero,_Q)) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			elseif GetCastName(myHero, _Q) == "threshqleap" then return end
	    end	
end)

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end

function AutoR()
  if ExtraConfig.AutoR then
    if CanUseSpell(myHero,_R) and EnemiesAround(GetMyHeroPos(), GetCastRange(myHero,_R)) >= 3 then
	CastSpell(_R)
	end
  end
end

function SaveAlly()
if ExtraConfig.SaveAlly then
  for _, ally in pairs(GetAllyHeroes()) do
  local WPred = GetPredictionForPlayer(GetMyHeroPos(),ally,GetMoveSpeed(ally),math.huge,250,GetCastRange(myHero,_E),90,false,true)
  local AllyPos = GetOrigin(ally)
  local mousePos = GetMousePos()
    if CanUseSpell(myHero,_W) and GetDistance(myHero, ally) < GetCastRange(myHero,_W) then
    CastSkillShot(_W,AllyPos.x,AllyPos.y,AllyPos.z)
	else
	MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
	end
  end
end
end
	
function Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

addInterrupterCallback(function(target, spellType)
local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1900,500,GetCastRange(myHero,_Q),80,true,true)
local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,125,GetCastRange(myHero,_E),200,false,true)
  if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and EPred.HitChance == 1 and InterruptConfig.E and spellType == CHANELLING_SPELLS then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  elseif IsInDistance(target, GetCastRange(myHero,_Q)) and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 and InterruptConfig.Q and spellType == CHANELLING_SPELLS then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
  end
end)
AddGapcloseEvent(_E, 450, false)
