return {
  ["Aatrox"] = {
		[_Q]  = { Name = "AatroxQ", ProjectileName = "AatroxQ.troy", Range = 650, Speed = 2000, Delay = 600, Width = 250, collision = false, type = "circular", IsDangerous = true}
		[_E]  = { Name = "AatroxE", ProjectileName = "AatroxBladeofTorment_mis.troy" , Range = 1075, Speed = 1250, Delay = 250, Width = 35, collision = false, type = "linear", IsDangerous = false}
	        [_R]  = { Name = "AatroxR", Range = 300} -- TODO : recheck radius
	}
  ["Ahri"] = {
		[_Q]  = { Name = "AhriOrbofDeception", ProjectileName = "Ahri_Orb_mis.troy", Range = 1000, Speed = 2500, Delay = 250, Width = 100, collision = false, type = "linear", IsDangerous = false}
 	        [_Q2] = { Name = "AhriOrbofDeceptionherpityderp", ProjectileName = "Ahri_Orb_mis_02.troy", Range = 1000, Speed = 900, Delay = 250, Width = 100, collision = false, type = "linear", IsDangerous = false}
		[_W]  = { Name = "AhriFoxFire", Range = 700},
		[_E]  = { Name = "AhriSeduce", ProjectileName = "Ahri_Charm_mis.troy", Range = 1000, Speed = 1550, Delay = 250,  Width = 60, collision = true, type = "linear", IsDangerous = true},
		[_R]  = { Name = "AhriTumble", Range = 550}
	}
}

Spellbook = [GetObjectName(myHero())]

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

function Cast(spell, target, hitchance, speed, delay, range, width, coll)
      hitchance = hitchance or 1
      speed = speed or Spellbook.Speed
      delay = delay or Spellbook.Delay
      range = range or Spellbook.Range
      width = width or Spellbook.Width
      coll = coll or Spellbook.collision
      local Predicted = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target), speed, delay, range, width, coll, true)
      if Predicted.HitChance > hitchance then
      CastSkillShot(spell, Predicted.PredPos.x, Predicted.PredPos.y, Predicted.PredPos.z)
      end
end

function myHeroPos()
    return GetOrigin(myHero) 
end

function mousePos()
    return GetMousePos()
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
  local objects = GoS:GetAllMinions(MINION_ENEMY)
  for i, object in pairs(objects) do
    local hit = CountObjectsNearPos(Vector(object), range, width, objects)
    if hit > BestHit and GoS:GetDistanceSqr(Vector(object)) < range^2 then
      BestHit = hit
      BestPos = Vector(object)
      if BestHit == #objects then
      break
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
    if Vector(object)) <= radius^2 then
    n = n + 1
    end
  end
  return n
end

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

-- Damage Lib soon(tm)
