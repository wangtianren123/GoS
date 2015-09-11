PrintChat("D3ftland Xerath By Deftsu Loaded, Have A Good Game!")

Xerath = Menu("Xerath", "Xerath")

Xerath:SubMenu("c", "Combo")
Xerath.c:Boolean("Q", "Use Q", true)
Xerath.c:Boolean("W", "Use W", true)
Xerath.c:Boolean("E", "Use E", true)
Xerath.c:Key("combo", "Combo", string.byte(" "))

Xerath:SubMenu("h", "Harass")
Xerath.h:Boolean("Q", "Use Q", true)
Xerath.h:Boolean("W", "Use W", true)
Xerath.h:Boolean("E", "Use E", false)
Xerath.h:Key("harass", "Harass", string.byte("C"))


Xerath:SubMenu("Killsteal", "Killsteal")
Xerath.Killsteal:Boolean("W", "Killsteal with W", true)
Xerath.Killsteal:Boolean("E", "Killsteal with E", true)

Xerath:SubMenu("Misc", "Misc")
Xerath.Misc:Boolean("Autoignite", "Auto Ignite", true)
Xerath.Misc:Boolean("Autolvl", "Auto level  Q-W-E", true)
Xerath.Misc:Boolean("AutoR", "Auto R Killable", true)
Xerath.Misc:Key("AutoRKey", "Auto R Killable", string.byte("T"))
Xerath.Misc:Boolean("Interrupt", "Interrupt", true)

Xerath:SubMenu("Drawings", "Drawings")
Xerath.Drawings:Boolean("QM", "Draw Q Max Range", true)
Xerath.Drawings:Boolean("QMi", "Draw Q Min Range", true)
Xerath.Drawings:Boolean("W", "Draw W Range", true)
Xerath.Drawings:Boolean("E", "Draw E Range", true)
Xerath.Drawings:Boolean("R", "Draw R Range", true)

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

if Xerath.Misc.AutoR:Value() then
AutoR()
end

if Xerath.Misc.AutoRKey:Value() then
AutoRkey()
end

LevelUp()

local target = GetTarget(1500, DAMAGE_MAGIC)
if IOW:Mode() == "Combo" then
				
    local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Xerath.c.E:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Xerath.c.W:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end		

    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1500) and Xerath.c.Q:Value() then
      local myHeroPos = GoS:myHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 750 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
    end	
                    
end


local target = GetTarget(1500, DAMAGE_MAGIC)
if IOW:Mode() == "Harass" then

    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1500) and Xerath.h.Q:Value() then
      local myHeroPos = GoS:myHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 700 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
    end

    local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
    if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Xerath.h.E:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
	
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,GetCastRange(myHero,_W),125,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Xerath.h.W:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_W)) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
    end		
end

end)


function LevelUp()     
if Xerath.Misc.Autolvl:Value() then

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
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,700,GetCastRange(myHero,_W),125,false,true)
	   local EPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,GetCastRange(myHero,_E),60,true,true)
       if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(enemy,GetCastRange(myHero,_W)) and Xerath.Killsteal.W:Value() and WPred.HitChance == 1 and GetCurrentHP(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_Q)+ 30 + 0.6*GetBonusAP(myHero)) then
	   CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	   elseif CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero, _E)) and Xerath.Killsteal.E:Value() and EPred.HitChance == 1 and GetCurrentHP(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30*GetCastLevel(myHero,_E)+ 50 + 0.45*GetBonusAP(myHero)) then  
       CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
       end
    end
            if Ignite and Xerath.Misc.Autoignite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
end

function Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and Xerath.Drawings.QMi:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,750,3,100,0xff00ff00) end
if CanUseSpell(myHero, _Q) == READY and Xerath.Drawings.QM:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,1500,3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and Xerath.Drawings.W:Value()then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and Xerath.Drawings.E:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and Xerath.Drawings.R:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

function AutoR()
  if waitTickCount < GetTickCount() then
	local target = GetTarget(GetCastRange(myHero,_R), DAMAGE_MAGIC)
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,800 + 1050*GetCastLevel(myHero,_R),120,false,true)
    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and GetCurrentHP(target) < GoS:CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero)) then
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
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,800 + 1050*GetCastLevel(myHero,_R),120,false,true)
    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(target, 800 + 1050*GetCastLevel(myHero,_R)) and GetCurrentHP(target) < GoS:CalcDamage(myHero, target, 0, 405+165*GetCastLevel(myHero, _R)+1.29*GetBonusAP(myHero)) then
	waitTickCount = GetTickCount() + 1400
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	end
  end
end

addInterrupterCallback(function(target, spellType)
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_E),60,true,true)
  if GoS:IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and EPred.HitChance == 1 and Xerath.Misc.Interrupt:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)

AddGapcloseEvent(_E, 200, false)
