
Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))

Azir = Menu("Azir", "Azir")

Azir:SubMenu("c", "Combo")
Azir.c:Boolean("Q", "Use Q", true)
Azir.c:Boolean("W", "Use W", true)
Azir.c:Boolean("E", "Use E", true)
Azir.c:Boolean("R", "Use R", true)
Azir.c:Key("combo", "Combo", string.byte(" "))
Azir.c:Boolean("AA", "Use AA", true)
Azir.c:Key("flee", "Flee", string.byte("Z"))

Azir:SubMenu("h", "Harass")
Azir.h:Boolean("Q", "Use Q", true)
Azir.h:Boolean("W", "Use W", true)
Azir.h:Key("harass", "Harass", string.byte("C"))
Azir.h:Boolean("AA", "Use AA", true)

Azir:SubMenu("Killsteal", "Killsteal")
Azir.Killsteal:Boolean("Q", "Killsteal with Q", true)

Azir:SubMenu("Misc", "Misc")
Azir.Misc:Boolean("Autoignite", "Auto Ignite", true)
Azir.Misc:Boolean("Autolvl", "Auto level", true)
Azir.Misc:Boolean("Interrupt", "Interrupt", true)

Azir:SubMenu("Drawings", "Drawings")
Azir.Drawings:Boolean("Q", "Draw Q Range", true)
Azir.Drawings:Boolean("W", "Draw W Range", true)
Azir.Drawings:Boolean("E", "Draw E Range", true)
Azir.Drawings:Boolean("R", "Draw R Range", true)


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
  if IOW:Mode() == "Combo" then
	local target = GetCurrentTarget()
	
	    local SoldierRange = 0
	    local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,950,80,false,true)
	    local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,0,600,100,false,true)
	    local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,500,950,700,false,true)
		
	    for i = 1, #AzirSoldiers do 
	           if GoS:ValidTarget(target, 1500) and table.getn(AzirSoldiers) > 0 then
		   SoldierRange = GoS:GetDistance(AzirSoldiers[i], target)
		   end
		
		   if CanUseSpell(myHero,_E) and GoS:ValidTarget(target, 1300) and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and Azir.c.E:Value() then 
		   CastSpell(_E)
		   end
		   
		   if CanUseSpell(myHero,_Q) and SoldierRange > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and Azir.c.E:Value() then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
		   
		   if GoS:ValidTarget(target, 1500) and GoS:GetDistance(target) > 550 and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and Azir.c.AA:Value() then
		   AttackUnit(target)
		   end
	    end
	
		if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target,500) and WPred.HitChance == 1 and Azir.c.W:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if GoS:ValidTarget(target, 1500) and table.getn(AzirSoldiers) < 1 and QPred.HitChance == 1 and Azir.c.Q:Value() then
		CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	
  end
	
	if IOW:Mode() == "Harass"  then
	local target = GetCurrentTarget()
	    
		local SoldierRange = 0
		local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,950,80,false,true)
		local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,0,600,100,false,true)
		
	    for i = 1, #AzirSoldiers do 
	           if GoS:ValidTarget(target, 1500) and table.getn(AzirSoldiers) > 0 then
		   SoldierRange = GoS:GetDistance(AzirSoldiers[i], target)GoS:
		   end
		   
		   if CanUseSpell(myHero,_Q) and GoS:GetDistance(target) > 400 and GoS:ValidTarget(target, 950) and QPred.HitChance == 1 and Azir.h.Q:Value()then
		   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		   end
	    end
		
		if GoS:ValidTarget(target, 1500) and GoS:GetDistance(target) > 550 and table.getn(AzirSoldiers) > 0 and SoldierRange < 400 and Azir.h.AA:Value() then
		AttackUnit(target)
		end
		
		if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target,500) and WPred.HitChance == 1 and Azir.h.W:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if GoS:ValidTarget(target, 1500) and table.getn(AzirSoldiers) < 1 and QPred.HitChance == 1 and Azir.h.Q:Value() then
		CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,0,950,80,false,true)

		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 950) and Azir.Killsteal.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20*GetCastLevel(myHero,_Q)+45+.5*GetBonusAP(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
				if Ignite and Azir.Misc.Autoignite:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
	end
	
	if Azir.c.flee:Value() then
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
	
if Azir.Misc.Autolvl:Value() then  

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
if Azir.Drawings.Q:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if Azir.Drawings.W:Value()  then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if Azir.Drawings.E:Value()  then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if Azir.Drawings.R:Value()  then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end

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
  local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,500,950,700,false,true)
  if GoS:IsInDistance(target, 450) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS and Azir.Misc.Interrupt:Value() then
  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

AddGapcloseEvent(_R, 450, false)

PrintChat("Azir by Deftsu loaded.")
