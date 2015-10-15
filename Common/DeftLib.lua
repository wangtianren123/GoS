SpellData = {
  ["Aatrox"] = {
		[_Q]  = { Name = "AatroxQ", ProjectileName = "AatroxQ.troy", Range = 650, Speed = 2000, Delay = 600, Width = 250, collision = false, type = "circular", IsDangerous = true},
		[_E]  = { Name = "AatroxE", ProjectileName = "AatroxBladeofTorment_mis.troy" , Range = 1075, Speed = 1250, Delay = 250, Width = 35, collision = false, type = "linear", IsDangerous = false},
	        [_R]  = { Name = "AatroxR", Range = 300}
	},
  ["Ahri"] = {
		[_Q]  = { Name = "AhriOrbofDeception", ProjectileName = "Ahri_Orb_mis.troy", Range = 1000, Speed = 2500, Delay = 250, Width = 100, collision = false, aoe = false, type = "linear", IsDangerous = false},
 	        [_Q2] = { Name = "AhriOrbofDeceptionherpityderp", ProjectileName = "Ahri_Orb_mis_02.troy", Range = 1000, Speed = 900, Delay = 250, Width = 100, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_W]  = { Name = "AhriFoxFire", Range = 700},
		[_E]  = { Name = "AhriSeduce", ProjectileName = "Ahri_Charm_mis.troy", Range = 1000, Speed = 1550, Delay = 250,  Width = 60, collision = true, aoe = false, type = "linear", IsDangerous = true},
		[_R]  = { Name = "AhriTumble", Range = 550}
	},
  ["Ashe"] = {
		[_Q]  = { Name = GetCastName(myHero,_Q), Range = 700},
		[_W]  = { Name = "Volley", ProjectileName = "", Range = 1250, Speed = 1500, Delay = 250, Width = 60, collision = true, aoe = false, type = "cone", IsDangerous = false},
		[_E]  = { Name = GetCastName(myHero,_E), Range = 20000, Speed = 1500, Delay = 500, Width = 1400, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_R]  = { Name = "EnchantedCrystalArrow", ProjectileName = "Ashe_Base_R_mis.troy", Range = 20000, Speed = 1600, Delay = 500, Width = 100, collision = true, aoe = false, type = "linear", IsDangerous = true}
        },
  ["Azir"] = {
		[_Q] = { Name = "AzirQ", ProjectileName = "", Range = 950,  Speed = 1600, Width = 80, collision = false, aoe = false, type = "linear", IsDangerous = false},
		[_W] = { Name = "AzirW", Range = 850, Speed = math.huge, Width = 100, collision = false, aoe = false, type = "circular"},
		[_E] = { Name = "AzirE", Range = 1100, Speed = 1200, Delay = 250, Width = 60, collision = true, aoe = false, type = "linear", IsDangerous = false},
		[_R] = { Name = "AzirR", Range = 520, Speed = 1300, Delay = 250, Width = 600, collision = false, aoe = true, type = "linear", IsDangerous = true}
	},
  ["Blitzcrank"] = {
		[_Q] = { name = "RocketGrabMissile", Range = 1000, Speed = 1800, Width = 70, Delay = 250, collision = true, type = "linear", IsDangerous = true},
		[_E] = { name = "", Range = 225},
		[_R] = { name = "StaticField", Range = 0, Speed = math.huge, Width = 500, Delay = 250, collision = false, aoe = false, type = "circular", IsDangerous = false}
	},
  ["Cassiopeia"] = {
		[_Q] = { name = "CassiopeiaNoxiousBlast", ProjectileName = "", Range = 850, Speed = math.huge, Delay = 750, Width = 100, collision = false, aoe = true, type = "circular", IsDangerous = false},
		[_W] = { name = "CassiopeiaMiasma", ProjectileName = "", Range = 925, Speed = 2500, Delay = 500, Width = 90, collision = false, aoe = true, type = "circular", IsDangerous = false},
		[_E] = { name = "CassiopeiaTwinFang", Range = 700},
		[_R] = { name = "CassiopeiaPetrifyingGaze",  ProjectileName = "", Range = 825, Speed = math.huge, Delay = 600, Width = 80, collision = false, aoe = true, type = "cone", IsDangerous = true}
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

Spellbook = SpellData[GetObjectName(myHero)]

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
      speed = speed or Spellbook.Speed or math.huge
      delay = delay or Spellbook.Delay or 0
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

function GetDmg(spell, source, target)
    if target == nil or source == nil then
      return
    end
    local ADDmg  = 0
    local APDmg  = 0
    local TRUEDmg  = 0
    local AP     = GetBonusAP(myHero)
    local Level  = GetLevel(myHero)
    local TotalDmg   = GetBaseDamage(myHero)+GetBonusDmg(myHero)
    local ArmorPen = GetObjectType(source) == Obj_AI_Minion and 0 or math.floor(GetArmorPenFlat(source))
    local ArmorPenPercent = GetObjectType(source) == Obj_AI_Minion and 1 or math.floor(GetArmorPenPercent(source)*100)/100
    local Armor = GetArmor(target)*ArmorPenPercent-ArmorPen
    local ArmorPercent = (GetObjectType(source) == Obj_AI_Minion and Armor < 0) and 0 or Armor > 0 and math.floor(Armor*100/(100+Armor))/100 or math.ceil(Armor*100/(100-Armor))/100
    local MagicPen = math.floor(GetMagicPenFlat(source))
    local MagicPenPercent = math.floor(GetMagicPenPercent(source)*100)/100
    local MagicArmor = GetMagicResist(target)*MagicPenPercent-MagicPen
    local MagicArmorPercent = MagicArmor > 0 and math.floor(MagicArmor*100/(100+MagicArmor))/100 or math.ceil(MagicArmor*100/(100-MagicArmor))/100
    if spell == "IGNITE" then
      return 50+20*Level
    elseif spell == "AD" then
    ADDmg = TotalDmg
    end
    dmg = math.floor(ADDmg*(1-ArmorPercent))+math.floor(APDmg*(1-MagicArmorPercent))+TRUEDmg
    return math.floor(dmg)
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
    if Vector(object) <= radius^2 then
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

priorityTable = {
		AP = {
	        	"Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
	        	"Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
	        	"Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Velkoz", "Vladimir", "Xerath", "Ziggs", "Zyra"
		},
			
		Support = {
	        	"Alistar", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", "Taric", "Thresh", "Zilean", "Braum"
		},
			
		Tank = {
	        	"Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Nautilus", "Shen", "Singed", "Skarner", "Volibear",
	        	"Warwick", "Yorick", "Zac"
		},
			
	        AD_Carry = {
        		"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "Jinx", "KogMaw", "Lucian", "MasterYi", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
         		"Talon","Tryndamere", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Yasuo", "Zed"
		},
			
  		Bruiser = {
        		"Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nocturne", "Olaf", "Poppy",
        		"Renekton", "Rengar", "Riven", "Rumble", "Shyvana", "Trundle", "Udyr", "Vi", "MonkeyKing", "XinZhao"
		}
	}

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
	

WallSpots = {
      {
        x = 8260,
        y = 51,
        z = 2890,
        x2 = 8210,
        y2 = 51.75,
        z2 = 3165
      },
      {
        x = 4630,
        y = 95.7,
        z = 3020,
        x2 = 4924,
        y2 = 50.98,
        z2 = 3058
      },
      {
        x = 4924,
        y = 51,
        z = 3058,
        x2 = 4594,
        y2 = 95,
        z2 = 2964
      },
      {
        x = 8222,
        y = 51,
        z = 3158,
        x2 = 8300,
        y2 = 51,
        z2 = 2888
      },
      {
        x = 11872,
        y = -72,
        z = 4358,
        x2 = 12072,
        y2 = 51,
        z2 = 4608
      },
      {
        x = 12072,
        y = 51,
        z = 4608,
        x2 = 11818,
        y2 = -71,
        z2 = 4456
      },
      {
        x = 10772,
        y = 51,
        z = 7208,
        x2 = 10738,
        y2 = 52,
        z2 = 7450
      },
      {
        x = 10738,
        y = 52,
        z = 7450,
        x2 = 10772,
        y2 = 51,
        z2 = 7208
      },
      {
        x = 11572,
        y = 52,
        z = 8706,
        x2 = 11768,
        y2 = 51,
        z2 = 8904
      },
      {
        x = 11768,
        y = 51,
        z = 8904,
        x2 = 11572,
        y2 = 52,
        z2 = 8706
      },
      {
        x = 7972,
        y = 51,
        z = 5908,
        x2 = 8002,
        y2 = 52,
        z2 = 6208
      },
      {
        x = 7194,
        y = 51,
        z = 5630,
        x2 = 7372,
        y2 = 52,
        z2 = 5858
      },
      {
        x = 7372,
        y = 52,
        z = 5858,
        x2 = 7194,
        y2 = 51,
        z2 = 5630
      },
      {
        x = 7572,
        y = 51,
        z = 6158,
        x2 = 7718,
        y2 = 52,
        z2 = 6420
      },
      {
        x = 7024,
        y = -71,
        z = 8406,
        x2 = 7224,
        y2 = 53,
        z2 = 8556
      },
      {
        x = 7224,
        y = 53,
        z = 8556,
        x2 = 7088,
        y2 = -71,
        z2 = 8378
      },
      {
        x = 8204,
        y = -71,
        z = 6080,
        x2 = 8058,
        y2 = 51,
        z2 = 5838
      },
      {
        x = 7772,
        y = -49,
        z = 6358,
        x2 = 7610,
        y2 = 52,
        z2 = 6128
      },
      {
        x = 5774,
        y = 55,
        z = 10656,
        x2 = 5430,
        y2 = -71,
        z2 = 10640
      },
      {
        x = 5474,
        y = -71.2406,
        z = 10665,
        x2 = 5754,
        y2 = 55.9,
        z2 = 10718
      },
      {
        x = 3666,
        y = 51.8,
        z = 7430,
        x2 = 3674,
        y2 = 51.7,
        z2 = 7706
      },
      {
        x = 3672,
        y = 51.7,
        z = 7686,
        x2 = 3774,
        y2 = 51.8,
        z2 = 7408
      },
      {
        x = 3274,
        y = 52.46,
        z = 6208,
        x2 = 3086,
        y2 = 57,
        z2 = 6032
      },
      {
        x = 3086,
        y = 57,
        z = 6032,
        x2 = 3274,
        y2 = 52.46,
        z2 = 6208
      },
      {
        x = 5126,
        y = -71,
        z = 9988,
        x2 = 5130,
        y2 = -70,
        z2 = 9664
      },
      {
        x2 = 5126,
        y2 = -71,
        z2 = 9988,
        x = 5018,
        y = -70,
        z = 9734
      },
      {
        x = 10462,
        y = -71,
        z = 4352,
        x2 = 10660,
        y2 = -72,
        z2 = 4488
      },
      {
        x = 6582,
        y = 53.8,
        z = 11694,
        x2 = 6516,
        y2 = 56.4,
        z2 = 11990
      },
      {
        x = 6516,
        y = 56.4,
        z = 11990,
        x2 = 6582,
        y2 = 53.8,
        z2 = 11694
      },
      {
        x = 5231,
        y = 56.4,
        z = 12092,
        x2 = 5212,
        y2 = 56.8,
        z2 = 11794
      },
      {
        x = 5212,
        y = 56.8,
        z = 11794,
        x2 = 5231,
        y2 = 56.4,
        z2 = 12092
      },
      {
        x = 9654,
        y = 64,
        z = 3052,
        x2 = 9630,
        y2 = 49.2,
        z2 = 2794
      },
      {
        x = 9630,
        y = 49.2,
        z = 2794,
        x2 = 9654,
        y2 = 64,
        z2 = 3052
      },
      {
        x = 3324,
        y = -64,
        z = 10160,
        x2 = 3124,
        y2 = 53,
        z2 = 9956
      },
      {
        x = 3124,
        y = 53,
        z = 9956,
        x2 = 3324,
        y2 = -64,
        z2 = 10160
      },
      {
        x = 9314,
        y = -71.24,
        z = 4518,
        x2 = 9022,
        y2 = 52.44,
        z2 = 4508
      },
      {
        x = 4424,
        y = 49.11,
        z = 8056,
        x2 = 4134,
        y2 = 50.53,
        z2 = 7986
      },
      {
        x = 4134,
        y = 50.53,
        z = 7986,
        x2 = 4424,
        y2 = 49.11,
        z2 = 8056
      },
      {
        x = 2596,
        y = 51.7,
        z = 9228,
        x2 = 2874,
        y2 = 50.6,
        z2 = 9256
      },
      {
        x = 2874,
        y = 50.6,
        z = 9256,
        x2 = 2596,
        y2 = 51.7,
        z2 = 9228
      },
      {
        x = 11722,
        y = 51.7,
        z = 5024,
        x2 = 11556,
        y2 = -71.24,
        z2 = 4870
      },
      {
        x = 11556,
        y = -71.24,
        z = 4870,
        x2 = 11722,
        y2 = 51.7,
        z2 = 5024
      },
      {
        x = 2924,
        y = 53.5,
        z = 4958,
        x2 = 2894,
        y2 = 95.7,
        z2 = 4648
      },
      {
        x2 = 2924,
        y2 = 53.5,
        z2 = 4958,
        x = 2894,
        y = 95.7,
        z = 4648
      },
      {
        x = 11922,
        y = 51.7,
        z = 4758,
        x2 = 11772,
        y2 = -71.24,
        z2 = 4608
      },
      {
        x = 11772,
        y = -71.24,
        z = 4608,
        x2 = 11922,
        y2 = 51.7,
        z2 = 4758
      },
      {
        x = 11592,
        y = 52.8,
        z = 5316,
        x2 = 11342,
        y2 = -61,
        z2 = 5274
      },
      {
        x2 = 11592,
        y2 = 52.8,
        z2 = 5316,
        x = 11342,
        y = -61,
        z = 5274
      },
      {
        x = 10694,
        y = -70.24,
        z = 4526,
        x2 = 10472,
        y2 = -71.24,
        z2 = 4408
      },
      {
        x = 9722,
        y = -71.24,
        z = 4908,
        x2 = 9700,
        y2 = -72.5,
        z2 = 5198
      },
      {
        x2 = 9722,
        y2 = -71.24,
        z2 = 4908,
        x = 9700,
        y = -72.5,
        z = 5198
      },
      {
        x = 6126,
        y = 48.5,
        z = 5304,
        x2 = 6090,
        y2 = 51.7,
        z2 = 5572
      },
      {
        x2 = 6126,
        y2 = 48.5,
        z2 = 5304,
        x = 6090,
        y = 51.7,
        z = 5572
      },
      {
        x = 3388,
        y = 95.7,
        z = 4414,
        x2 = 3524,
        y2 = 54.15,
        z2 = 4708
      },
      {
        x = 3108,
        y = 51.5,
        z = 6428,
        x2 = 2924,
        y2 = 57,
        z2 = 6208
      },
      {
        x2 = 3108,
        y2 = 51.5,
        z2 = 6428,
        x = 2924,
        y = 57,
        z = 6208
      },
      {
        x2 = 2824,
        y2 = 56.4,
        z2 = 6708,
        x = 3074,
        y = 51.5,
        z = 6758
      },
      {
        x = 2824,
        y = 56.4,
        z = 6708,
        x2 = 3074,
        y2 = 51.5,
        z2 = 6758
      },
      {
        x = 11860,
        y = 52.3,
        z = 10032,
        x2 = 11914,
        y2 = 91.4,
        z2 = 10360
      },
      {
        x2 = 11860,
        y2 = 52.3,
        z2 = 10032,
        x = 11914,
        y = 91.4,
        z = 10360
      },
      {
        x2 = 12372,
        y2 = 91.4,
        z2 = 10256,
        x = 12272,
        y = 52.3,
        z = 9956
      },
      {
        x = 12372,
        y = 91.4,
        z = 10256,
        x2 = 12272,
        y2 = 52.3,
        z2 = 9956
      },
      {
        x = 11772,
        y = 54.54,
        z = 8206,
        x2 = 12072,
        y2 = 52.3,
        z2 = 8156
      },
      {
        x2 = 11772,
        y2 = 54.54,
        z2 = 8206,
        x = 12072,
        y = 52.3,
        z = 8156
      },
      {
        x2 = 11338,
        y2 = 52.2,
        z2 = 7496,
        x = 11372,
        y = 51.7,
        z = 7208
      },
      {
        x = 11338,
        y = 52.2,
        z = 7496,
        x2 = 11372,
        y2 = 51.7,
        z2 = 7208
      },
      {
        x = 12272,
        y = 51.7,
        z = 5408,
        x2 = 12034,
        y2 = 54.6,
        z2 = 5420
      },
      {
        x2 = 12272,
        y2 = 51.7,
        z2 = 5408,
        x = 12034,
        y = 54.6,
        z = 5420
      },
      {
        x = 10432,
        y = 51.9,
        z = 6768,
        x2 = 10712,
        y2 = 51.7,
        z2 = 6906
      },
      {
        x = 12272,
        y = 52.6,
        z = 5558,
        x2 = 11966,
        y2 = 53.5,
        z2 = 5592
      },
      {
        x2 = 12272,
        y2 = 52.6,
        z2 = 5558,
        x = 11966,
        y = 53.5,
        z = 5592
      },
      {
        x2 = 6824,
        y2 = -71.24,
        z2 = 8606,
        x = 6924,
        y = 52.8,
        z = 8856
      },
      {
        x = 6824,
        y = -71.24,
        z = 8606,
        x2 = 6924,
        y2 = 52.8,
        z2 = 8856
      },
      {
        x = 4908,
        y = 56.6,
        z = 11884,
        x2 = 4974,
        y2 = 56.4,
        z2 = 12102
      },
      {
        x2 = 4908,
        y2 = 56.6,
        z2 = 11884,
        x = 4974,
        y = 56.4,
        z = 12102
      },
      {
        x2 = 3474,
        y2 = -64.6,
        z2 = 9806,
        x = 3208,
        y = 51.4,
        z = 9696
      },
      {
        x = 3474,
        y = -64.6,
        z = 9806,
        x2 = 3208,
        y2 = 51.4,
        z2 = 9696
      },
      {
        x = 2574,
        y = 53,
        z = 9456,
        x2 = 2832,
        y2 = 51.2,
        z2 = 9480
      },
      {
        x2 = 2574,
        y2 = 53,
        z2 = 9456,
        x = 2832,
        y = 51.2,
        z = 9480
      },
      {
        x2 = 4474,
        y2 = -71.2,
        z2 = 10456,
        x = 4234,
        y = -71.2,
        z = 10306
      },
      {
        x = 4474,
        y = -71.2,
        z = 10456,
        x2 = 4234,
        y2 = -71.2,
        z2 = 10306
      },
      {
        x = 8086,
        y = 51.8,
        z = 9684,
        x2 = 8396,
        y2 = 50.3,
        z2 = 9672
      },
      {
        x2 = 9972,
        y2 = 52.3,
        z2 = 11756,
        x = 10278,
        y = 91.4,
        z = 11858
      },
      {
        x = 9972,
        y = 52.3,
        z = 11756,
        x2 = 10278,
        y2 = 91.4,
        z2 = 11858
      },
      {
        x2 = 10122,
        y2 = 91.4,
        z2 = 12406,
        x = 9822,
        y = 52.3,
        z = 12306
      },
      {
        x = 10122,
        y = 91.4,
        z = 12406,
        x2 = 9822,
        y2 = 52.3,
        z2 = 12306
      },
      {
        x = 4674,
        y = 95.74,
        z = 2608,
        x2 = 4974,
        y2 = 51.19,
        z2 = 2658
      },
      {
        x2 = 4674,
        y2 = 95.74,
        z2 = 2608,
        x = 4974,
        y = 51.19,
        z = 2658
      },
      {
        x = 2474,
        y = 95.74,
        z = 4708,
        x2 = 2524,
        y2 = 52.79,
        z2 = 5008
      },
      {
        x2 = 2474,
        y2 = 95.74,
        z2 = 4708,
        x = 2524,
        y = 52.79,
        z = 5008
      },
      {
        x = 9632,
        y = 52.65,
        z = 9160,
        x2 = 9192,
        y2 = 52.01,
        z2 = 9400
      },
}

-- Damage Lib soon(tm)
