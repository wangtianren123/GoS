SpellData = {
  ["Aatrox"] = {
		[_Q]  = { Name = "AatroxQ", ProjectileName = "AatroxQ.troy", Range = 650, Speed = 2000, Delay = 600, Width = 250, collision = false, type = "circular", IsDangerous = true},
		[_E]  = { Name = "AatroxE", ProjectileName = "AatroxBladeofTorment_mis.troy" , Range = 1075, Speed = 1250, Delay = 250, Width = 35, collision = false, type = "linear", IsDangerous = false},
	        [_R]  = { Name = "AatroxR", Range = 300}
	},
  ["Ahri"] = {
		[_Q]  = { Name = "AhriOrbofDeception", ProjectileName = "Ahri_Orb_mis.troy", Range = 1000, Speed = 2500, Delay = 250, Width = 100, collision = false, aoe = false, type = "linear", IsDangerous = false},
 	        --[_Q2] = { Name = "AhriOrbofDeceptionherpityderp", ProjectileName = "Ahri_Orb_mis_02.troy", Range = 1000, Speed = 900, Delay = 250, Width = 100, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_W]  = { Name = "AhriFoxFire", Range = 700},
		[_E]  = { Name = "AhriSeduce", ProjectileName = "Ahri_Charm_mis.troy", Range = 1000, Speed = 1550, Delay = 250,  Width = 60, collision = true, aoe = false, type = "linear", IsDangerous = true},
		[_R]  = { Name = "AhriTumble", Range = 550}
	},
  ["Alistar"] = {
		[_Q]  = { Name = "Pulverize", Range = 250, Delay = 250},
		[_W]  = { Name = "Headbutt", Range = 650},
	},
  ["Ashe"] = {
		[_Q]  = { Name = "FrostShot", Range = 600},
		[_W]  = { Name = "Volley", ProjectileName = "TODO", Range = 1250, Speed = 1500, Delay = 250, Width = 60, collision = true, aoe = false, type = "cone", IsDangerous = false},
		[_E]  = { Name = GetCastName(myHero,_E), Range = 20000, Speed = 1500, Delay = 500, Width = 1400, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_R]  = { Name = "EnchantedCrystalArrow", ProjectileName = "Ashe_Base_R_mis.troy", Range = 20000, Speed = 1600, Delay = 500, Width = 100, collision = false, aoe = false, type = "linear", IsDangerous = true}
        },
  ["Azir"] = {
		[_Q] = { Name = "AzirQ", Range = 950,  Speed = 1600, Width = 80, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_W] = { Name = "AzirW", Range = 850, Speed = math.huge, Width = 100, collision = false, aoe = false, type = "circular"},
		[_E] = { Name = "AzirE", Range = 1100, Speed = 1200, Delay = 250, Width = 60, collision = true, aoe = false, type = "linear", IsDangerous = false},
		[_R] = { Name = "AzirR", Range = 520, Speed = 1300, Delay = 250, Width = 600, collision = false, aoe = true, type = "linear", IsDangerous = true}
	},
  ["Blitzcrank"] = {
		[_Q] = { Name = "RocketGrabMissile", ProjectileName = "FistGrab_mis.troy", Range = 975, Speed = 1800, Width = 70, Delay = 250, collision = true, aoe = false, type = "linear", IsDangerous = true},
		[_E] = { Name = "PowerFist", Range = 225},
		[_R] = { Name = "StaticField", Range = 0, Speed = math.huge, Width = 600, Delay = 250, collision = false, aoe = false, type = "circular", IsDangerous = false}
	},
  ["Cassiopeia"] = {
		[_Q] = { Name = "CassiopeiaNoxiousBlast", ProjectileName = "", Range = 850, Speed = math.huge, Delay = 750, Width = 100, collision = false, aoe = true, type = "circular", IsDangerous = false},
		[_W] = { Name = "CassiopeiaMiasma", ProjectileName = "", Range = 925, Speed = 2500, Delay = 500, Width = 90, collision = false, aoe = true, type = "circular", IsDangerous = false},
		[_E] = { Name = "CassiopeiaTwinFang", Range = 700},
		[_R] = { Name = "CassiopeiaPetrifyingGaze",  ProjectileName = "", Range = 825, Speed = math.huge, Delay = 600, Width = 80, collision = false, aoe = true, type = "cone", IsDangerous = true}
	},
  ["Jinx"] = {
		[_W] = { Name = "JinxW", ProjectileName = "", Range = 1500, Speed = 3300, Delay = 600, Width = 60, collision = true, aoe = true, type = "circular", IsDangerous = true},
		[_R] = { Name = "JinxR",  ProjectileName = "", Range = 20000, Speed = 1700, Delay = 600, Width = 140, collision = false, aoe = true, type = "cone", IsDangerous = true}
	}
}

CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["Drain"]                       = {Name = "FiddleSticks", Spellslot = _W},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["FallenOne"]                   = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R},                        
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["UrgotSwap2"]                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                      = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R} 
}

GAPCLOSER_SPELLS = {
    ["AkaliShadowDance"]            = {Name = "Akali",      Spellslot = _R},
    ["Headbutt"]                    = {Name = "Alistar",    Spellslot = _W},
    ["DianaTeleport"]               = {Name = "Diana",      Spellslot = _R},
    ["FizzPiercingStrike"]          = {Name = "Fizz",       Spellslot = _Q},
    ["IreliaGatotsu"]               = {Name = "Irelia",     Spellslot = _Q},
    ["JaxLeapStrike"]               = {Name = "Jax",        Spellslot = _Q},
    ["JayceToTheSkies"]             = {Name = "Jayce",      Spellslot = _Q},
    ["blindmonkqtwo"]               = {Name = "LeeSin",     Spellslot = _Q},
    ["MaokaiUnstableGrowth"]        = {Name = "Maokai",     Spellslot = _W},
    ["MonkeyKingNimbus"]            = {Name = "MonkeyKing", Spellslot = _E},
    ["Pantheon_LeapBash"]           = {Name = "Pantheon",   Spellslot = _W},
    ["PoppyHeroicCharge"]           = {Name = "Poppy",      Spellslot = _E},
    ["QuinnE"]                      = {Name = "Quinn",      Spellslot = _E},
    ["RengarLeap"]                  = {Name = "Rengar",     Spellslot = _R},
    ["XenZhaoSweep"]                = {Name = "XinZhao",    Spellslot = _E}
}

GAPCLOSER2_SPELLS = {
    ["AatroxQ"]                     = {Name = "Aatrox",     Range = 1000, ProjectileSpeed = 1200, Spellslot = _Q},
    ["GragasE"]                     = {Name = "Gragas",     Range = 600,  ProjectileSpeed = 2000, Spellslot = _E},
    ["GravesMove"]                  = {Name = "Graves",     Range = 425,  ProjectileSpeed = 2000, Spellslot = _E},
    ["HecarimUlt"]                  = {Name = "Hecarim",    Range = 1000, ProjectileSpeed = 1200, Spellslot = _R},
    ["JarvanIVDragonStrike"]        = {Name = "JarvanIV",   Range = 770,  ProjectileSpeed = 2000, Spellslot = _Q},
    ["JarvanIVCataclysm"]           = {Name = "JarvanIV",   Range = 650,  ProjectileSpeed = 2000, Spellslot = _R},
    ["KhazixE"]                     = {Name = "Khazix",     Range = 900,  ProjectileSpeed = 2000, Spellslot = _E},
    ["khazixelong"]                 = {Name = "Khazix",     Range = 900,  ProjectileSpeed = 2000, Spellslot = _E},
    ["LeblancSlide"]                = {Name = "Leblanc",    Range = 600,  ProjectileSpeed = 2000, Spellslot = _W},
    ["LeblancSlideM"]               = {Name = "Leblanc",    Range = 600,  ProjectileSpeed = 2000, Spellslot = _R},
    ["LeonaZenithBlade"]            = {Name = "Leona",      Range = 900,  ProjectileSpeed = 2000, Spellslot = _E},
    ["UFSlash"]                     = {Name = "Malphite",   Range = 1000, ProjectileSpeed = 1800, Spellslot = _R},
    ["RenektonSliceAndDice"]        = {Name = "Renekton",   Range = 450,  ProjectileSpeed = 2000, Spellslot = _E},
    ["SejuaniArcticAssault"]        = {Name = "Sejuani",    Range = 650,  ProjectileSpeed = 2000, Spellslot = _Q},
    ["ShenShadowDash"]              = {Name = "Shen",       Range = 575,  ProjectileSpeed = 2000, Spellslot = _E},
    ["RocketJump"]                  = {Name = "Tristana",   Range = 900,  ProjectileSpeed = 2000, Spellslot = _W},
    ["slashCast"]                   = {Name = "Tryndamere", Range = 650,  ProjectileSpeed = 1450, Spellslot = _E}
}

Dashes = {
    ["Vayne"]          = {Spellslot = _Q, Range = 300, Delay = 250},
    ["Riven"]           = {Spellslot = _E, Range = 325, Delay = 250},
    ["Ezreal"]          = {Spellslot = _E, Range = 450, Delay = 250},
    ["Caitlyn"]         = {Spellslot = _E, Range = 400, Delay = 250},
    ["Kassadin"]     = {Spellslot = _R, Range = 700, Delay = 250},
    ["Graves"]         = {Spellslot = _E, Range = 425, Delay = 250},
    ["Renekton"]     = {Spellslot = _E, Range = 450, Delay = 250},
    ["Aatrox"]          = {Spellslot = _Q, Range = 650, Delay = 250},
    ["Gragas"]         = {Spellslot = _E, Range = 600, delay = 250},
    ["Khazix"]          = {Spellslot = _E, Range = 600, Delay = 250},
    ["Lucian"]          = {Spellslot = _E, Range = 425, Delay = 250},
    ["Sejuani"]        = {Spellslot = _Q, Range = 650, Delay = 250},
    ["Shen"]             = {Spellslot = _E, Range = 575, Delay = 250},
    ["Tryndamere"] = {Spellslot = _E, Range = 660, Delay = 250},
    ["Tristana"]        = {Spellslot = _W, Range = 900, Delay = 250},
    ["Corki"]              = {Spellslot = _W, Range = 800, Delay = 250},
}

LudensStacks = 0
myHero = GetMyHero()
mapID = GetMapID()
Barrier = (GetCastName(myHero,SUMMONER_1):lower():find("summonerbarrier") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerbarrier") and SUMMONER_2 or nil))
ClairVoyance = (GetCastName(myHero,SUMMONER_1):lower():find("summonerclairvoyance") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerclairvoyance") and SUMMONER_2 or nil)) 
Clarity = (GetCastName(myHero,SUMMONER_1):lower():find("summonermana") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonermana") and SUMMONER_2 or nil)) 
Cleanse = (GetCastName(myHero,SUMMONER_1):lower():find("summonerboost") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerboost") and SUMMONER_2 or nil)) 
Exhaust = (GetCastName(myHero,SUMMONER_1):lower():find("summonerexhaust") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerexhaust") and SUMMONER_2 or nil))
Flash = (GetCastName(myHero,SUMMONER_1):lower():find("summonerflash") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerflash") and SUMMONER_2 or nil)) 
Garrison = (GetCastName(myHero,SUMMONER_1):lower():find("summonerodingarrison") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerodingarrison") and SUMMONER_2 or nil))
Ghost = (GetCastName(myHero,SUMMONER_1):lower():find("summonerhaste") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerhaste") and SUMMONER_2 or nil))
Heal = (GetCastName(myHero,SUMMONER_1):lower():find("summonerheal") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerheal") and SUMMONER_2 or nil))
Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
Smite = (GetCastName(myHero,SUMMONER_1):lower():find("summonersmite") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonersmite") and SUMMONER_2 or nil))
SmiteBlue = (GetCastName(myHero,SUMMONER_1):lower():find("s5_summonersmiteplayerganker") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("s5_summonersmiteplayerganker") and SUMMONER_2 or nil))
SmiteGrey = (GetCastName(myHero,SUMMONER_1):lower():find("s5_summonersmitequick") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("s5_summonersmitequick") and SUMMONER_2 or nil))
SmitePurple = (GetCastName(myHero,SUMMONER_1):lower():find("itemsmiteaoe") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("itemsmiteaoe") and SUMMONER_2 or nil)) 
SmiteRed = (GetCastName(myHero,SUMMONER_1):lower():find("s5_summonersmiteduel") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("s5_summonersmiteduel") and SUMMONER_2 or nil))
Snowball = (GetCastName(myHero,SUMMONER_1):lower():find("summonersnowball") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonersnowball") and SUMMONER_2 or nil))
Teleport = (GetCastName(myHero,SUMMONER_1):lower():find("summonerteleport") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerteleport") and SUMMONER_2 or nil))

function IsReady(spell)
	return CanUseSpell(myHero,spell) == READY
end

function Cast(spell, target, hitchance, speed, delay, range, width, coll)
      hitchance = hitchance or 1
      speed = speed or  SpellData[GetObjectName(myHero)][spell].Speed or math.huge
      delay = delay or  SpellData[GetObjectName(myHero)][spell].Delay or 0
      range = range or  SpellData[GetObjectName(myHero)][spell].Range
      width = width or  SpellData[GetObjectName(myHero)][spell].Width
      coll = coll or  SpellData[GetObjectName(myHero)][spell].collision
      local Predicted = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target), speed, delay, range, width, coll, true)
      if Predicted.HitChance >= hitchance then
      CastSkillShot(spell, Predicted.PredPos.x, Predicted.PredPos.y, Predicted.PredPos.z)
      end
end

function mousePos()
    return GetMousePos()
end

function Ludens()
    return LudensStacks == 100 and 100+0.1*GetBonusAP(myHero) or 0
end

IsRecalling = false
IsCCed = false
SpellShieldTable = {}
ccbuffsTable = {5,9,21,22,28,29,30}
ccnameTable = {"zedultexecute", "summonerexhaust"}
RecallTable = {"Recall", "RecallImproved", "OdinRecall"}

OnUpdateBuff(function(Object,buff)
  if Object == myHero then
    if buff.Name == "itemmagicshankcharge" then 
    LudensStacks = buff.Count
    end
    
    for i = 1, #RecallTable do
      if buff.Name == RecallTable[i] then 
      IsRecalling = true
      end
    end
    
    for i = 1, #ccbuffsTable do
      if buff.Type == ccbuffsTable[i] or buff.Name == "zedultexecute" or buff.Name == "summonerexhaust"  then 
      IsCCed = true
      end
    end
  end

  if GetTeam(Object) ~= GetTeam(myHero) and buff.Type == 15 then
  SpellShieldTable[GetNetworkID(Object)] = buff.Count
  end

end)

OnRemoveBuff(function(Object,buff)
  if Object == myHero then
    if buff.Name == "itemmagicshankcharge" then 
    LudensStacks = 0
    end

    for i = 1, #ccbuffsTable do
      if buff.Type == ccbuffsTable[i] or buff.Name == "zedultexecute" or buff.Name == "summonerexhaust"  then 
      IsCCed = false
      end
    end
  end

  for i = 1, #RecallTable do
    if buff.Name == RecallTable[i] then 
    IsRecalling = false
    end
  end

  if GetTeam(Object) ~= GetTeam(myHero) and buff.Type == 15 then
  SpellShieldTable[GetNetworkID(Object)] = 0
  end

end)

function IsSpellShielded(unit)
   return (SpellShieldTable[GetNetworkID(unit)] or 0) > 0
end

function GetLineFarmPosition(range, width)
    local BestPos 
    local BestHit = 0
    local objects = GoS:GetAllMinions(MINION_ENEMY)
    for i, object in pairs(objects) do
      local EndPos = Vector(myHero) + range * (Vector(object) - Vector(myHero)):normalized()
      local hit = CountObjectsOnLineSegment(GetOrigin(myHero), EndPos, width, objects)
      if hit > BestHit and GoS:GetDistanceSqr(GetOrigin(object)) < range^2 then
        BestHit = hit
        BestPos = Vector(object)
        if BestHit == #objects then
        break
        end
      end
    end
    return BestPos, BestHit
end

function GetFarmPosition(range, width)
  local BestPos 
  local BestHit = 0
  local objects = minionManager.objects
  for i, object in pairs(objects) do
  	if GetOrigin(object) ~= nil and IsObjectAlive(object) and GetTeam(object) ~= GetTeam(myHero) then
	  	local hit = CountObjectsNearPos(Vector(object), range, width, objects)
	    if hit > BestHit and GoS:GetDistanceSqr(Vector(object)) < range * range then
	      BestHit = hit
	      BestPos = Vector(object)
	      if BestHit == #objects then
	        break
	      end
	    end
	end
  end
  return BestPos, BestHit
end

function GetJLineFarmPosition(range, width)
    local BestPos 
    local BestHit = 0
    local objects = GoS:GetAllMinions(MINION_JUNGLE)
    for i, object in pairs(objects) do
      local EndPos = Vector(myHero) + range * (Vector(object) - Vector(myHero)):normalized()
      local hit = CountObjectsOnLineSegment(GetOrigin(myHero), EndPos, width, objects)
      if hit > BestHit and GoS:GetDistanceSqr(GetOrigin(object)) < range * range then
        BestHit = hit
        BestPos = Vector(object)
        if BestHit == #objects then
        break
        end
      end
    end
    return BestPos, BestHit
end

function GetJFarmPosition(range, width)
  local BestPos 
  local BestHit = 0
  local objects = GoS:GetAllMinions(MINION_JUNGLE)
  for i, object in pairs(objects) do
    local hit = CountObjectsNearPos(Vector(object), range, width, objects)
    if hit > BestHit and GoS:GetDistanceSqr(Vector(object)) < range * range then
      BestHit = hit
      BestPos = Vector(object)
      if BestHit == #objects then
      break
      end
    end
  end
  return BestPos, BestHit
end

function CountObjectsOnLineSegment(StartPos, EndPos, width, objects)
  local n = 0
  for i, object in pairs(objects) do
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(StartPos, EndPos, GetOrigin(object))
    local w = width
    if isOnSegment and GoS:GetDistanceSqr(pointSegment, GetOrigin(object)) < w^2 and GoS:GetDistanceSqr(StartPos, EndPos) > GoS:GetDistanceSqr(StartPos, GetOrigin(object)) then
    n = n + 1
    end
  end
  return n
end

function CountObjectsNearPos(pos, range, radius, objects)
  local n = 0
  for i, object in pairs(objects) do
    if IsObjectAlive(object) and GoS:GetDistanceSqr(pos, Vector(object)) <= radius^2 then
      n = n + 1
    end
  end
  return n
end

function HeroCollision(target, spell, range, width) 
    for i, enemy in ipairs(GoS:GetEnemyHeroes()) do
        if GoS:ValidTarget(enemy) and GoS:GetDistanceSqr(enemy) < math.pow(range * 1.5, 2) then
            local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), Vector(target), Vector(enemy))
            if (GoS:GetDistanceSqr(enemy, pointSegment) <= math.pow(GetHitBox(enemy) * 2 + width, 2)) then
                return true
            end
        end
    end
    return false
end

--Credits to Maxxxel For IsFacing
local lastattackposition={true,true,true}

function IsFacing(targetFace,range,unit) 
	range=range or 99999
	unit=unit or myHero
	targetFace=targetFace
	if (targetFace and unit)~=nil and (GoS:ValidTarget(targetFace,range,unit)) and GoS:GetDistance(targetFace,unit)<=range then
		local unitXYZ= GetOrigin(unit)
		local targetFaceXYZ=GetOrigin(targetFace)
		local lastwalkway={true,true,true}
		local walkway = GetPredictionForPlayer(GetOrigin(unit),targetFace,GetMoveSpeed(targetFace),0,1000,2000,0,false,false)

		if walkway.PredPos.x==targetFaceXYZ.x then

		if lastwalkway.x~=nil then

		local d1 = GoS:GetDistance(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1


    	elseif lastwalkway.x==nil then
    		if lastattackposition.x~=nil and lastattackposition.name==GetObjectName(targetFace) then
			local d1 = GoS:GetDistance(targetFace,unit)
    			local d2 = GetDistance2XYZ(lastattackposition.x,lastattackposition.z,unitXYZ.x,unitXYZ.z)
    			return d2 < d1
    		end
    	end
    elseif walkway.PredPos.x~=targetFaceXYZ.x then
    	lastwalkway={x=walkway.PredPos.x,y=walkway.PredPos.y,z=walkway.PredPos.z} 

    	if lastwalkway.x~=nil then
		local d1 = GoS:GetDistance(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1
    	end
    end
	end
end

function GetDistance2XYZ(x,z,x2,z2)
	if (x and z and x2 and z2)~=nil then
		a=x2-x
		b=z2-z
		if (a and b)~=nil then
			a2=a*a
			b2=b*b
			if (a2 and b2)~=nil then
				return math.sqrt(a2+b2)
			else
				return 99999
			end
		else
			return 99999
		end
	end	
end

OnProcessSpell(function(unit,spell)
	if unit and spell and GetObjectType(unit) == Obj_AI_Hero then
			for i,enemy in pairs(GoS:GetEnemyHeroes()) do
				if GoS:ValidTarget(enemy,25000) then
					local targetFaceXYZ=GetOrigin(enemy)
					if (spell.name:find("Attack")) then 
						if spell.startPos.x == targetFaceXYZ.x and spell.startPos.y == targetFaceXYZ.y and spell.startPos.z == targetFaceXYZ.z then 
							if spell.endPos.x ~= targetFaceXYZ.x and spell.endPos.y ~= targetFaceXYZ.y and spell.endPos.z ~= targetFaceXYZ.z then 
								lastattackposition = {x=spell.endPos.x,y=spell.endPos.y,z=spell.endPos.z,Name=GetObjectName(enemy)}
								break
							else
								break
							end
						else
							break
						end
					else
						break
					end
				else
					break
		        	end
                     end
	end
end)

-- Credits To Inferno for MEC
local SQRT = math.sqrt

function TargetDist(point, target)
    local origin = GetOrigin(target)
    local dx, dz = origin.x-point.x, origin.z-point.z
    return SQRT( dx*dx + dz*dz )
end

function ExcludeFurthest(point, tbl)
    local removalId = 1
    for i=2, #tbl do
        if TargetDist(point, tbl[i]) > TargetDist(point, tbl[removalId]) then
            removalId = i
        end
    end
    
    local newTable = {}
    for i=1, #tbl do
        if i ~= removalId then
            newTable[#newTable+1] = tbl[i]
        end
    end
    return newTable
end

function GetMEC(aoe_radius, listOfEntities, starTarget)
    local average = {x=0, y=0, z=0, count = 0}
    for i=1, #listOfEntities do
        local ori = GetOrigin(listOfEntities[i])
        average.x = average.x + ori.x
        average.y = average.y + ori.y
        average.z = average.z + ori.z
        average.count = average.count + 1
    end
    if starTarget then
        local ori = GetOrigin(starTarget)
        average.x = average.x + ori.x
        average.y = average.y + ori.y
        average.z = average.z + ori.z
        average.count = average.count + 1
    end
    average.x = average.x / average.count
    average.y = average.y / average.count
    average.z = average.z / average.count
    
    local targetsInRange = 0
    for i=1, #listOfEntities do
        if TargetDist(average, listOfEntities[i]) <= aoe_radius then
            targetsInRange = targetsInRange + 1
        end
    end
    if starTarget and TargetDist(average, starTarget) <= aoe_radius then
        targetsInRange = targetsInRange + 1
    end
    
    if targetsInRange == average.count then
        return average
    else
        return GetMEC(aoe_radius, ExcludeFurthest(average, listOfEntities), starTarget)
    end
end

Items = {
		BRK = { id = 3153, range = 550, reqTarget = true, slot = nil },
		BWC = { id = 3144, range = 400, reqTarget = true, slot = nil },
		HGB = { id = 3146, range = 400, reqTarget = true, slot = nil },
		RSH = { id = 3074, range = 350, reqTarget = false, slot = nil },
		STD = { id = 3131, range = 350, reqTarget = false, slot = nil },
		TMT = { id = 3077, range = 350, reqTarget = false, slot = nil },
		YGB = { id = 3142, range = 350, reqTarget = false, slot = nil },
		BFT = { id = 3188, range = 750, reqTarget = true, slot = nil },
		RND = { id = 3143, range = 275, reqTarget = false, slot = nil }
	}
	
-- Damage Lib soon(tm)
