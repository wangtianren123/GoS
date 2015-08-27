PrintChat("D3ftland Ashe By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Ashe", "Ashe")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, false)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl Q-W-E", SCRIPT_PARAM_ONOFF, false)
MiscConfig.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item5", "Use Mercurial", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSW", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
BaseUltConfig = scriptConfig("BaseUlt", "BaseUlt")
BaseUltConfig.addParam("doIt", "BaseUlt (broken)", SCRIPT_PARAM_ONOFF, true) 

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

if MiscConfig.Autolvl then
LevelUp()
end

if GetItemSlot(myHero,3140) > 0 and MiscConfig.Item4 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3140))
end

if GetItemSlot(myHero,3139) > 0 and MiscConfig.Item5 and GotBuff(myHero, "Stun") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "mordekaiserchildrenofthegrave") > 0 or GotBuff(myHero, "bruammark") > 0 or GotBuff(myHero, "zedulttargetmark") > 0 or GotBuff(myHero, "fizzmarinerdoombomb") > 0 or GotBuff(myHero, "soulshackles") > 0 or GotBuff(myHero, "varusrsecondary") > 0 or GotBuff(myHero, "vladimirhemoplague") > 0 or GotBuff(myHero, "urgotswap2") > 0 or GotBuff(myHero, "skarnerimpale") > 0 or GotBuff(myHero, "poppydiplomaticimmunity") > 0 or GotBuff(myHero, "leblancsoulshackle") > 0 or GotBuff(myHero, "leblancsoulshacklem") > 0 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.75 then
CastTargetSpell(myHero, GetItemSlot(myHero,3139))
end	

        local target = GetTarget(1000, DAMAGE_PHYSICAL)
	if ValidTarget(target, 1000) then
		if IWalkConfig.Combo then
			if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and IsInDistance(target, 700) and Config.Q then
                        CastSpell(_Q)
                        end
						
			local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_W),50,true,true)
                        if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	                end
						
					
                        local target = GetTarget(1000, DAMAGE_PHYSICAL)
			local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
                        if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GetCurrentHP(target)/GetMaxHP(target) < 0.5 and Config.R then
                        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                end
	                
	                if GetItemSlot(myHero,3153) > 0 and MiscConfig.Item1 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
                        CastTargetSpell(target, GetItemSlot(myHero,3153))
                        end

                        if GetItemSlot(myHero,3144) > 0 and MiscConfig.Item2 and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.5 and GetCurrentHP(target)/GetMaxHP(target) > 0.2 then
                        CastTargetSpell(target, GetItemSlot(myHero,3144))
                        end

                        if GetItemSlot(myHero,3142) > 0 and MiscConfig.Item3 then
                        CastTargetSpell(GetItemSlot(myHero,3142))
                        end
		end
	end
		
	if IWalkConfig.Harass then
	        local target = GetTarget(1000, DAMAGE_PHYSICAL)
		local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_W),50,true,true)
		              
		if ValidTarget(target, 1000) then
		
		     if (GetCurrentMana(myHero)/GetMaxMana(myHero)) > 0.2 then
			if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and IsInDistance(target, 700) and HarassConfig.HarassQ then
                        CastSpell(_Q)
                        elseif CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and HarassConfig.HarassW then
                        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
			end
	             end
		end
	end
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	          local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2000,250,GetCastRange(myHero,_W),50,true,true)
		  if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_W)) and KSConfig.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 15*GetCastLevel(myHero,_W)+5+GetBaseDamage(myHero), 0) then 
		  CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		  end
		  local RPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,20000,130,false,true)
		  if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(enemy, 3000) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 175*GetCastLevel(myHero,_R) + 75 + GetBonusAP(myHero)) then
                  CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		  end
	end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
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

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
end

local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
ExtraConfig.addParam("Baseult", "Baseult", SCRIPT_PARAM_ONOFF, true)
myHero = GetMyHero()

if GetTeam(myHero) == 100 then 
enemyBasePos = Vector(14340, 171, 14390)
elseif GetTeam(myHero) == 200 then 
enemyBasePos = Vector(400, 200, 400)
end

if GetObjectName(myHero) == "Ashe" then
	delay = 250
	missileSpeed = 1600
	damage = function(target) return CalcDamage(myHero, target, 0, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero)) end
end

local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = true
ExtraConfig.addParam("Recalltracker", "Recall tracker", SCRIPT_PARAM_ONOFF, true)

OnLoop(function()
if ExtraConfig.Recalltracker then
	local i = 0
	for hero, recallObj in pairs(recalling) do
		local percent=math.floor(GetCurrentHP(recallObj.hero)/GetMaxHP(recallObj.hero)*100)
		local color=percentToRGB(percent)
		local leftTime = recallObj.starttime - GetTickCount() + recallObj.info.totalTime
		
		if leftTime<0 then leftTime = 0 end
		FillRect(x,y+rowHeight*i-2,168,rowHeight,0x50000000)
		if i>0 then FillRect(x,y+rowHeight*i-2,168,1,0xC0000000) end
		
		DrawText(string.format("%s (%d%%)", hero, percent), 14, x+2, y+rowHeight*i, color)
		
		if recallObj.info.isStart then
			DrawText(string.format("%.1fs", leftTime/1000), 14, x+115, y+rowHeight*i, color)
			FillRect(x+169,y+rowHeight*i, barWidth*leftTime/recallObj.info.totalTime,14,0x80000000)
		else
			if recallObj.killtime == nil then
				if recallObj.info.isFinish and not recallObj.info.isStart then
			    recallObj.result = "finished"
				recallObj.killtime =  GetTickCount()+2000
				elseif not recallObj.info.isFinish then
				recallObj.result = "cancelled"
				recallObj.killtime =  GetTickCount()+2000
				end
				
			end
			DrawText(recallObj.result, 14, x+115, y+rowHeight*i, color)
		end
		
		if recallObj.killtime~=nil and GetTickCount() > recallObj.killtime then
			recalling[hero] = nil
		end
		
		i=i+1
	end
end
end)

function percentToRGB(percent) 
	local r, g
    if percent == 100 then
        percent = 99 end
		
    if percent < 50 then
        r = math.floor(255 * (percent / 50))
        g = 255
    else
        r = 255
        g = math.floor(255 * ((50 - percent % 50) / 50))
    end
	
    return 0xFF000000+g*0xFFFF+r*0xFF
end

OnProcessRecall(function(Object,recallProc)
	if CanUseSpell(myHero, _R) == READY and ExtraConfig.Baseult and GetTeam(Object) ~= GetTeam(myHero) then
		if damage(Object) > GetCurrentHP(Object) then
			local timeToRecall = recallProc.totalTime
			local distance = GetDistance(enemyBasePos)
			local timeToHit = delay + (distance * 1000 / missileSpeed)
			if timeToRecall > timeToHit then
				recallPos = Vector(Object)
				print("BaseUlt on "..GetObjectName(Object), 2, 0xffff0000)
				DelayAction(
					function() 
						if recallPos == Vector(Object) then
						CastSkillShot(_R, enemyBasePos.x, enemyBasePos.y, enemyBasePos.z)
						recallPos = nil
						end
					end, 
					timeToRecall-timeToHit
				)
			end
		end
	end
	
	
	if onlyEnemies and GetTeam(GetMyHero())==GetTeam(Object) then return end
	if onlyFOW and recalling[GetObjectName(Object)] == nil  and IsVisible(Object) then return end
	
	rec = {}
	rec.hero = Object
	rec.info = recallProc
	rec.starttime = GetTickCount()
	rec.killtime = nil
	rec.result = nil
	recalling[GetObjectName(Object)] = rec
	
end)

addInterrupterCallback(function(target, spellType)
local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,250,2000,130,false,true)
  if IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

AddGapcloseEvent(_R, 1000, false)
