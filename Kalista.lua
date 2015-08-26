require('Dlib')
PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
PrintChat("Please don't forget to turn on F7 orbwalker!")
MINION_ALLY, MINION_ENEMY, MINION_JUNGLE = GetTeam(GetMyHero()), GetTeam(GetMyHero()) == 100 and 200 or 100, 300
	
local root = menu.addItem(SubMenu.new("Kalista"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
local CItems = Combo.addItem(MenuBool.new("Use Items",true))
local CQSS = Combo.addItem(MenuBool.new("Use QSS", true))
local QSSHP = Combo.addItem(MenuSlider.new("if My Health % is Less Than", 75, 0, 100, 5))
local ComboActive = Combo.addItem(MenuKeyBind.new("Combo", 32))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q", true))
local HMmana = Harass.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 5))
local HarassActive = Harass.addItem(MenuKeyBind.new("Harass", 67))

local Ultmenu = root.addItem(SubMenu.new("Ult"))
local AutoR = Ultmenu.addItem(MenuBool.new("Save Ally with R", true))
local AutoRHP = Ultmenu.addItem(MenuSlider.new("min Ally HP %", 5, 1, 100, 1))

local KSmenu = root.addItem(SubMenu.new("Killsteal"))
local KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))
local KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", true))

local Misc = root.addItem(SubMenu.new("Misc"))
local MiscAutolvl = Misc.addItem(SubMenu.new("Auto level", true))
local MiscEnableAutolvl = MiscAutolvl.addItem(MenuBool.new("Enable", true))
local MiscuseE = Misc.addItem(MenuBool.new("Auto E if Target Will Leave Range", true))
local MiscElvl = Misc.addItem(MenuSlider.new("E Harass if my level <", 12, 1, 18, 1))
local MiscminE = Misc.addItem(MenuSlider.new("min E Stacks", 8, 1, 20, 1))
local MiscMmana = Misc.addItem(MenuSlider.new("if My Mana % is More Than", 30, 0, 80, 5))
local WallJump = Misc.addItem(MenuKeyBind.new("WallJump", 71))

local Drawings = root.addItem(SubMenu.new("Drawings"))
local DrawingsAA = Drawings.addItem(MenuBool.new("Draw AA", true))
local DrawingsQ = Drawings.addItem(MenuBool.new("Draw Q Range", true))
local DrawingsE = Drawings.addItem(MenuBool.new("Draw E Range", true))
local DrawingsR = Drawings.addItem(MenuBool.new("Draw R Range", true))
local DrawingsEdmg = Drawings.addItem(MenuBool.new("Draw E% Dmg", true))

local Farm = root.addItem(SubMenu.new("Farm"))
local ECanon = Farm.addItem(MenuBool.new("Always E Big Minions", true))
local Farmmana = Farm.addItem(MenuSlider.new("Don't E if Mana % <", 30, 0, 80, 5))
local Farmkills = Farm.addItem(MenuSlider.new("E if X Can Be Killed", 2, 0, 10, 1))
local LaneClearActive = Farm.addItem(MenuKeyBind.new("LaneClear", 86))

local JungleClear = root.addItem(SubMenu.new("Jungle Clear"))
local junglesteal = JungleClear.addItem(SubMenu.new("Junglesteal (E)", true))
local baron = junglesteal.addItem(MenuBool.new("Baron", true))
local dragon = junglesteal.addItem(MenuBool.new("Dragon", true))
local red = junglesteal.addItem(MenuBool.new("Red", true))
local blue = junglesteal.addItem(MenuBool.new("Blue", false))
local krug = junglesteal.addItem(MenuBool.new("Krug", false))
local wolf = junglesteal.addItem(MenuBool.new("Wolf", true))
local wraiths = junglesteal.addItem(MenuBool.new("Wraiths", true))
local gromp = junglesteal.addItem(MenuBool.new("Gromp", false))
local crab = junglesteal.addItem(MenuBool.new("Crab", true))
local JungleClearActive = JungleClear.addItem(MenuKeyBind.new("JungleClear", 86))

do
  _G.objectManager = {}
  objectManager.maxObjects = 0
  objectManager.objects = {}
  objectManager.camps = {}
  objectManager.barracks = {}
  objectManager.heroes = {}
  objectManager.minions = {}
  OnObjectLoop(function(object, myHero)
    objectManager.objects[GetNetworkID(object)] = object
  end)
  OnLoop(function(myHero)
    objectManager.maxObjects = 0
    for _, obj in pairs(objectManager.objects) do
      objectManager.maxObjects = objectManager.maxObjects + 1
      local type = GetObjectType(obj)
      if type == Obj_AI_Camp then
        objectManager.camps[_] = obj
      elseif type == Obj_AI_Hero then
        objectManager.heroes[_] = obj
      elseif type == Obj_AI_Minion then
        objectManager.minions[_] = obj
      end
    end
  end)
end

OnLoop(function(myHero)
	local mousePos = GetMousePos()
    if ComboActive.getValue() then
	local target = GetCurrentTarget()
	
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and CUseQ.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
		if GetItemSlot(myHero,3153) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and CItems.getValue() and ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
        CastTargetSpell(target, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and CItems.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
		if GetItemSlot(myHero,3140) > 0 and CQSS.getValue() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and CQSS.getValue() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < QSSHP.getValue() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	end
	
	if HarassActive.getValue() then
	local target = GetCurrentTarget()
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,250,1150,40,true,true)
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1150) and HUseQ.getValue() and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > HMmana.getValue() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		else 
	    MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
        end
	end
    
	if MiscuseE.getValue() then
	    for i,enemy in pairs(GetEnemyHeroes()) do
            if GetCurrentMana(myHero)/GetMaxMana(myHero) > MiscMmana.getValue() and GetLevel(myHero) < MiscElvl.getValue() then
		        if GotBuff(enemy, "kalistaexpungemarker") >= MiscminE.getValue() and ValidTarget(target, GetCastRange(myHero,_E)) and GetDistance(myHero, enemy) > 850 then
			    CastSpell(_E)
			    end
		    end
		end
	end
			
	if AutoR.getValue() then 
	    for _, ally in pairs(GetAllyHeroes()) do
            for i,enemy in pairs(GetEnemyHeroes()) do 
			    local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
				if soulboundhero and (GetCurrentHP(ally)/GetMaxHP(ally))*100 <= AutoRHP.getValue() and GetDistance(ally, enemy) <= 600 then
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
	if HeroPos.x == 2894 and HeroPos.z == 4648 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos1) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos1 Inverse
	if HeroPos.x == 2924 and HeroPos.z == 4958 and WallJump.getValue() then
	CastSkillShot(_Q,2894, 95.748046875, 4648)  
    MoveToXYZ(2894, 95.748046875, 4648)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos1) < 200 then
	MoveToXYZ(2924, 53.499828338623, 4958)
	end
	--pos2
	if HeroPos.x == 2474 and HeroPos.z == 4708 and WallJump.getValue() then
	CastSkillShot(_Q,2524, 52.793956756592, 5008)  
    MoveToXYZ(2524, 52.793956756592, 5008)
	elseif WallJump.getValue() and GetDistance(mousePos, pos2) < 200 then
	MoveToXYZ(2474, 93.368385314941, 4708)
	end
	--pos2 Inverse
	if HeroPos.x == 2524 and HeroPos.z == 5008 and WallJump.getValue() then
	CastSkillShot(_Q,2474, 93.368385314941, 4708)  
    MoveToXYZ(2474, 93.368385314941, 4708)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos2) < 200 then
	MoveToXYZ(2524, 52.793956756592, 5008)
	end
	--pos3
	if HeroPos.x == 4630 and HeroPos.z == 3020 and WallJump.getValue() then
	CastSkillShot(_Q,4924, 51.007656097412, 3058)  
    MoveToXYZ(4924, 51.007656097412, 3058)
	elseif WallJump.getValue() and GetDistance(mousePos, pos3) < 200 then
	MoveToXYZ(4630, 95.707084655762, 3020)
	end
	--pos3 Inverse
	if HeroPos.x == 4924 and HeroPos.z == 3058 and WallJump.getValue() then
	CastSkillShot(_Q,4630, 95.707084655762, 3020)
    MoveToXYZ(4630, 95.707084655762, 3020)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos3) < 200 then
	MoveToXYZ(4924, 51.007656097412, 3058)
	end
	--pos4
	if HeroPos.x == 4674 and HeroPos.z == 2608 and WallJump.getValue() then
	CastSkillShot(_Q,4974, 52.284427642822, 2658) 
    MoveToXYZ(4974, 52.284427642822, 2658)
	elseif WallJump.getValue() and GetDistance(mousePos, pos4) < 200 then
	MoveToXYZ(4674, 96.089622497559, 2608)
	end
	--pos4 Inverse
	if HeroPos.x == 4974 and HeroPos.z == 2658 and WallJump.getValue() then
	CastSkillShot(_Q,4674, 96.089622497559, 2608)
    MoveToXYZ(4674, 96.089622497559, 2608)
	elseif WallJump.getValue() and GetDistance(mousePos,zoudjpos4) < 200 then
	MoveToXYZ(4974, 52.284427642822, 2658) 
	end
	--pos5
	if HeroPos.x == 8222 and HeroPos.z == 3158 and WallJump.getValue() then
	CastSkillShot(_Q,8260, 51.130001068115, 2890)  
    MoveToXYZ(8260, 51.130001068115, 2890)
	elseif WallJump.getValue() and GetDistance(mousePos, pos5) < 200 then
	MoveToXYZ(8222, 51.648384094238, 3158)
	end
	--pos5 Inverse
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,8222, 51.648384094238, 3158)
    MoveToXYZ(8222, 51.648384094238, 3158)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos5) < 200 then
	MoveToXYZ(8260, 51.130001068115, 2890)
	end
	--pos6
	if HeroPos.x == 9630 and HeroPos.z == 2794 and WallJump.getValue() then
	CastSkillShot(_Q,9654, 63.591632843018, 3052)  
    MoveToXYZ(9654, 63.591632843018, 3052)
	elseif WallJump.getValue() and GetDistance(mousePos, pos6) < 200 then
	MoveToXYZ(9630, 49.2229227093506, 2794)
	end
	--pos6 Inverse
	if HeroPos.x == 9654 and HeroPos.z == 3052 and WallJump.getValue() then
	CastSkillShot(_Q,9630, 49.2229227093506, 2794)  
    MoveToXYZ(9630, 49.2229227093506, 2794)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos6) < 200 then
	MoveToXYZ(9654, 63.591632843018, 3052)
	end
	--pos7
	if HeroPos.x == 6126 and HeroPos.z == 5304 and WallJump.getValue() then
	CastSkillShot(_Q,6090, 51.77721786499, 5572)  
    MoveToXYZ(6090, 51.77721786499, 5572)
	elseif WallJump.getValue() and GetDistance(mousePos, pos7) < 200 then
	MoveToXYZ(6126, 48.527687072754, 5304)
	end
	--pos7 Inverse
	if HeroPos.x == 6090 and HeroPos.z == 5572 and WallJump.getValue() then
	CastSkillShot(_Q,6126, 48.527687072754, 5304)  
    MoveToXYZ(6126, 48.527687072754, 5304)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos7) < 200 then
	MoveToXYZ(6090, 51.77721786499, 5572)
	end
	--pos8
	if HeroPos.x == 7194 and HeroPos.z == 5630 and WallJump.getValue() then
	CastSkillShot(_Q,7372, 52.565311431885, 5858)  
    MoveToXYZ(7372, 52.565311431885, 5858)
	elseif WallJump.getValue() and GetDistance(mousePos, pos8) < 200 then
	MoveToXYZ(7194, 58.672454833984, 5630)
	end
	--pos8 Inverse
	if HeroPos.x == 7372 and HeroPos.z == 5858 and WallJump.getValue() then
	CastSkillShot(_Q,7194, 58.672454833984, 5630)  
    MoveToXYZ(7194, 58.672454833984, 5630)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos8) < 200 then
	MoveToXYZ(7372, 52.565311431885, 5858)
	end
	--pos9
	if HeroPos.x == 7572 and HeroPos.z == 6158 and WallJump.getValue() then
	CastSkillShot(_Q,7772, -49.371105194092, 6308)  
    MoveToXYZ(7772, -49.371105194092, 6308)
	elseif WallJump.getValue() and GetDistance(mousePos, pos9) < 200 then
	MoveToXYZ(7572, 52.451301574707, 6158)
	end
	--pos9 Inverse
	if HeroPos.x == 7772 and HeroPos.z == 6308 and WallJump.getValue() then
	CastSkillShot(_Q,7572, 52.451301574707, 6158)  
    MoveToXYZ(7572, 52.451301574707, 6158)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos9) < 200 then
	MoveToXYZ(7772, -49.371105194092, 6308)
	end
	--pos10
	if HeroPos.x == 7972 and HeroPos.z == 5908 and WallJump.getValue() then
	CastSkillShot(_Q,8204, -71.240600585938, 6080)  
    MoveToXYZ(8204, -71.240600585938, 6080)
	elseif WallJump.getValue() and GetDistance(mousePos, pos10) < 200 then
	MoveToXYZ(7972, 50.290023803711, 5908)
	end
	--pos10 Inverse
	if HeroPos.x == 8204 and HeroPos.z == 6080 and WallJump.getValue() then
	CastSkillShot(_Q,7972, 50.290023803711, 5908)  
    MoveToXYZ(7972, 50.290023803711, 5908)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos10) < 200 then
	MoveToXYZ(8204, -71.240600585938, 6080)
	end
	--pos11
	if HeroPos.x == 9022 and HeroPos.z == 4408 and WallJump.getValue() then
	CastSkillShot(_Q,9314, -71.240600585938, 4518)  
    MoveToXYZ(9314, -71.240600585938, 4518)
	elseif WallJump.getValue() and GetDistance(mousePos, pos11) < 200 then
	MoveToXYZ(9022, 52.721687316895, 4408)
	end
	--pos11 Inverse
	if HeroPos.x == 9314 and HeroPos.z == 4518 and WallJump.getValue() then
	CastSkillShot(_Q,9022, 52.721687316895, 4408)  
    MoveToXYZ(9022, 52.721687316895, 4408)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos11) < 200 then
	MoveToXYZ(9314, -71.240600585938, 4518)
	end
	--pos12
	if HeroPos.x == 9722 and HeroPos.z == 4908 and WallJump.getValue() then
	CastSkillShot(_Q,9700, -72.525970458984, 5198)  
    MoveToXYZ(9700, -72.525970458984, 5198)
	elseif WallJump.getValue() and GetDistance(mousePos, pos12) < 200 then
	MoveToXYZ(9722, -71.240600585938, 4908)
	end
	--pos12 Inverse
	if HeroPos.x == 9700 and HeroPos.z == 5198 and WallJump.getValue() then
	CastSkillShot(_Q,9722, -71.240600585938, 4908)  
    MoveToXYZ(9722, -71.240600585938, 4908)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos12) < 200 then
	MoveToXYZ(9700, -72.525970458984, 5198)
	end
	--pos13
	if HeroPos.x == 10462 and HeroPos.z == 4352 and WallJump.getValue() then
	CastSkillShot(_Q,10694, -70.244300842285, 4526)  
    MoveToXYZ(10694, -70.244300842285, 4526)
	elseif WallJump.getValue() and GetDistance(mousePos, pos13) < 200 then
	MoveToXYZ(10462, -71.240600585938, 4352)
	end
	--pos13 Inverse
	if HeroPos.x == 10694 and HeroPos.z == 4526 and WallJump.getValue() then
	CastSkillShot(_Q,10462, -71.240600585938, 4352)  
    MoveToXYZ(10462, -71.240600585938, 4352)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos13) < 200 then
	MoveToXYZ(10694, -70.244300842285, 4526)
	end
	--pos14
	if HeroPos.x == 11872 and HeroPos.z == 4358 and WallJump.getValue() then
	CastSkillShot(_Q,12072, 51.729400634766, 4608)  
    MoveToXYZ(12072, 51.729400634766, 4608)
	elseif WallJump.getValue() and GetDistance(mousePos, pos14) < 200 then
	MoveToXYZ(11872, -71.240600585938, 4358)
	end
	--pos14 Inverse
	if HeroPos.x == 12072 and HeroPos.z == 4608 and WallJump.getValue() then
	CastSkillShot(_Q,11872, -71.240600585938, 4358)  
    MoveToXYZ(11872, -71.240600585938, 4358)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos14) < 200 then
	MoveToXYZ(12072, 51.729400634766, 4608)
	end
	--pos15
	if HeroPos.x == 11772 and HeroPos.z == 4608 and WallJump.getValue() then
	CastSkillShot(_Q,11922, 51.729400634766, 4758)  
    MoveToXYZ(11922, 51.729400634766, 4758)
	elseif WallJump.getValue() and GetDistance(mousePos, pos15) < 200 then
	MoveToXYZ(11772, -71.240600585938, 4608)
	end
	--pos15 Inverse
	if HeroPos.x == 11922 and HeroPos.z == 4758 and WallJump.getValue() then
	CastSkillShot(_Q,11772, -71.240600585938, 4608)  
    MoveToXYZ(11772, -71.240600585938, 4608)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos15) < 200 then
	MoveToXYZ(11922, 51.729400634766, 4758)
	end
	--pos16
	if HeroPos.x == 11556 and HeroPos.z == 4870 and WallJump.getValue() then
	CastSkillShot(_Q,11722, 51.783386230469, 5024)  
    MoveToXYZ(11722, 51.783386230469, 5024)
	elseif WallJump.getValue() and GetDistance(mousePos, pos16) < 200 then
	MoveToXYZ(11556, -71.240600585938, 4870)
	end
	--pos16 Inverse
	if HeroPos.x == 11722 and HeroPos.z == 5024 and WallJump.getValue() then
	CastSkillShot(_Q,11556, -71.240600585938, 4870)  
    MoveToXYZ(11556, -71.240600585938, 4870)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos16) < 200 then
	MoveToXYZ(11722, 51.783386230469, 5024)
	end
	--pos17
	if HeroPos.x == 11342 and HeroPos.z == 5274 and WallJump.getValue() then
	CastSkillShot(_Q,11592, 52.870578765896, 5316)  
    MoveToXYZ(11592, 52.870578765896, 5316)
	elseif WallJump.getValue() and GetDistance(mousePos, pos17) < 200 then
	MoveToXYZ(11342, -61.051364898682, 5274)
	end
	--pos17 Inverse
	if HeroPos.x == 11592 and HeroPos.z == 5316 and WallJump.getValue() then
	CastSkillShot(_Q,11342, -61.051364898682, 5274)  
    MoveToXYZ(11342, -61.051364898682, 5274)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos17) < 200 then
	MoveToXYZ(11592, 52.870578765896, 5316)
	end
	--pos18
	if HeroPos.x == 12034 and HeroPos.z == 5420 and WallJump.getValue() then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif WallJump.getValue() and GetDistance(mousePos, pos18) < 200 then
	MoveToXYZ(12034, 54.640922546387, 5420)
	end
	--pos18 Inverse
	if HeroPos.x == 12272 and HeroPos.z == 5408 and WallJump.getValue() then
	CastSkillShot(_Q,12034, 54.640922546387, 5420)  
    MoveToXYZ(12034, 54.640922546387, 5420)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos18) < 200 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos19
	if HeroPos.x == 11966 and HeroPos.z == 5592 and WallJump.getValue() then
	CastSkillShot(_Q,12272, 51.729400634766, 5408)  
    MoveToXYZ(12272, 51.729400634766, 5408)
	elseif WallJump.getValue() and GetDistance(mousePos, pos19) < 200 then
	MoveToXYZ(11966, 53.515453338623, 5592)
	end
	--pos19 Inverse
	if HeroPos.x == 12272 and HeroPos.z == 5408 and WallJump.getValue() then
	CastSkillShot(_Q,11966, 53.515453338623, 5592)  
    MoveToXYZ(11966, 53.515453338623, 5592)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos19) < 200 then
	MoveToXYZ(12272, 51.729400634766, 5408)
	end
	--pos20
	if HeroPos.x == 11372 and HeroPos.z == 7208 and WallJump.getValue() then
	CastSkillShot(_Q,11338, 52.204162597656, 7496)  
    MoveToXYZ(11338, 52.204162597656, 7496)
	elseif WallJump.getValue() and GetDistance(mousePos, pos20) < 200 then
	MoveToXYZ(11372, 51.72611618042, 7208)
	end
	--pos20 Inverse
	if HeroPos.x == 11338 and HeroPos.z == 7496 and WallJump.getValue() then
	CastSkillShot(_Q,11372, 51.72611618042, 7208)  
    MoveToXYZ(11372, 51.72611618042, 7208)
	elseif WallJump.getValue() and GetDistance(mousePos, zoudjpos20) < 200 then
	MoveToXYZ(11338, 52.204162597656, 7496)
	end
	
--[[    --pos21
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos21) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos22
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos22) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos23
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos23) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos24
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos24) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos25
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos25) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos26
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos26) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos27
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos27) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos28
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos28) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos29
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos29) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos30
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos30) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos31
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos31) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos32
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos32) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos33
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos33) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos34
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos34) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos35
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos35) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos36
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos36) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos37
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos37) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos38
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos38) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos39
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos39) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos40
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos40) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos41
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos41) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos42
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos42) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos43
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos43) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--pos44
	if HeroPos.x == 8260 and HeroPos.z == 2890 and WallJump.getValue() then
	CastSkillShot(_Q,2924, 53.499828338623, 4958)  
    MoveToXYZ(2924, 53.499828338623, 4958)
	elseif WallJump.getValue() and GetDistance(mousePos, pos44) < 200 then
	MoveToXYZ(2894, 95.748046875, 4648)
	end
	--]]
	
	for i,enemy in pairs(GetEnemyHeroes()) do
	local Damage = CalcDamage(myHero, enemy, GotBuff(enemy,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(enemy,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1150,40,true,true)
       if CanUseSpell(myHero, _E) == READY and ValidTarget(enemy, GetCastRange(myHero,_E)) and KSE.getValue() and GetCurrentHP(enemy) < Damage then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy, GetCastRange(myHero, _Q)) and KSQ.getValue() and QPred.HitChance == 1 and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
       CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
       end
	   
	if DrawingsEdmg.getValue() then
	  local targetPos = GetOrigin(enemy)
      local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
	  if Damage > GetCurrentHP(enemy) then
	  DrawText("100%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
	  elseif Damage > 0 then
      DrawText(math.floor(Damage/GetCurrentHP(enemy)*100).."%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
      end
	end
	
    end
	
	if MiscEnableAutolvl.getValue() then
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
	
	local killableminions = 0
    for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
	  local Damage = CalcDamage(myHero, minion, GotBuff(minion,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(minion,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
   
      if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Siege")) and ValidTarget(minion, GetCastRange(myHero,_E)) and ECanon.getValue() and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > Farmmana.getValue() then 
      CastSpell(_E)
	  end
	   
	  if Damage > 0 and Damage > GetCurrentHP(minion) and (GetObjectName(minion):find("Super")) and ValidTarget(minion, GetCastRange(myHero,_E)) and ECanon.getValue() and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > Farmmana.getValue() then 
      CastSpell(_E)
	  end
	  
	  if Damage > 0 and Damage > GetCurrentHP(minion) and ValidTarget(minion, GetCastRange(myHero,_E)) then 
      killableminions = killableminions	+ 1
      end
	
    end
	
      if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > Farmmana.getValue() then
        if LaneClearActive.getValue() and killableminions >= Farmkills.getValue() then
        CastSpell(_E)
	end
      end
	
	for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
    local Damage = CalcDamage(myHero, mob, GotBuff(mob,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + ((GetBonusDmg(myHero)+GetBaseDamage(myHero)) * 0.6)) + (GotBuff(mob,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) or 0)
    if IsInDistance(mob, GetCastRange(myHero,_E)) then  
	  if CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Baron" and baron.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Dragon" and dragon.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Blue" and blue.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Red" and red.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Krug" and krug.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Murkwolf" and wolf.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Razorbeak" and wraiths.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "SRU_Gromp" and gromp.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) == READY and GetObjectName(mob) == "Sru_Crab" and crab.getValue() and GetCurrentHP(mob) < Damage then
	  CastSpell(_E)
	  end
   end
   
  if ValidTarget(mob, 1200) and DrawingsEdmg.getValue() then
	local mobPos = GetOrigin(mob)
    local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
	if Damage > GetCurrentHP(mob) then
	DrawText("100%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
	elseif Damage > 0 then
    DrawText(math.floor(Damage/GetCurrentHP(mob)*100).."%",32,drawPos.x+40,drawPos.y+30,0xffffffff)
    end
  end
  end
  

local HeroPos = GetOrigin(myHero)
if WallJump.getValue() then
DrawCircle(pos1,80,1,1,0xffffffff)
DrawCircle(zoudjpos1,80,1,1,0xffffffff)
DrawCircle(pos2,80,1,1,0xffffffff)
DrawCircle(zoudjpos2,80,1,1,0xffffffff)
DrawCircle(pos3,80,1,1,0xffffffff)
DrawCircle(zoudjpos3,80,1,1,0xffffffff)
DrawCircle(pos4,80,1,1,0xffffffff)
DrawCircle(zoudjpos4,80,1,1,0xffffffff)
DrawCircle(pos5,80,1,1,0xffffffff)
DrawCircle(zoudjpos5,80,1,1,0xffffffff)
DrawCircle(pos6,80,1,1,0xffffffff)
DrawCircle(zoudjpos6,80,1,1,0xffffffff)
DrawCircle(pos7,80,1,1,0xffffffff)
DrawCircle(zoudjpos7,80,1,1,0xffffffff)
DrawCircle(pos8,80,1,1,0xffffffff)
DrawCircle(zoudjpos8,80,1,1,0xffffffff)
DrawCircle(pos9,80,1,1,0xffffffff)
DrawCircle(zoudjpos9,80,1,1,0xffffffff)
DrawCircle(pos10,80,1,1,0xffffffff)
DrawCircle(zoudjpos10,80,1,1,0xffffffff)
DrawCircle(pos11,80,1,1,0xffffffff)
DrawCircle(zoudjpos11,80,1,1,0xffffffff)
DrawCircle(pos12,80,1,1,0xffffffff)
DrawCircle(zoudjpos12,80,1,1,0xffffffff)
DrawCircle(pos13,80,1,1,0xffffffff)
DrawCircle(zoudjpos13,80,1,1,0xffffffff)
DrawCircle(pos14,80,1,1,0xffffffff)
DrawCircle(zoudjpos14,80,1,1,0xffffffff)
DrawCircle(pos15,80,1,1,0xffffffff)
DrawCircle(zoudjpos15,80,1,1,0xffffffff)
DrawCircle(pos16,80,1,1,0xffffffff)
DrawCircle(zoudjpos16,80,1,1,0xffffffff)
DrawCircle(pos17,80,1,1,0xffffffff)
DrawCircle(zoudjpos17,80,1,1,0xffffffff)
DrawCircle(pos18,80,1,1,0xffffffff)
DrawCircle(zoudjpos18,80,1,1,0xffffffff)
DrawCircle(pos19,80,1,1,0xffffffff)
DrawCircle(zoudjpos19,80,1,1,0xffffffff)
DrawCircle(pos20,80,1,1,0xffffffff)
DrawCircle(zoudjpos20,80,1,1,0xffffffff)
end
if DrawingsAA.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetRange(myHero)+GetHitBox(myHero)*2,3,100,0xffffffff) end
if DrawingsQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if DrawingsE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if DrawingsR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end)

function GetMyHeroPos()
    return GetOrigin(GetMyHero()) 
end

function kalE(x) 
if x <= 1 then return 10 else return kalE(x-1) + 2 + x
end 
end -- too smart for you inspired, thanks for this anyway :3, lazycat

function ValidTarget(unit, range)
    range = range or 25000
    if unit == nil or GetOrigin(unit) == nil or not IsTargetable(unit) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(GetMyHero()) or not IsInDistance(unit, range) then return false end
    return true
end

function IsInDistance(p1,r)
    return GetDistanceSqr(GetOrigin(p1)) < r*r
end

function GetDistance(p1,p2)
    p1 = GetOrigin(p1) or p1
    p2 = GetOrigin(p2) or p2
    return math.sqrt(GetDistanceSqr(p1,p2))
end

function GetDistanceSqr(p1,p2)
    p2 = p2 or GetMyHeroPos()
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
end

function GetEnemyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) ~= GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetAllyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) == GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetAllMinions(team)
    local result = {}
    for _,k in pairs(objectManager.minions) do
        if k and not IsDead(k) and GetCurrentHP(k) < 100000 and GetObjectName(k):find("_") then
            if not team or GetTeam(k) == team then
                result[_] = k
            end
        else
            objectManager.minions[_] = nil
        end
    end
    return result
end

function CountMinions()
    local m = 0
    for _,k in pairs(GetAllMinions()) do 
        m = m + 1 
    end
    return m
end

function CalcDamage(source, target, addmg, apdmg)
    local ADDmg = addmg or 0
    local APDmg = apdmg or 0
    local ArmorPen = math.floor(GetArmorPenFlat(source))
    local ArmorPenPercent = math.floor(GetArmorPenPercent(source)*100)/100
    local Armor = GetArmor(target)*ArmorPenPercent-ArmorPen
    local ArmorPercent = Armor > 0 and math.floor(Armor*100/(100+Armor))/100 or math.ceil(Armor*100/(100-Armor))/100
    local MagicPen = math.floor(GetMagicPenFlat(source))
    local MagicPenPercent = math.floor(GetMagicPenPercent(source)*100)/100
    local MagicArmor = GetMagicResist(target)*MagicPenPercent-MagicPen
    local MagicArmorPercent = MagicArmor > 0 and math.floor(MagicArmor*100/(100+MagicArmor))/100 or math.ceil(MagicArmor*100/(100-MagicArmor))/100
    return (GotBuff(source,"exhausted")  > 0 and 0.4 or 1) * math.floor(ADDmg*(1-ArmorPercent))+math.floor(APDmg*(1-MagicArmorPercent))
end

function VectorPointProjectionOnLineSegment(v1, v2, v)
    assert(v1 and v2 and v, "VectorPointProjectionOnLineSegment: wrong argument types (3 <Vector> expected)")
    local cx, cy, ax, ay, bx, by = v.x, (v.z or v.y), v1.x, (v1.z or v1.y), v2.x, (v2.z or v2.y)
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
    local pointLine = { x = ax + rL * (bx - ax), y = ay + rL * (by - ay) }
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or { x = ax + rS * (bx - ax), y = ay + rS * (by - ay) }
    return pointSegment, pointLine, isOnSegment
end

class 'Vector'

function Vector:__init(a, b, c)
    if a == nil then
        self.x, self.y, self.z = 0.0, 0.0, 0.0
    elseif b == nil then
        a = GetOrigin(a) or a
        assert(VectorType(a), "Vector: wrong argument types (expected nil or <Vector> or 2 <number> or 3 <number>)")
        self.x, self.y, self.z = a.x, a.y, a.z
    else
        assert(type(a) == "number" and (type(b) == "number" or type(c) == "number"), "Vector: wrong argument types (<Vector> or 2 <number> or 3 <number>)")
        self.x = a
        if b and type(b) == "number" then self.y = b end
        if c and type(c) == "number" then self.z = c end
    end
end

function Vector:__type()
    return "Vector"
end

function Vector:__add(v)
    assert(VectorType(v) and VectorType(self), "add: wrong argument types (<Vector> expected)")
    return Vector(self.x + v.x, (v.y and self.y) and self.y + v.y, (v.z and self.z) and self.z + v.z)
end

function Vector:__sub(v)
    assert(VectorType(v) and VectorType(self), "Sub: wrong argument types (<Vector> expected)")
    return Vector(self.x - v.x, (v.y and self.y) and self.y - v.y, (v.z and self.z) and self.z - v.z)
end

function Vector.__mul(a, b)
    if type(a) == "number" and VectorType(b) then
        return Vector({ x = b.x * a, y = b.y and b.y * a, z = b.z and b.z * a })
    elseif type(b) == "number" and VectorType(a) then
        return Vector({ x = a.x * b, y = a.y and a.y * b, z = a.z and a.z * b })
    else
        assert(VectorType(a) and VectorType(b), "Mul: wrong argument types (<Vector> or <number> expected)")
        return a:dotP(b)
    end
end

function Vector.__div(a, b)
    if type(a) == "number" and VectorType(b) then
        return Vector({ x = a / b.x, y = b.y and a / b.y, z = b.z and a / b.z })
    else
        assert(VectorType(a) and type(b) == "number", "Div: wrong argument types (<number> expected)")
        return Vector({ x = a.x / b, y = a.y and a.y / b, z = a.z and a.z / b })
    end
end

function Vector.__lt(a, b)
    assert(VectorType(a) and VectorType(b), "__lt: wrong argument types (<Vector> expected)")
    return a:len() < b:len()
end

function Vector.__le(a, b)
    assert(VectorType(a) and VectorType(b), "__le: wrong argument types (<Vector> expected)")
    return a:len() <= b:len()
end

function Vector:__eq(v)
    assert(VectorType(v), "__eq: wrong argument types (<Vector> expected)")
    return self.x == v.x and self.y == v.y and self.z == v.z
end

function Vector:__unm()
    return Vector(-self.x, self.y and -self.y, self.z and -self.z)
end

function Vector:__vector(v)
    assert(VectorType(v), "__vector: wrong argument types (<Vector> expected)")
    return self:crossP(v)
end

function Vector:__tostring()
    if self.y and self.z then
        return "(" .. tostring(self.x) .. "," .. tostring(self.y) .. "," .. tostring(self.z) .. ")"
    else
        return "(" .. tostring(self.x) .. "," .. self.y and tostring(self.y) or tostring(self.z) .. ")"
    end
end

function Vector:clone()
    return Vector(self)
end

function Vector:unpack()
    return self.x, self.y, self.z
end

function Vector:len2(v)
    assert(v == nil or VectorType(v), "dist: wrong argument types (<Vector> expected)")
    local v = v and Vector(v) or self
    return self.x * v.x + (self.y and self.y * v.y or 0) + (self.z and self.z * v.z or 0)
end

function Vector:len()
    return math.sqrt(self:len2())
end

function Vector:dist(v)
    assert(VectorType(v), "dist: wrong argument types (<Vector> expected)")
    local a = self - v
    return a:len()
end

function Vector:normalize()
    local a = self:len()
    self.x = self.x / a
    if self.y then self.y = self.y / a end
    if self.z then self.z = self.z / a end
end

function Vector:normalized()
    local a = self:clone()
    a:normalize()
    return a
end

function Vector:center(v)
    assert(VectorType(v), "center: wrong argument types (<Vector> expected)")
    return Vector((self + v) / 2)
end

function Vector:crossP(other)
    assert(self.y and self.z and other.y and other.z, "crossP: wrong argument types (3 Dimensional <Vector> expected)")
    return Vector({
        x = other.z * self.y - other.y * self.z,
        y = other.x * self.z - other.z * self.x,
        z = other.y * self.x - other.x * self.y
    })
end

function Vector:dotP(other)
    assert(VectorType(other), "dotP: wrong argument types (<Vector> expected)")
    return self.x * other.x + (self.y and (self.y * other.y) or 0) + (self.z and (self.z * other.z) or 0)
end

function Vector:projectOn(v)
    assert(VectorType(v), "projectOn: invalid argument: cannot project Vector on " .. type(v))
    if type(v) ~= "Vector" then v = Vector(v) end
    local s = self:len2(v) / v:len2()
    return Vector(v * s)
end

function Vector:mirrorOn(v)
    assert(VectorType(v), "mirrorOn: invalid argument: cannot mirror Vector on " .. type(v))
    return self:projectOn(v) * 2
end

function Vector:sin(v)
    assert(VectorType(v), "sin: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    local a = self:__vector(v)
    return math.sqrt(a:len2() / (self:len2() * v:len2()))
end

function Vector:cos(v)
    assert(VectorType(v), "cos: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    return self:len2(v) / math.sqrt(self:len2() * v:len2())
end

function Vector:angle(v)
    assert(VectorType(v), "angle: wrong argument types (<Vector> expected)")
    return math.acos(self:cos(v))
end

function Vector:affineArea(v)
    assert(VectorType(v), "affineArea: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    local a = self:__vector(v)
    return math.sqrt(a:len2())
end

function Vector:triangleArea(v)
    assert(VectorType(v), "triangleArea: wrong argument types (<Vector> expected)")
    return self:affineArea(v) / 2
end

function Vector:rotateXaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.y, self.z = self.y * c - self.z * s, self.z * c + self.y * s
end

function Vector:rotateYaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.x, self.z = self.x * c + self.z * s, self.z * c - self.x * s
end

function Vector:rotateZaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.x, self.y = self.x * c - self.z * s, self.y * c + self.x * s
end

function Vector:rotate(phiX, phiY, phiZ)
    assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    if phiX ~= 0 then self:rotateXaxis(phiX) end
    if phiY ~= 0 then self:rotateYaxis(phiY) end
    if phiZ ~= 0 then self:rotateZaxis(phiZ) end
end

function Vector:rotated(phiX, phiY, phiZ)
    assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotated: wrong argument types (expected <number> for phi)")
    local a = self:clone()
    a:rotate(phiX, phiY, phiZ)
    return a
end

-- not yet full 3D functions
function Vector:polar()
    if math.close(self.x, 0) then
        if (self.z or self.y) > 0 then return 90
        elseif (self.z or self.y) < 0 then return 270
        else return 0
        end
    else
        local theta = math.deg(math.atan((self.z or self.y) / self.x))
        if self.x < 0 then theta = theta + 180 end
        if theta < 0 then theta = theta + 360 end
        return theta
    end
end

function Vector:angleBetween(v1, v2)
    assert(VectorType(v1) and VectorType(v2), "angleBetween: wrong argument types (2 <Vector> expected)")
    local p1, p2 = (-self + v1), (-self + v2)
    local theta = p1:polar() - p2:polar()
    if theta < 0 then theta = theta + 360 end
    if theta > 180 then theta = 360 - theta end
    return theta
end

function Vector:compare(v)
    assert(VectorType(v), "compare: wrong argument types (<Vector> expected)")
    local ret = self.x - v.x
    if ret == 0 then ret = self.z - v.z end
    return ret
end

function Vector:perpendicular()
    return Vector(-self.z, self.y, self.x)
end

function Vector:perpendicular2()
    return Vector(self.z, self.y, -self.x)
end

class "Circle" -- {
  function Circle:__init(x, y, z, r)
    local pos = GetOrigin(x) or type(x) ~= "number" and x or nil
    self.x = pos and pos.x or x
    self.y = pos and pos.y or y
    self.z = pos and pos.z or z
    self.r = pos and y or r
  end

  function Circle:contains(pos)
    return GetDistanceSqr(Vector(self.x, self.y, self.z), pos) < self.r * self.r
  end
