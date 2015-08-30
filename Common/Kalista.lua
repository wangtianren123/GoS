PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn off F7 orbwalker!")
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item5", "Use Mercurial", SCRIPT_PARAM_ONOFF, true)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl E-Q-W", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("AutoR", "Save Ally (R)", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("ELC", "Use E in LaneClear", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("WJ", "WallJump", SCRIPT_PARAM_KEYDOWN, string.byte("G")) 
MiscConfig.addParam("ECanon", "Always E Big Minion", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Balista", "Balista Combo", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Skarlista", "Skarlista Combo", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Tahmlista", "Tahmlista Combo", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, false)
JSConfig = scriptConfig("JS", "Junglesteal")
JSConfig.addParam("baron","Baron", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("dragon","Dragon", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("red","Red", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("blue","Blue", SCRIPT_PARAM_ONOFF, false)
JSConfig.addParam("krug","Krug", SCRIPT_PARAM_ONOFF, false)
JSConfig.addParam("wolf","Wolf", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("wraiths","Wraiths", SCRIPT_PARAM_ONOFF, true)
JSConfig.addParam("gromp","Gromp", SCRIPT_PARAM_ONOFF, false)
JSConfig.addParam("crab","Crab", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()
Junglesteal()
LaneClear()

if MiscConfig.Autolvl then
LevelUp()
end

if MiscConfig.AutoR then
SaveAlly()
end

if MiscConfig.Balista then
Balista()
end

if MiscConfig.Skarlista then
Skarlista()
end

if MiscConfig.Tahmlista then
Tahmlista()
end

local target = GetTarget(1150, DAMAGE_PHYSICAL)
 if IWalkConfig.Combo then
   
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
   if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and Config.Q then
   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
   end
   
        if GetItemSlot(myHero,3153) > 0 and Config.Item1 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and Config.Item2 and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and Config.Item3 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
		if GetItemSlot(myHero,3140) > 0 and Config.Item4 and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < 0.75 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and Config.Item5 and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < 0.75 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
   
 end
 
local target = GetTarget(1150, DAMAGE_PHYSICAL) 
 if IWalkConfig.Harass then
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
   if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and HarassConfig.HarassQ then
   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
   end
 end
end)

OnProcessSpell(function(unit, spell)
 for _, ally in pairs(GetAllyHeroes()) do
  if unit and unit == myHero and spell then
    if spell.name:lower():find("kalistapspellcast") then
      PrintChat("You are now pledged to "..GetObjectName(spell.target).."")
    end
  end
 end
end)

    local mousePos = GetMousePos()
	local HeroPos = GetOrigin(myHero)
	local pos1 = Vector(2894, 95.748046875, 4648)
	local zoudjpos1 = Vector(2924, 53.499828338623, 4958)
	local pos2 = Vector(2474, 93.368385314941, 4708)
	local zoudjpos2 = Vector(2524, 52.793956756592, 5008)
	local pos3 = Vector(4630, 95.707084655762, 3020)
	local zoudjpos3 = Vector(4924, 51.007656097412, 3058)
	local pos4 = Vector(4674, 96.089622497559, 2608)
	local zoudjpos4 = Vector(4974, 52.284427642822, 2658)
	local pos5 = Vector(8222, 51.648384094238, 3158)
	local zoudjpos5 = Vector(8260, 51.130001068115, 2890)
	local pos6 = Vector(9630, 49.2229227093506, 2794)
	local zoudjpos6 = Vector(9654, 63.591632843018, 3052)
	local pos7 = Vector(6126, 48.527687072754, 5304)
	local zoudjpos7 = Vector(6090, 51.77721786499, 5572)
	local pos8 = Vector(7194, 58.672454833984, 5630)
	local zoudjpos8 = Vector(7372, 52.565311431885, 5858)
	local pos9 = Vector(7572, 52.451301574707, 6158)
	local zoudjpos9 = Vector(7772, -49.371105194092, 6308)
	local pos10 = Vector(7972, 50.290023803711, 5908)
	local zoudjpos10 = Vector(8204, -71.240600585938, 6080)
	local pos11 = Vector(9022, 52.721687316895, 4408)
	local zoudjpos11 = Vector(9314, -71.240600585938, 4518)
	local pos12 = Vector(9722, -71.240600585938, 4908)
	local zoudjpos12 = Vector(9700, -72.525970458984, 5198)
	local pos13 = Vector(10462, -71.240600585938, 4352)
	local zoudjpos13 = Vector(10694, -70.244300842285, 4526)
	local pos14 = Vector(11872, -71.240600585938, 4358)
	local zoudjpos14 = Vector(12072, 51.729400634766, 4608)
	local pos15 = Vector(11772, -71.240600585938, 4608)
	local zoudjpos15 = Vector(11922, 51.729400634766, 4758)
	local pos16 = Vector(11556, -71.240600585938, 4870)
	local zoudjpos16 = Vector(11722, 51.783386230469, 5024)
	local pos17 = Vector(11342, -61.051364898682, 5274)
	local zoudjpos17 = Vector(11592, 52.870578765896, 5316)
	local pos18 = Vector(12034, 54.640922546387, 5420)
	local zoudjpos18 = Vector(12272, 51.729400634766, 5408)
	local pos19 = Vector(11966, 53.515453338623, 5592)
	local zoudjpos19 = Vector(12272, 51.729400634766, 5408)
	local pos20 = Vector(11372, 51.72611618042, 7208)
	local zoudjpos20 = Vector(11338, 52.204162597656, 7496)
	local pos21 = Vector(10772, 51.722599029541, 7208)
	local zoudjpos21 = Vector(10738, 52.030101776123, 7450)
	local pos22 = Vector(10432, 51.977336883545, 6768)
	local zoudjpos22 = Vector(10712, 51.722599029541, 6906)
	local pos23 = Vector(12072, 52.360904693604, 8156)
	local zoudjpos23 = Vector(11772, 54.545017242432, 8206)
	local pos24 = Vector(11768, 50.307735443115, 8904)
	local zoudjpos24 = Vector(11572, 64.131408691406, 8706)
	local pos25 = Vector(12272, 56.769378662109, 9956)
	local zoudjpos25 = Vector(12372, 91.429809570313, 10256)
	local pos26 = Vector(11860, 55.388240814209, 10032)
	local zoudjpos26 = Vector(11914, 91.429809570313, 10360)
	local pos27 = Vector(3086, 57.047008514404, 6032)
	local zoudjpos27 = Vector(3274, 52.461898803711, 6208)
	local pos28 = Vector(2924, 57.043914794922, 6208)
	local zoudjpos28 = Vector(3108, 51.515998840332, 6428)
	local pos29 = Vector(2824, 56.413402557373, 6708)
	local zoudjpos29 = Vector(3074, 51.578483581543, 6758)
	local pos30 = Vector(3666, 51.8903465271, 7430)
	local zoudjpos30 = Vector(3672, 51.676036834717, 7686)
	local pos31 = Vector(4134, 50.537956237793, 7986)
	local zoudjpos31 = Vector(4424, 49.118465423584, 8056)
	local pos32 = Vector(2874, 50.703777313232, 9256)
	local zoudjpos32 = Vector(2596, 51.773902893066, 9228)
	local pos33 = Vector(2832, 51.218849182129, 9480)
	local zoudjpos33 = Vector(2574, 53.03776550293, 9456)
	local pos34 = Vector(3208, 51.453907012939, 9696)
	local zoudjpos34 = Vector(3474, -64.667640686035, 9806)
	local pos35 = Vector(3124, 53.185127258301, 9956)
	local zoudjpos35 = Vector(3324, -64.717620849609, 10160)
	local pos36 = Vector(4234, -71.240600585938, 10306)
	local zoudjpos36 = Vector(4474, -71.240600585938, 10456)
	local pos37 = Vector(5018, -70.067916870117, 9734)
	local zoudjpos37 = Vector(4974, 56.47679901123, 12102)
	local pos38 = Vector(5212, 56.848400115967, 11794)
	local zoudjpos38 = Vector(5232, 56.47679901123, 12092)
	local pos39 = Vector(6582, 53.840835571289, 11694)
	local zoudjpos39 = Vector(6516, 56.47679901123, 11990)
	local pos40 = Vector(7024, -71.240600585938, 8406)
	local zoudjpos40 = Vector(7224, 53.995899200439, 8556)
	local pos41 = Vector(6824, -71.240600585938, 8606)
	local zoudjpos41 = Vector(6924, 52.872337341309, 8856)
	local pos42 = Vector(8086, 51.888671875, 9684)
	local zoudjpos42 = Vector(8396, 50.383907318115, 9672)
	local pos43 = Vector(9772, 52.476619720459, 11756)
	local zoudjpos43 = Vector(10278, 91.429779052734, 11858)
	local pos44 = Vector(9822, 52.306301116943, 12306)
	local zoudjpos44 = Vector(10122, 91.429840087891, 12406)
	--pos1
	if HeroPos.x == 2894 and HeroPos.z == 4648 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos1) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos1 Inverse
	if HeroPos.x == 2924 and HeroPos.z == 4958 and MiscConfig.WJ then
	CastSkillShot(_Q,2894, 95.748046875, 4648)  
    MoveToXYZ(2894, 95.748046875, 4648)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos1) < 80 then
	MoveToXYZ(2924, 53.499828338623, 4958)
	end
	--pos2
	if HeroPos.x == 2474 and HeroPos.z == 4708 and MiscConfig.WJ then
	CastSkillShot(_Q,2524, 52.793956756592, 5008)  
    MoveToXYZ(2524, 52.793956756592, 5008)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos2) < 80 then
	MoveToXYZ(2474, 93.368385314941, 4708)
	end
	--pos2 Inverse
	if HeroPos.x == 2524 and HeroPos.z == 5008 and MiscConfig.WJ then
	CastSkillShot(_Q,2474, 93.368385314941, 4708)  
    MoveToXYZ(2474, 93.368385314941, 4708)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos2) < 80 then
	MoveToXYZ(2524, 52.793956756592, 5008)
	end
	--pos3
	if HeroPos.x == 4630 and HeroPos.z == 3020 and MiscConfig.WJ then
	CastSkillShot(_Q,4924, 51.007656097412, 3058)  
    MoveToXYZ(4924, 51.007656097412, 3058)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos3) < 80 then
	MoveToXYZ(4630, 95.707084655762, 3020)
	end
	--pos3 Inverse
	if HeroPos.x == 4924 and HeroPos.z == 3058 and MiscConfig.WJ then
	CastSkillShot(_Q,4630, 95.707084655762, 3020)
    MoveToXYZ(4630, 95.707084655762, 3020)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos3) < 80 then
	MoveToXYZ(4924, 51.007656097412, 3058)
	end
	--pos4
	if HeroPos.x == 4674 and HeroPos.z == 2608 and MiscConfig.WJ then
	CastSkillShot(_Q,4974, 52.284427642822, 2658) 
    MoveToXYZ(4974, 52.284427642822, 2658)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos4) < 80 then
	MoveToXYZ(4674, 96.089622497559, 2608)
	end
	--pos4 Inverse
	if HeroPos.x == 4974 and HeroPos.z == 2658 and MiscConfig.WJ then
	CastSkillShot(_Q,4674, 96.089622497559, 2608)
    MoveToXYZ(4674, 96.089622497559, 2608)
	elseif MiscConfig.WJ and GetDistance(mousePos,zoudjpos4) < 80 then
	MoveToXYZ(4974, 52.284427642822, 2658) 
	end
	--pos5
	if HeroPos.x == 8222 and HeroPos.z == 3158 and MiscConfig.WJ then
	CastSkillShot(_Q,8260, 51.130001068115, 2890)  
    MoveToXYZ(8260, 51.130001068115, 2890)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos5) < 80 then
	MoveToXYZ(8222, 51.648384094238, 3158)
	end
	--pos5 Inverse
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,8222, 51.648384094238, 3158)
    MoveToXYZ(8222, 51.648384094238, 3158)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos5) < 80 then
	MoveToXYZ(8260, 51.130001068115, 2890)
	end
	--pos6
	if HeroPos.x == 9630 and HeroPos.z == 2794 and MiscConfig.WJ then
	CastSkillShot(_Q,9654, 63.591632843018, 3052)  
    MoveToXYZ(9654, 63.591632843018, 3052)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos6) < 80 then
	MoveToXYZ(9630, 49.2229227093506, 2794)
	end
	--pos6 Inverse
	if HeroPos.x == 9654 and HeroPos.z == 3052 and MiscConfig.WJ then
	CastSkillShot(_Q,9630, 49.2229227093506, 2794)  
    MoveToXYZ(9630, 49.2229227093506, 2794)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos6) < 80 then
	MoveToXYZ(9654, 63.591632843018, 3052)
	end
	--pos7
	if HeroPos.x == 6126 and HeroPos.z == 5304 and MiscConfig.WJ then
	CastSkillShot(_Q,6090, 51.77721786499, 5572)  
    MoveToXYZ(6090, 51.77721786499, 5572)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos7) < 80 then
	MoveToXYZ(6126, 48.527687072754, 5304)
	end
	--pos7 Inverse
	if HeroPos.x == 6090 and HeroPos.z == 5572 and MiscConfig.WJ then
	CastSkillShot(_Q,6126, 48.527687072754, 5304)  
    MoveToXYZ(6126, 48.527687072754, 5304)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos7) < 80 then
	MoveToXYZ(6090, 51.77721786499, 5572)
	end
	--pos8
	if HeroPos.x == 7194 and HeroPos.z == 5630 and MiscConfig.WJ then
	CastSkillShot(_Q,7372, 52.565311431885, 5858)  
    MoveToXYZ(7372, 52.565311431885, 5858)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos8) < 80 then
	MoveToXYZ(7194, 58.672454833984, 5630)
	end
	--pos8 Inverse
	if HeroPos.x == 7372 and HeroPos.z == 5858 and MiscConfig.WJ then
	CastSkillShot(_Q,7194, 58.672454833984, 5630)  
    MoveToXYZ(7194, 58.672454833984, 5630)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos8) < 80 then
	MoveToXYZ(7372, 52.565311431885, 5858)
	end
	--pos9
	if HeroPos.x == 7572 and HeroPos.z == 6158 and MiscConfig.WJ then
	CastSkillShot(_Q,7772, -49.371105194092, 6308)  
    MoveToXYZ(7772, -49.371105194092, 6308)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos9) < 80 then
	MoveToXYZ(7572, 52.451301574707, 6158)
	end
	--pos9 Inverse
	if HeroPos.x == 7772 and HeroPos.z == 6308 and MiscConfig.WJ then
	CastSkillShot(_Q,7572, 52.451301574707, 6158)  
    MoveToXYZ(7572, 52.451301574707, 6158)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos9) < 80 then
	MoveToXYZ(7772, -49.371105194092, 6308)
	end
	--pos10
	if HeroPos.x == 7972 and HeroPos.z == 5908 and MiscConfig.WJ then
	CastSkillShot(_Q,8204, -71.240600585938, 6080)  
    MoveToXYZ(8204, -71.240600585938, 6080)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos10) < 80 then
	MoveToXYZ(7972, 50.290023803711, 5908)
	end
	--pos10 Inverse
	if HeroPos.x == 8204 and HeroPos.z == 6080 and MiscConfig.WJ then
	CastSkillShot(_Q,7972, 50.290023803711, 5908)  
    MoveToXYZ(7972, 50.290023803711, 5908)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos10) < 80 then
	MoveToXYZ(8204, -71.240600585938, 6080)
	end
	--pos11
	if HeroPos.x == 9022 and HeroPos.z == 4408 and MiscConfig.WJ then
	CastSkillShot(_Q,9314, -71.240600585938, 4518)  
    MoveToXYZ(9314, -71.240600585938, 4518)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos11) < 80 then
	MoveToXYZ(9022, 52.721687316895, 4408)
	end
	--pos11 Inverse
	if HeroPos.x == 9314 and HeroPos.z == 4518 and MiscConfig.WJ then
	CastSkillShot(_Q,9022, 52.721687316895, 4408)  
    MoveToXYZ(9022, 52.721687316895, 4408)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos11) < 80 then
	MoveToXYZ(9314, -71.240600585938, 4518)
	end
	--pos12
	if HeroPos.x == 9722 and HeroPos.z == 4908 and MiscConfig.WJ then
	CastSkillShot(_Q,9700, -72.525970458984, 5198)  
    MoveToXYZ(9700, -72.525970458984, 5198)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos12) < 80 then
	MoveToXYZ(9722, -71.240600585938, 4908)
	end
	--pos12 Inverse
	if HeroPos.x == 9700 and HeroPos.z == 5198 and MiscConfig.WJ then
	CastSkillShot(_Q,9722, -71.240600585938, 4908)  
    MoveToXYZ(9722, -71.240600585938, 4908)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos12) < 80 then
	MoveToXYZ(9700, -72.525970458984, 5198)
	end
	--pos13
	if HeroPos.x == 10462 and HeroPos.z == 4352 and MiscConfig.WJ then
	CastSkillShot(_Q,10694, -70.244300842285, 4526)  
    MoveToXYZ(10694, -70.244300842285, 4526)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos13) < 80 then
	MoveToXYZ(10462, -71.240600585938, 4352)
	end
	--pos13 Inverse
	if HeroPos.x == 10694 and HeroPos.z == 4526 and MiscConfig.WJ then
	CastSkillShot(_Q,10462, -71.240600585938, 4352)  
    MoveToXYZ(10462, -71.240600585938, 4352)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos13) < 80 then
	MoveToXYZ(10694, -70.244300842285, 4526)
	end
	--pos14
	if HeroPos.x == 11872 and HeroPos.z == 4358 and MiscConfig.WJ then
	CastSkillShot(_Q,12072, 51.729400634766, 4608)  
    MoveToXYZ(12072, 51.729400634766, 4608)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos14) < 80 then
	MoveToXYZ(11872, -71.240600585938, 4358)
	end
	--pos14 Inverse
	if HeroPos.x == 12072 and HeroPos.z == 4608 and MiscConfig.WJ then
	CastSkillShot(_Q,11872, -71.240600585938, 4358)  
    MoveToXYZ(11872, -71.240600585938, 4358)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos14) < 80 then
	MoveToXYZ(12072, 51.729400634766, 4608)
	end
	--pos15
	if HeroPos.x == 11772 and HeroPos.z == 4608 and MiscConfig.WJ then
	CastSkillShot(_Q,11922, 51.729400634766, 4758)  
    MoveToXYZ(11922, 51.729400634766, 4758)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos15) < 80 then
	MoveToXYZ(11772, -71.240600585938, 4608)
	end
	--pos15 Inverse
	if HeroPos.x == 11922 and HeroPos.z == 4758 and MiscConfig.WJ then
	CastSkillShot(_Q,11772, -71.240600585938, 4608)  
    MoveToXYZ(11772, -71.240600585938, 4608)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos15) < 80 then
	MoveToXYZ(11922, 51.729400634766, 4758)
	end
	--pos16
	if HeroPos.x == 11556 and HeroPos.z == 4870 and MiscConfig.WJ then
	CastSkillShot(_Q,11722, 51.783386230469, 5024)  
    MoveToXYZ(11722, 51.783386230469, 5024)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos16) < 80 then
	MoveToXYZ(11556, -71.240600585938, 4870)
	end
	--pos16 Inverse
	if HeroPos.x == 11722 and HeroPos.z == 5024 and MiscConfig.WJ then
	CastSkillShot(_Q,11556, -71.240600585938, 4870)  
    MoveToXYZ(11556, -71.240600585938, 4870)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos16) < 80 then
	MoveToXYZ(11722, 51.783386230469, 5024)
	end
	--pos17
	if HeroPos.x == 11342 and HeroPos.z == 5274 and MiscConfig.WJ then
	CastSkillShot(_Q,11592, 52.870578765896, 5316)  
    MoveToXYZ(11592, 52.870578765896, 5316)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos17) < 80 then
	MoveToXYZ(11342, -61.051364898682, 5274)
	end
	--pos17 Inverse
	if HeroPos.x == 11592 and HeroPos.z == 5316 and MiscConfig.WJ then
	CastSkillShot(_Q,11342, -61.051364898682, 5274)  
    MoveToXYZ(11342, -61.051364898682, 5274)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos17) < 80 then
	MoveToXYZ(11592, 52.870578765896, 5316)
	end
	--pos18
	if HeroPos.x == 12034 and HeroPos.z == 5420 and MiscConfig.WJ then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos18) < 80 then
	MoveToXYZ(12034, 54.640922546387, 5420)
	end
	--pos18 Inverse
	if HeroPos.x == 12272 and HeroPos.z == 5408 and MiscConfig.WJ then
	CastSkillShot(_Q,12034, 54.640922546387, 5420)  
    MoveToXYZ(12034, 54.640922546387, 5420)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos18) < 80 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos19
	if HeroPos.x == 11966 and HeroPos.z == 5592 and MiscConfig.WJ then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos19) < 80 then
	MoveToXYZ(11966, 53.515453338623, 5592)
	end
	--pos19 Inverse
	if HeroPos.x == 12272 and HeroPos.z == 5408 and MiscConfig.WJ then
	CastSkillShot(_Q,11966, 53.515453338623, 5592)  
    MoveToXYZ(11966, 53.515453338623, 5592)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos19) < 80 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos20
	if HeroPos.x == 11372 and HeroPos.z == 7208 and MiscConfig.WJ then
	CastSkillShot(_Q,11338, 52.204162597656, 7496)  
    MoveToXYZ(11338, 52.204162597656, 7496)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos20) < 80 then
	MoveToXYZ(11372, 51.72611618042, 7208)
	end
	--pos20 Inverse
	if HeroPos.x == 11338 and HeroPos.z == 7496 and MiscConfig.WJ then
	CastSkillShot(_Q,11372, 51.72611618042, 7208)  
    MoveToXYZ(11372, 51.72611618042, 7208)
	elseif MiscConfig.WJ and GetDistance(mousePos, zoudjpos20) < 80 then
	MoveToXYZ(11338, 52.204162597656, 7496)
	end
	
--[[    --pos21
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos21) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos22
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos22) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos23
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos23) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos24
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos24) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos25
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos25) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos26
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos26) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos27
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos27) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos28
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos28) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos29
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos29) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos30
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos30) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos31
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos31) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos32
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos32) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos33
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos33) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos34
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos34) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos35
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos35) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos36
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos36) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos37
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos37) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos38
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos38) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos39
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos39) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos40
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos40) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos41
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos41) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos42
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos42) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos43
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos43) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos44
	if HeroPos.x == 8260 and HeroPos.z == 2890 and MiscConfig.WJ then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif MiscConfig.WJ and GetDistance(mousePos, pos44) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--]]

function Killsteal()
   for i,enemy in pairs(GetEnemyHeroes()) do
   local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1150,40,true,true)
   local Damage = CalcDamage(myHero, enemy, GotBuff(enemy,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(enemy,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
       if CanUseSpell(myHero, _E) == READY and ValidTarget(enemy,GetCastRange(myHero,_E)) and KSConfig.KSE and GetCurrentHP(enemy) < Damage then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy, GetCastRange(myHero, _Q)) and KSConfig.KSQ and QPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
       CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
       end
   end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
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

function Drawings()
local HeroPos = GetOrigin(myHero)
if MiscConfig.WJ then
DrawCircle(pos1,80,1,0,0xffffffff)
DrawCircle(zoudjpos1,80,1,0,0xffffffff)
DrawCircle(pos2,80,1,0,0xffffffff)
DrawCircle(zoudjpos2,80,1,0,0xffffffff)
DrawCircle(pos3,80,1,0,0xffffffff)
DrawCircle(zoudjpos3,80,1,0,0xffffffff)
DrawCircle(pos4,80,1,0,0xffffffff)
DrawCircle(zoudjpos4,80,1,0,0xffffffff)
DrawCircle(pos5,80,1,0,0xffffffff)
DrawCircle(zoudjpos5,80,1,0,0xffffffff)
DrawCircle(pos6,80,1,0,0xffffffff)
DrawCircle(zoudjpos6,80,1,0,0xffffffff)
DrawCircle(pos7,80,1,0,0xffffffff)
DrawCircle(zoudjpos7,80,1,0,0xffffffff)
DrawCircle(pos8,80,1,0,0xffffffff)
DrawCircle(zoudjpos8,80,1,0,0xffffffff)
DrawCircle(pos9,80,1,0,0xffffffff)
DrawCircle(zoudjpos9,80,1,0,0xffffffff)
DrawCircle(pos10,80,1,0,0xffffffff)
DrawCircle(zoudjpos10,80,1,0,0xffffffff)
DrawCircle(pos11,80,1,0,0xffffffff)
DrawCircle(zoudjpos11,80,1,0,0xffffffff)
DrawCircle(pos12,80,1,0,0xffffffff)
DrawCircle(zoudjpos12,80,1,0,0xffffffff)
DrawCircle(pos13,80,1,0,0xffffffff)
DrawCircle(zoudjpos13,80,1,0,0xffffffff)
DrawCircle(pos14,80,1,0,0xffffffff)
DrawCircle(zoudjpos14,80,1,0,0xffffffff)
DrawCircle(pos15,80,1,0,0xffffffff)
DrawCircle(zoudjpos15,80,1,0,0xffffffff)
DrawCircle(pos16,80,1,0,0xffffffff)
DrawCircle(zoudjpos16,80,1,0,0xffffffff)
DrawCircle(pos17,80,1,0,0xffffffff)
DrawCircle(zoudjpos17,80,1,0,0xffffffff)
DrawCircle(pos18,80,1,0,0xffffffff)
DrawCircle(zoudjpos18,80,1,0,0xffffffff)
DrawCircle(pos19,80,1,0,0xffffffff)
DrawCircle(zoudjpos19,80,1,0,0xffffffff)
DrawCircle(pos20,80,1,0,0xffffffff)
DrawCircle(zoudjpos20,80,1,0,0xffffffff)
end
  for _,target in pairs(GetEnemyHeroes()) do
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
 end
end

function SaveAlly()
 for _, ally in pairs(GetAllyHeroes()) do
 for i,enemy in pairs(GetEnemyHeroes()) do
   local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
   if soulboundhero and GetCurrentHP(ally)/GetMaxHP(ally) < 0.05 and GetDistance(ally, enemy) < 1500 then 
   CastSpell(_R)
   end
 end
 end
end

function Balista()
   for _, ally in pairs(GetAllyHeroes()) do
     if GetObjectName(ally) == "Blitzcrank" and GotBuff(ally, "kalistacoopstrikeally") > 0 then
      for i,enemy in pairs(GetEnemyHeroes()) do
        if ValidTarget(enemy, 2450) then
         if GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 and GetDistance(ally, enemy) > 450 then
           if GotBuff(enemy, "rocketgrab2") > 0 then
           CastSpell(_R)
           end
         end
        end
     end
   end
 end
end

function Skarlista()
   for _, ally in pairs(GetAllyHeroes()) do
     if GetObjectName(ally) == "Skarner" and GotBuff(ally, "kalistacoopstrikeally") > 0 then
      for i,enemy in pairs(GetEnemyHeroes()) do
        if ValidTarget(enemy, 1750) then
         if GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 then
           if GotBuff(enemy, "skarnerimpale") > 0 then
           CastSpell(_R)
           end
         end
        end
     end
   end
 end
end

function Tahmlista()
   for _, ally in pairs(GetAllyHeroes()) do
     if GetObjectName(ally) == "TahmKench" and GotBuff(ally, "kalistacoopstrikeally") > 0 then
      for i,enemy in pairs(GetEnemyHeroes()) do
        if ValidTarget(enemy, 1400) then
         if GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 then
           if GotBuff(enemy, "tahmkenchwdevoured") > 0 then
           CastSpell(_R)
           end
         end
        end
     end
   end
 end
end

function kalE(x) 
if x <= 1 then return 10 else return kalE(x-1) + 2 + x
end 
end -- too smart for you inspired, thanks for this anyway :3, lazycat

function LaneClear()
  local killableminions = 0
  for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
	local Damage = CalcDamage(myHero, minion, GotBuff(minion,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(minion,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if Damage > 0 and Damage > GetCurrentHP(minion) and ValidTarget(minion, GetCastRange(myHero,_E)) then 
    killableminions = killableminions or 1
    end
   
    if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Siege")) and ValidTarget(minion, GetCastRange(myHero,_E)) and MiscConfig.ECanon then 
    CastSpell(_E)
    end
	
    if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Super")) and ValidTarget(minion, GetCastRange(myHero,_E)) and MiscConfig.ECanon then 
	CastSpell(_E)
    end
  end
  
    if IWalkConfig.LaneClear and MiscConfig.ELC and killableminions > 1 then
    CastSpell(_E)
	end
end
	
function Junglesteal()
  for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
  local Damage = CalcDamage(myHero, mob, GotBuff(mob,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(mob,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if IsInDistance(mob, GetCastRange(myHero,_E)) then  
	  if CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Baron" and JSConfig.baron and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Dragon" and JSConfig.dragon and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Blue" and JSConfig.blue and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Red" and JSConfig.red and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Krug" and JSConfig.krug and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Murkwolf" and JSConfig.wolf and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Razorbeak" and JSConfig.wraiths and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Gromp" and JSConfig.gromp and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "Sru_Crab" and JSConfig.crab and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  end
   end
  if ValidTarget(mob, GetCastRange(myHero,_E)) then
	local mobPos = GetOrigin(mob)
    local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
	if Damage > GetCurrentHP(mob) then
	DrawText("100%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
	elseif Damage > 0 then
    DrawText(math.floor(Damage/GetCurrentHP(mob)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
    end
  end
  end
end
