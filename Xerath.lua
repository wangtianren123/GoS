PrintChat("D3ftland Xerath By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Xerath", "Xerath")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, false)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawminQ","Q Min Range", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawmaxQ","Q Max Range", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","W Range", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","E Range", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","R Range", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("AutoR", "Auto R Killable", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("AutoRKey", "Auto R if Press", SCRIPT_PARAM_KEYDOWN, string.byte("T"))
MiscConfig.addParam("Interrupt", "Interrupt Spells (E)", SCRIPT_PARAM_ONOFF, true)
	
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
Killsteal()

if MiscConfig.AutoR then
AutoR()
end

if MiscConfig.AutoRKey then
AutoRkey()
end

LevelUp()

local target = GetTarget(1500, DAMAGE_MAGIC)
if IWalkConfig.Combo then
				
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
	local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W and ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end		

    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 1500) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 750 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
    end	
                    
end


local target = GetTarget(1500, DAMAGE_MAGIC)
if IWalkConfig.Harass then

    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 1500) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 700 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
    end

    local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E and ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
	local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W and ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end		
end

end)


function LevelUp()     
if MiscConfig.Autolvl then

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
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
end

function Killsteal()
    for i,enemy in pairs(GetEnemyHeroes()) do
       local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,700,GetCastRange(myHero,_W),125,false,true)
	   local EPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,GetCastRange(myHero,_E),60,true,true)
       if CanUseSpell(myHero, _W) == READY and ValidTarget(enemy,GetCastRange(myHero,_W)) and KSConfig.KSW and WPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_Q)+ 30 + 0.6*GetBonusAP(myHero)) then
	   CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	   elseif CanUseSpell(myHero, _E) == READY and ValidTarget(enemy, GetCastRange(myHero, _E)) and KSConfig.KSE and EPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_E)+ 50 + 0.45*GetBonusAP(myHero)) then  
       CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
       end
    end
end

function Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawminQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,750,3,100,0xff00ff00) end
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawmaxQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,1500,3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

function AutoR()
  if waitTickCount < GetTickCount() then
	local target = GetTarget(GetCastRange(myHero,_R), DAMAGE_MAGIC)
	local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,800 + 1050*GetCastLevel(myHero,_R),120,false,true)
    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and GetCurrentHP(target) < CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero)) then
	waitTickCount = GetTickCount() + 1400
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	end
  end
end

function AutoRkey()
  if waitTickCount < GetTickCount() then
	local target = GetTarget(800 + 1050*GetCastLevel(myHero,_R), DAMAGE_MAGIC)
	local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,700,800 + 1050*GetCastLevel(myHero,_R),120,false,true)
    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and GetCurrentHP(target) < CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero)) then
	waitTickCount = GetTickCount() + 1400
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	end
  end
end

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
  if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and EPred.HitChance == 1 and MiscConfig.Interrupt and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)

AddGapcloseEvent(_E, 200, false)
