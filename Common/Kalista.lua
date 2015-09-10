if GetObjectName(myHero) ~= "Kalista" then return end

KalistaMenu = Menu("Kalista", "Kalista")
KalistaMenu:SubMenu("Combo", "Combo")
KalistaMenu.Combo:Boolean("Q", "Use Q", true)
KalistaMenu.Combo:Boolean("Items", "Use Items", true)
KalistaMenu.Combo:Boolean("QSS", "Use QSS", true)
KalistaMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)
KalistaMenu.Combo:Key("WallJump", "WallJump", string.byte("G"))
KalistaMenu.Combo:Key("SentinelBug", "Cast Sentinel Bug", string.byte("T"))

KalistaMenu:SubMenu("Harass", "Harass")
KalistaMenu.Harass:Boolean("Q", "Use Q", true)
KalistaMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

KalistaMenu:SubMenu("Ult", "Ult")
KalistaMenu.Ult:Boolean("AutoR", "Save Ally with R", true)
KalistaMenu.Ult:Slider("AutoRHP", "min Ally HP %", 5, 1, 100, 1)

KalistaMenu:SubMenu("Killsteal", "Killsteal")
KalistaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
KalistaMenu.Killsteal:Boolean("E", "Killsteal with E", true)

KalistaMenu:SubMenu("Misc", "Misc")
KalistaMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
KalistaMenu.Misc:Boolean("Autolvl", "Auto level", true)
KalistaMenu.Misc:Boolean("Edie", "Auto level", true)
KalistaMenu.Misc:Boolean("E", "E if Target Leave Range", true)
KalistaMenu.Misc:Slider("Elvl", "E if my level <", 12, 1, 18, 1)
KalistaMenu.Misc:Slider("minE", "min E Stacks", 7, 1, 20, 1)
KalistaMenu.Misc:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

KalistaMenu:SubMenu("Drawings", "Drawings")
KalistaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
KalistaMenu.Drawings:Boolean("E", "Draw E Range", true)
KalistaMenu.Drawings:Boolean("R", "Draw R Range", true)
KalistaMenu.Drawings:Boolean("Edmg", "Draw E% Dmg", true)

KalistaMenu:SubMenu("Farm", "Farm")
KalistaMenu.Farm:Boolean("ECanon", "Always E Big Minions", true)
KalistaMenu.Farm:Slider("Mana", "if Mana % >", 30, 0, 80, 1)
KalistaMenu.Farm:SubMenu("LaneClear", "LaneClear")
KalistaMenu.Farm.LaneClear:Slider("Farmkills", "E if X Can Be Killed", 2, 0, 10, 1)

KalistaMenu:SubMenu("JungleClear", "Jungle Clear")
KalistaMenu.JungleClear:SubMenu("Junglesteal", "Junglesteal (E)")
KalistaMenu.JungleClear.Junglesteal:Boolean("baron", "Baron", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("dragon", "Dragon", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("red", "Red", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("blue", "Blue", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("krug", "Krug", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("wolf", "Wolf", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("wraiths", "Wraiths", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("gromp", "Gromp", true)
KalistaMenu.JungleClear.Junglesteal:Boolean("crab", "Crab", true)

OnProcessSpell(function(unit, spell)
 for _, ally in pairs(GoS:GetAllyHeroes()) do
  if unit and unit == myHero and spell then
    if spell.name:lower():find("kalistapspellcast") then
    PrintChat("You are now pledged to "..GetObjectName(spell.target).."")
    end
  end
 end
end)

OnLoop(function(myHero)
    if IOW:Mode() == "Combo" then
	
	local target = IOW:GetTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1500,250,1150,50,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1150) and KalistaMenu.Combo.Q:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
	if GetItemSlot(myHero,3153) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(target, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and KalistaMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and KalistaMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	end
	
	if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= KalistaMenu.Harass.Mana:Value() then
	
	local target = IOW:GetTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1500,250,1150,50,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1150) and KalistaMenu.Harass.Q:Value() and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > HMmana.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
	end
    
	if KalistaMenu.Misc.E:Value() then
	   for i,enemy in pairs(GoS:GetEnemyHeroes()) do
                if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Misc.Mana:Value() and GetLevel(myHero) <= KalistaMenu.Misc.Elvl:Value() then
		   if GotBuff(enemy, "kalistaexpungemarker") >= KalistaMenu.Misc.minE:Value() and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and GoS:GetDistance(enemy) > 850 then
		   CastSpell(_E)
		   end
		end
	   end
	end
	
	if KalistaMenu.Misc.Edie:Value() then 
		if CanUseSpell(myHero, _E) and GetLevel(myHero) < 6 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 3 then
		CastSpell(_E)
		elseif CanUseSpell(myHero, _E) and GetLevel(myHero) > 5 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 5 then
		CastSpell(_E)
		end
	end
		
	if CanUseSpell(myHero,_W) and KalistaMenu.Combo.SentinelBug:Value() then
		if GoS:GetDistance(Vector(9882.892, -71.24, 4438.446)) < GoS:GetDistance(Vector(5087.77, -71.24, 10471.3808)) and GoS:GetDistance(Vector(9882.892, -71.24, 4438.446)) < 5200 then
                CastSkillShot(_W,9882.892, -71.24, 4438.446)	
                elseif GoS:GetDistance(Vector(5087.77, -71.24, 10471.3808)) < 5200 then
                CastSkillShot(_W,5087.77, -71.24, 10471.3808)
                end
	end
			
	if KalistaMenu.Ult.AutoR:Value() then 
	    for _, ally in pairs(GoS:GetAllyHeroes()) do
                for i,enemy in pairs(GoS:GetEnemyHeroes()) do 
			local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
			if CanUseSpell(myHero,_R) == READY and soulboundhero and 100*GetCurrentHP(ally)/GetMaxHP(ally) <= KalistaMenu.Ult.AutoRHP:Value() and GoS:GetDistance(ally, enemy) <= 600 then
		        PrintChat("Rescuing low health "..GetObjectName(ally).."")
			CastSpell(_R)
			end
		end
	    end
	end
	
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
	if GoS:GetDistance(Vector(2894, 95.748046875, 4648)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos1) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos1 Inverse
	if GoS:GetDistance(Vector(2924, 53.499828338623, 4958)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2894, 95.748046875, 4648)  
    MoveToXYZ(2894, 95.748046875, 4648)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos1) < 80 then
	MoveToXYZ(2924, 53.499828338623, 4958)
	end
	--pos2
	if GoS:GetDistance(Vector(2474, 93.368385314941, 4708)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2524, 52.793956756592, 5008)  
    MoveToXYZ(2524, 52.793956756592, 5008)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos2) < 80 then
	MoveToXYZ(2474, 93.368385314941, 4708)
	end
	--pos2 Inverse
	if GoS:GetDistance(Vector(2524, 52.793956756592, 5008)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2474, 93.368385314941, 4708)  
    MoveToXYZ(2474, 93.368385314941, 4708)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos2) < 80 then
	MoveToXYZ(2524, 52.793956756592, 5008)
	end
	--pos3
	if GoS:GetDistance(Vector(4630, 95.707084655762, 3020)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,4924, 51.007656097412, 3058)  
    MoveToXYZ(4924, 51.007656097412, 3058)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos3) < 80 then
	MoveToXYZ(4630, 95.707084655762, 3020)
	end
	--pos3 Inverse
	if GoS:GetDistance(Vector(4924, 51.007656097412, 3058)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,4630, 95.707084655762, 3020)
    MoveToXYZ(4630, 95.707084655762, 3020)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos3) < 80 then
	MoveToXYZ(4924, 51.007656097412, 3058)
	end
	--pos4
	if GoS:GetDistance(Vector(4674, 96.089622497559, 2608)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,4974, 52.284427642822, 2658) 
    MoveToXYZ(4974, 52.284427642822, 2658)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos4) < 80 then
	MoveToXYZ(4674, 96.089622497559, 2608)
	end
	--pos4 Inverse
	if GoS:GetDistance(Vector(4974, 52.284427642822, 2658)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,4674, 96.089622497559, 2608)
    MoveToXYZ(4674, 96.089622497559, 2608)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos,zoudjpos4) < 80 then
	MoveToXYZ(4974, 52.284427642822, 2658) 
	end
	--pos5
	if GoS:GetDistance(Vector(8222, 51.648384094238, 3158)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,8260, 51.130001068115, 2890)  
    MoveToXYZ(8260, 51.130001068115, 2890)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos5) < 80 then
	MoveToXYZ(8222, 51.648384094238, 3158)
	end
	--pos5 Inverse
	if GoS:GetDistance(Vector(8260, 51.130001068115, 2890)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,8222, 51.648384094238, 3158)
    MoveToXYZ(8222, 51.648384094238, 3158)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos5) < 80 then
	MoveToXYZ(8260, 51.130001068115, 2890)
	end
	--pos6
	if GoS:GetDistance(Vector(9630, 49.2229227093506, 2794)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9654, 63.591632843018, 3052)  
    MoveToXYZ(9654, 63.591632843018, 3052)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos6) < 80 then
	MoveToXYZ(9630, 49.2229227093506, 2794)
	end
	--pos6 Inverse
	if GoS:GetDistance(Vector(9654, 63.591632843018, 3052)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9630, 49.2229227093506, 2794)  
    MoveToXYZ(9630, 49.2229227093506, 2794)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos6) < 80 then
	MoveToXYZ(9654, 63.591632843018, 3052)
	end
	--pos7
	if GoS:GetDistance(Vector(6126, 48.527687072754, 5304)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,6090, 51.77721786499, 5572)  
    MoveToXYZ(6090, 51.77721786499, 5572)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos7) < 80 then
	MoveToXYZ(6126, 48.527687072754, 5304)
	end
	--pos7 Inverse
	if GoS:GetDistance(Vector(6090, 51.77721786499, 5572)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,6126, 48.527687072754, 5304)  
    MoveToXYZ(6126, 48.527687072754, 5304)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos7) < 80 then
	MoveToXYZ(6090, 51.77721786499, 5572)
	end
	--pos8
	if GoS:GetDistance(Vector(7194, 58.672454833984, 5630)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,7372, 52.565311431885, 5858)  
    MoveToXYZ(7372, 52.565311431885, 5858)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos8) < 80 then
	MoveToXYZ(7194, 58.672454833984, 5630)
	end
	--pos8 Inverse
	if GoS:GetDistance(Vector(7372, 52.565311431885, 5858)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,7194, 58.672454833984, 5630)  
    MoveToXYZ(7194, 58.672454833984, 5630)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos8) < 80 then
	MoveToXYZ(7372, 52.565311431885, 5858)
	end
	--pos9
	if GoS:GetDistance(Vector(7572, 52.451301574707, 6158)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,7772, -49.371105194092, 6308)  
    MoveToXYZ(7772, -49.371105194092, 6308)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos9) < 80 then
	MoveToXYZ(7572, 52.451301574707, 6158)
	end
	--pos9 Inverse
	if GoS:GetDistance(Vector(7772, -49.371105194092, 6308)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,7572, 52.451301574707, 6158)  
    MoveToXYZ(7572, 52.451301574707, 6158)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos9) < 80 then
	MoveToXYZ(7772, -49.371105194092, 6308)
	end
	--pos10
	if GoS:GetDistance(Vector(7972, 50.290023803711, 5908)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,8204, -71.240600585938, 6080)  
    MoveToXYZ(8204, -71.240600585938, 6080)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos10) < 80 then
	MoveToXYZ(7972, 50.290023803711, 5908)
	end
	--pos10 Inverse
	if GoS:GetDistance(Vector(8204, -71.240600585938, 6080)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,7972, 50.290023803711, 5908)  
    MoveToXYZ(7972, 50.290023803711, 5908)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos10) < 80 then
	MoveToXYZ(8204, -71.240600585938, 6080)
	end
	--pos11
	if GoS:GetDistance(Vector(9022, 52.721687316895, 4408)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9314, -71.240600585938, 4518)  
    MoveToXYZ(9314, -71.240600585938, 4518)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos11) < 80 then
	MoveToXYZ(9022, 52.721687316895, 4408)
	end
	--pos11 Inverse
    if GoS:GetDistance(Vector(9314, -71.240600585938, 4518)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9022, 52.721687316895, 4408)  
    MoveToXYZ(9022, 52.721687316895, 4408)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos11) < 80 then
	MoveToXYZ(9314, -71.240600585938, 4518)
	end
	--pos12
	if GoS:GetDistance(Vector(9722, -71.240600585938, 4908)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9700, -72.525970458984, 5198)  
    MoveToXYZ(9700, -72.525970458984, 5198)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos12) < 80 then
	MoveToXYZ(9722, -71.240600585938, 4908)
	end
	--pos12 Inverse
	if GoS:GetDistance(Vector(9700, -72.525970458984, 5198)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,9722, -71.240600585938, 4908)  
    MoveToXYZ(9722, -71.240600585938, 4908)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos12) < 80 then
	MoveToXYZ(9700, -72.525970458984, 5198)
	end
	--pos13
	if GoS:GetDistance(Vector(10462, -71.240600585938, 4352)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10694, -70.244300842285, 4526)  
    MoveToXYZ(10694, -70.244300842285, 4526)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos13) < 80 then
	MoveToXYZ(10462, -71.240600585938, 4352)
	end
	--pos13 Inverse
	if GoS:GetDistance(Vector(10694, -70.244300842285, 4526)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10462, -71.240600585938, 4352)  
    MoveToXYZ(10462, -71.240600585938, 4352)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos13) < 80 then
	MoveToXYZ(10694, -70.244300842285, 4526)
	end
	--pos14
	if GoS:GetDistance(Vector(11872, -71.240600585938, 4358)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12072, 51.729400634766, 4608)  
    MoveToXYZ(12072, 51.729400634766, 4608)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos14) < 80 then
	MoveToXYZ(11872, -71.240600585938, 4358)
	end
	--pos14 Inverse
	if GoS:GetDistance(Vector(12072, 51.729400634766, 4608)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11872, -71.240600585938, 4358)  
    MoveToXYZ(11872, -71.240600585938, 4358)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos14) < 80 then
	MoveToXYZ(12072, 51.729400634766, 4608)
	end
	--pos15
	if GoS:GetDistance(Vector(11772, -71.240600585938, 4608)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11922, 51.729400634766, 4758)  
    MoveToXYZ(11922, 51.729400634766, 4758)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos15) < 80 then
	MoveToXYZ(11772, -71.240600585938, 4608)
	end
	--pos15 Inverse
	if GoS:GetDistance(Vector(11922, 51.729400634766, 4758)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11772, -71.240600585938, 4608)  
    MoveToXYZ(11772, -71.240600585938, 4608)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos15) < 80 then
	MoveToXYZ(11922, 51.729400634766, 4758)
	end
	--pos16
	if GoS:GetDistance(Vector(11556, -71.240600585938, 4870)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11722, 51.783386230469, 5024)  
    MoveToXYZ(11722, 51.783386230469, 5024)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos16) < 80 then
	MoveToXYZ(11556, -71.240600585938, 4870)
	end
	--pos16 Inverse
	if GoS:GetDistance(Vector(11722, 51.783386230469, 5024)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11556, -71.240600585938, 4870)  
    MoveToXYZ(11556, -71.240600585938, 4870)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos16) < 80 then
	MoveToXYZ(11722, 51.783386230469, 5024)
	end
	--pos17
	if GoS:GetDistance(Vector(11342, -61.051364898682, 5274)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11592, 52.870578765896, 5316)  
    MoveToXYZ(11592, 52.870578765896, 5316)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos17) < 80 then
	MoveToXYZ(11342, -61.051364898682, 5274)
	end
	--pos17 Inverse
	if GoS:GetDistance(Vector(11592, 52.870578765896, 5316)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11342, -61.051364898682, 5274)  
    MoveToXYZ(11342, -61.051364898682, 5274)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos17) < 80 then
	MoveToXYZ(11592, 52.870578765896, 5316)
	end
	--pos18
	if GoS:GetDistance(Vector(12034, 54.640922546387, 5420)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos18) < 80 then
	MoveToXYZ(12034, 54.640922546387, 5420)
	end
	--pos18 Inverse
	if GoS:GetDistance(Vector(12272, 51.729400634766, 5408)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12034, 54.640922546387, 5420)  
    MoveToXYZ(12034, 54.640922546387, 5420)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos18) < 80 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos19
	if GoS:GetDistance(Vector(11966, 53.515453338623, 5592)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos19) < 80 then
	MoveToXYZ(11966, 53.515453338623, 5592)
	end
	--pos19 Inverse
	if GoS:GetDistance(Vector(12272, 51.729400634766, 5408)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11966, 53.515453338623, 5592)  
    MoveToXYZ(11966, 53.515453338623, 5592)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos19) < 80 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos20
	if GoS:GetDistance(Vector(11372, 51.72611618042, 7208)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11338, 52.204162597656, 7496)  
    MoveToXYZ(11338, 52.204162597656, 7496)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos20) < 80 then
	MoveToXYZ(11372, 51.72611618042, 7208)
	end
	--pos20 Inverse
	if GoS:GetDistance(Vector(11338, 52.204162597656, 7496)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11372, 51.72611618042, 7208)  
    MoveToXYZ(11372, 51.72611618042, 7208)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos20) < 80 then
	MoveToXYZ(11338, 52.204162597656, 7496)
	end
    --pos21
	if GoS:GetDistance(Vector(10772, 51.722599029541, 7208)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10738, 52.030101776123, 7450)  
    MoveToXYZ(10738, 52.030101776123, 7450)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos21) < 80 then
	MoveToXYZ(10772, 51.722599029541, 7208)
	end
	--pos21 Inverse
	if GoS:GetDistance(Vector(10738, 52.030101776123, 7450)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10772, 51.722599029541, 7208)  
    MoveToXYZ(10772, 51.722599029541, 7208)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos21) < 80 then
	MoveToXYZ(10738, 52.030101776123, 7450)
	end
	--pos22
	if GoS:GetDistance(Vector(10432, 51.977336883545, 6768)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10712, 51.722599029541, 6906)  
    MoveToXYZ(10712, 51.722599029541, 6906)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos22) < 80 then
	MoveToXYZ(10432, 51.977336883545, 6768)
	end
	--pos22 Inverse
	if GoS:GetDistance(Vector(10712, 51.722599029541, 6906)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,10432, 51.977336883545, 6768)  
    MoveToXYZ(10432, 51.977336883545, 6768)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos22) < 80 then
	MoveToXYZ(10712, 51.722599029541, 6906)
	end
	--pos23
	if GoS:GetDistance(Vector(12072, 52.360904693604, 8156)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11772, 54.545017242432, 8206)  
    MoveToXYZ(11772, 54.545017242432, 8206)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos23) < 80 then
	MoveToXYZ(12072, 52.360904693604, 8156)
	end
	--pos23 Inverse
	if GoS:GetDistance(Vector(11772, 54.545017242432, 8206)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12072, 52.360904693604, 8156)  
    MoveToXYZ(12072, 52.360904693604, 8156)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos23) < 80 then
	MoveToXYZ(11772, 54.545017242432, 8206)
	end
	--pos24
	if GoS:GetDistance(Vector(11768, 50.307735443115, 8904)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11572, 64.131408691406, 8706)  
    MoveToXYZ(11572, 64.131408691406, 8706)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos24) < 80 then
	MoveToXYZ(11768, 50.307735443115, 8904)
	end
	--pos24 Inverse
	if GoS:GetDistance(Vector(11572, 64.131408691406, 8706)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11768, 50.307735443115, 8904)  
    MoveToXYZ(11768, 50.307735443115, 8904)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos24) < 80 then
	MoveToXYZ(11572, 64.131408691406, 8706)
	end
	--pos25
	if GoS:GetDistance(Vector(12272, 56.769378662109, 9956)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12372, 91.429809570313, 10256)  
    MoveToXYZ(12372, 91.429809570313, 10256)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos25) < 80 then
	MoveToXYZ(12272, 56.769378662109, 9956)
	end
	--pos25 Inverse
	if GoS:GetDistance(Vector(12372, 91.429809570313, 10256)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,12272, 56.769378662109, 9956)  
    MoveToXYZ(12272, 56.769378662109, 9956)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos25) < 80 then
	MoveToXYZ(12372, 91.429809570313, 10256)
	end
	--pos26
	if GoS:GetDistance(Vector(11860, 55.388240814209, 10032)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11914, 91.429809570313, 10360)  
    MoveToXYZ(11914, 91.429809570313, 10360)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos26) < 80 then
	MoveToXYZ(11860, 55.388240814209, 10032)
	end
	--pos26 Inverse
	if GoS:GetDistance(Vector(11914, 91.429809570313, 10360)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,11860, 55.388240814209, 10032)  
    MoveToXYZ(11860, 55.388240814209, 10032)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos26) < 80 then
	MoveToXYZ(11914, 91.429809570313, 10360)
	end
	--pos27
	if GoS:GetDistance(Vector(3086, 57.047008514404, 6032)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3274, 52.461898803711, 6208)  
    MoveToXYZ(3274, 52.461898803711, 6208)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos27) < 80 then
	MoveToXYZ(3086, 57.047008514404, 6032)
	end
	--pos27 Inverse
	if GoS:GetDistance(Vector(3274, 52.461898803711, 6208)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3086, 57.047008514404, 6032)  
    MoveToXYZ(3086, 57.047008514404, 6032)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos27) < 80 then
	MoveToXYZ(3274, 52.461898803711, 6208)
	end
	--pos28
	if GoS:GetDistance(Vector(2924, 57.043914794922, 6208)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3108, 51.515998840332, 6428)  
    MoveToXYZ(3108, 51.515998840332, 6428)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos28) < 80 then
	MoveToXYZ(2924, 57.043914794922, 6208)
	end
	--pos28 Inverse
	if GoS:GetDistance(Vector(3108, 51.515998840332, 6428)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 57.043914794922, 6208)  
    MoveToXYZ(2924, 57.043914794922, 6208)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos28) < 80 then
	MoveToXYZ(3108, 51.515998840332, 6428)
	end
	--pos29
	if GoS:GetDistance(Vector(2824, 56.413402557373, 6708)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3074, 51.578483581543, 6758)  
    MoveToXYZ(3074, 51.578483581543, 6758)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos29) < 80 then
	MoveToXYZ(2824, 56.413402557373, 6708)
	end
	--pos29 Inverse
	if GoS:GetDistance(Vector(3074, 51.578483581543, 6758)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2824, 56.413402557373, 6708)  
    MoveToXYZ(2824, 56.413402557373, 6708)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos29) < 80 then
	MoveToXYZ(3074, 51.578483581543, 6758)
	end
	--pos30
	if GoS:GetDistance(Vector(3666, 51.8903465271, 7430)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3672, 51.676036834717, 7686)  
    MoveToXYZ(3672, 51.676036834717, 7686)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos30) < 80 then
	MoveToXYZ(3666, 51.8903465271, 7430)
	end
	--pos30 Inverse
	if GoS:GetDistance(Vector(3672, 51.676036834717, 7686)) < 5 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,3666, 51.8903465271, 7430)  
    MoveToXYZ(3666, 51.8903465271, 7430)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, zoudjpos30) < 80 then
	MoveToXYZ(3672, 51.676036834717, 7686)
	end
--[[	--pos31
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos31) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos32
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos32) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos33
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos33) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos34
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos34) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos35
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos35) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos36
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos36) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos37
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos37) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos38
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos38) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos39
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos39) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos40
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos40) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos41
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos41) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos42
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos42) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos43
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos43) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos44
	if HeroPos.x == 8260 and HeroPos.y == and HeroPos.z == 2890 and KalistaMenu.Combo.WallJump:Value() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif KalistaMenu.Combo.WallJump:Value() and GoS:GetDistance(mousePos, pos44) < 80 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	]]
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
	   local Damage = GoS:CalcDamage(myHero, enemy, GotBuff(enemy,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(enemy,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
           local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1500,250,1150,50,true,true)
	   
	   if Ignite and KalistaMenu.Misc.AutoIgnite:Value() then
             if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
             CastTargetSpell(enemy, Ignite)
             end
	   end
	   
           if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_E)) and KalistaMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy)< Damage then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(enemy, 1150) and KSQ.getValue() and QPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
           CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
           end
	   
	   if KalistaMenu.Drawings.Edmg:Value() then
	     local targetPos = GetOrigin(enemy)
             local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
	     if Damage > GetCurrentHP(enemy) then
	     DrawText("100%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
	     elseif Damage > 0 then
             DrawText(math.floor(Damage/GetCurrentHP(enemy)*100).."%",36,drawPos.x+40,drawPos.y+30,0xffffffff)
             end
	   end
	   
    end
	
	for _, ally in pairs(GoS:GetAllyHeroes()) do
           if GetObjectName(ally) == "Blitzcrank" then
	        KalistaMenu.Ult:Boolean("Balista", "Balista Combo", true)
		for i,enemy in pairs(GetEnemyHeroes()) do
  	          if GotBuff(ally, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 2450) and GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 and GoS:GetDistance(ally, enemy) > 450 and GotBuff(enemy, "rocketgrab2") > 0 then
                  CastSpell(_R)
                  end
                end
			
            elseif GetObjectName(ally) == "Skarner" then
	        KalistaMenu.Ult:Boolean("Skarlista", "Skarlista Combo", true)
	        for i,enemy in pairs(GetEnemyHeroes()) do
		  if GotBuff(ally, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 1750) and GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 and GotBuff(enemy, "skarnerimpale") > 0 then
                  CastSpell(_R)
                  end
                end
			
	    elseif GetObjectName(ally) == "TahmKench" then
	        KalistaMenu.Ult:Boolean("Tahmlista", "Tahmlista Combo", true)
		for i,enemy in pairs(GetEnemyHeroes()) do
	          if GotBuff(ally, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 1400) and GetCurrentHP(enemy) > 200 and GetCurrentHP(myHero) > 400 and GotBuff(enemy, "tahmkenchwdevoured") > 0 then
                  CastSpell(_R)
                  end
                end
            end
	end
	
if KalistaMenu.Misc.Autolvl:Value() then  

if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end
	
    local killableminions = 0
    for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
    local Damage = GoS:CalcDamage(myHero, minion, GotBuff(minion,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(minion,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
   
      if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Siege")) and GoS:ValidTarget(minion, GetCastRange(myHero,_E)) and KalistaMenu.Farm.ECanon:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Farm.Mana:Value() then 
      CastSpell(_E)
      end
	   
      if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("super")) and GoS:ValidTarget(minion, GetCastRange(myHero,_E)) and KalistaMenu.Farm.ECanon:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Farm.Mana:Value() then 
      CastSpell(_E)
      end
	  
      if Damage > 0 and Damage > GetCurrentHP(minion) and GoS:ValidTarget(minion, GetCastRange(myHero,_E)) then 
      killableminions = killableminions	+ 1
      end
	
    end
	
      if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Farm.Mana:Value() then
        if IOW:Mode() == "LaneClear" and killableminions >= KalistaMenu.Farm.LaneClear.Farmkills:Value() then
        CastSpell(_E)
	end
      end
	
for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
    local Damage = GoS:CalcDamage(myHero, mob, GotBuff(mob,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(mob,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if GoS:IsInDistance(mob, GetCastRange(myHero,_E)) then  
	  if CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Baron" and KalistaMenu.JungleClear.Junglesteal.baron:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Dragon" and KalistaMenu.JungleClear.Junglesteal.dragon:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Blue" and KalistaMenu.JungleClear.Junglesteal.blue:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Red" and KalistaMenu.JungleClear.Junglesteal.red:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Krug" and KalistaMenu.JungleClear.Junglesteal.krug:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Murkwolf" and KalistaMenu.JungleClear.Junglesteal.wolf:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Razorbeak" and KalistaMenu.JungleClear.Junglesteal.wraiths:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Gromp" and KalistaMenu.JungleClear.Junglesteal.gromp:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "Sru_Crab" and KalistaMenu.JungleClear.Junglesteal.crab:Value() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  end
    end
   
        if Gos:ValidTarget(mob, 1200) and KalistaMenu.Drawings.Edmg:Value() then
	local mobPos = GetOrigin(mob)
        local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
          if Damage > GetCurrentHP(mob) then
	  DrawText("100%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
	  elseif Damage > 0 then
          DrawText(math.floor(Damage/GetCurrentHP(mob)*100).."%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
          end
        end
end
  
if KalistaMenu.Combo.WallJump:Value() then
DrawCircle(pos1,80,0,0,0xffffffff)
DrawCircle(zoudjpos1,80,0,0,0xffffffff)
DrawCircle(pos2,80,0,0,0xffffffff)
DrawCircle(zoudjpos2,80,0,0,0xffffffff)
DrawCircle(pos3,80,0,0,0xffffffff)
DrawCircle(zoudjpos3,80,0,0,0xffffffff)
DrawCircle(pos4,80,0,0,0xffffffff)
DrawCircle(zoudjpos4,80,0,0,0xffffffff)
DrawCircle(pos5,80,0,0,0xffffffff)
DrawCircle(zoudjpos5,80,0,0,0xffffffff)
DrawCircle(pos6,80,0,0,0xffffffff)
DrawCircle(zoudjpos6,80,0,0,0xffffffff)
DrawCircle(pos7,80,0,0,0xffffffff)
DrawCircle(zoudjpos7,80,0,0,0xffffffff)
DrawCircle(pos8,80,0,0,0xffffffff)
DrawCircle(zoudjpos8,80,0,0,0xffffffff)
DrawCircle(pos9,80,0,0,0xffffffff)
DrawCircle(zoudjpos9,80,0,0,0xffffffff)
DrawCircle(pos10,80,0,0,0xffffffff)
DrawCircle(zoudjpos10,80,0,0,0xffffffff)
DrawCircle(pos11,80,0,0,0xffffffff)
DrawCircle(zoudjpos11,80,0,0,0xffffffff)
DrawCircle(pos12,80,0,0,0xffffffff)
DrawCircle(zoudjpos12,80,0,0,0xffffffff)
DrawCircle(pos13,80,0,0,0xffffffff)
DrawCircle(zoudjpos13,80,0,0,0xffffffff)
DrawCircle(pos14,80,0,0,0xffffffff)
DrawCircle(zoudjpos14,80,0,0,0xffffffff)
DrawCircle(pos15,80,0,0,0xffffffff)
DrawCircle(zoudjpos15,80,0,0,0xffffffff)
DrawCircle(pos16,80,0,0,0xffffffff)
DrawCircle(zoudjpos16,80,0,0,0xffffffff)
DrawCircle(pos17,80,0,0,0xffffffff)
DrawCircle(zoudjpos17,80,0,0,0xffffffff)
DrawCircle(pos18,80,0,0,0xffffffff)
DrawCircle(zoudjpos18,80,0,0,0xffffffff)
DrawCircle(pos19,80,0,0,0xffffffff)
DrawCircle(zoudjpos19,80,0,0,0xffffffff)
DrawCircle(pos20,80,0,0,0xffffffff)
DrawCircle(zoudjpos20,80,0,0,0xffffffff)
DrawCircle(pos21,80,0,0,0xffffffff)
DrawCircle(zoudjpos21,80,0,0,0xffffffff)
DrawCircle(pos22,80,0,0,0xffffffff)
DrawCircle(zoudjpos22,80,0,0,0xffffffff)
DrawCircle(pos23,80,0,0,0xffffffff)
DrawCircle(zoudjpos23,80,0,0,0xffffffff)
DrawCircle(pos24,80,0,0,0xffffffff)
DrawCircle(zoudjpos24,80,0,0,0xffffffff)
DrawCircle(pos25,80,0,0,0xffffffff)
DrawCircle(zoudjpos25,80,0,0,0xffffffff)
DrawCircle(pos26,80,0,0,0xffffffff)
DrawCircle(zoudjpos26,80,0,0,0xffffffff)
DrawCircle(pos27,80,0,0,0xffffffff)
DrawCircle(zoudjpos27,80,0,0,0xffffffff)
DrawCircle(pos28,80,0,0,0xffffffff)
DrawCircle(zoudjpos28,80,0,0,0xffffffff)
DrawCircle(pos29,80,0,0,0xffffffff)
DrawCircle(zoudjpos29,80,0,0,0xffffffff)
DrawCircle(pos30,80,0,0,0xffffffff)
DrawCircle(zoudjpos30,80,0,0,0xffffffff)
end

if KalistaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if KalistaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if KalistaMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end)

function kalE(x) 
if x <= 1 then return 10 else return kalE(x-1) + 2 + x
end 
end -- too smart for you inspired, thanks for this anyway :3, lazycat
