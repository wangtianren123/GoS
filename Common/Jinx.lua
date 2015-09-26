if GetObjectName(myHero) ~= "Jinx" then return end

JinxMenu = Menu("Jinx", "Jinx")
JinxMenu:SubMenu("Combo", "Combo")
JinxMenu.Combo:Boolean("Q", "Use Q", true)
JinxMenu.Combo:Boolean("W", "Use W", true)
JinxMenu.Combo:Boolean("E", "Use E", true)
JinxMenu.Combo:Boolean("ECC", "Auto E on CCed", true)
JinxMenu.Combo:Boolean("R", "Use R (Finisher)", true)
JinxMenu.Combo:Boolean("Items", "Use Items", true)
JinxMenu.Combo:Slider("myHP", "if HP % <", 50, 0, 100, 1)
JinxMenu.Combo:Slider("targetHP", "if Target HP % >", 20, 0, 100, 1)
JinxMenu.Combo:Boolean("QSS", "Use QSS", true)
JinxMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)
JinxMenu.Combo:Boolean("Farm", "Switch Q in X/V", true)

JinxMenu:SubMenu("Harass", "Harass")
JinxMenu.Harass:Boolean("Q", "Use Q", true)
JinxMenu.Harass:Boolean("W", "Use W", true)
JinxMenu.Harass:Boolean("E", "Use E", true)
JinxMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

JinxMenu:SubMenu("Killsteal", "Killsteal")
JinxMenu.Killsteal:Boolean("W", "Killsteal with W", true)
JinxMenu.Killsteal:Boolean("R", "Killsteal with R", true)

JinxMenu:SubMenu("Misc", "Misc")
JinxMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
JinxMenu.Misc:Boolean("Autolvl", "Auto level", true)
JinxMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "W-Q-E"})

JinxMenu:SubMenu("Drawings", "Drawings")
JinxMenu.Drawings:Boolean("W", "Draw W Range", true)
JinxMenu.Drawings:Boolean("E", "Draw E Range", true)

local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
BaseultMenu = Menu("Baseult", "Baseult")
BaseultMenu:Boolean("Enabled", "Enabled", true)
BaseultMenu:Boolean("RT", "RecallTracker", true)
myHero = GetMyHero()
mapID = GetMapID()

if mapID == SUMMONERS_RIFT and GetTeam(myHero) == 100 then
enemyBasePos = Vector(14340, 171, 14390)
elseif mapID == SUMMONERS_RIFT and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(400, 200, 400)
end

if mapID == CRYSTAL_SCAR and GetTeam(myHero) == 100 then
enemyBasePos = Vector(13321, -37, 4163)
elseif mapID == CRYSTAL_SCAR and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(527, -35, 4163)
end

if mapID == TWISTED_TREELINE and GetTeam(myHero) == 100 then
enemyBasePos = Vector(14320, 151, 7235)
elseif mapID == TWISTED_TREELINE and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(1060, 150, 7297)
end

delay = 600
missileSpeed = (GoS:GetDistance(enemyBasePos) / (1 + (GoS:GetDistance(enemyBasePos)-1500)/2500)) -- thanks Noddy
damage = function(target) return GoS:CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R)) + 150 + 100*GetCastLevel(myHero,_R) + GetBonusDmg(myHero)) end

OnLoop(function(myHero)

if BaseultMenu.RT:Value() then 
RecallTracker()
end

    if IOW:Mode() == "Combo" then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,700,2500,140,false,true)
		
	if GetItemSlot(myHero,3140) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and JinxMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
	if CanUseSpell(myHero, _Q) == READY and JinxMenu.Combo.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 525 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and JinxMenu.Combo.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and IsFacing(target,GetCastRange(myHero,_E)) and JinxMenu.Combo.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x-100,EPred.PredPos.y-100,EPred.PredPos.z-100)
        elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and JinxMenu.Combo.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x+100,EPred.PredPos.y+100,EPred.PredPos.z+100)
        end
	
	if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(target, 2500) and JinxMenu.Combo.R:Value() and GetCurrentHP(target) < GoS:CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(target)/1700))) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end

  end

    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= JinxMenu.Harass.Mana:Value() then
	
	local target = GetCurrentTarget()
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),3300,600,GetCastRange(myHero,_W),60,true,true)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,1200,GetCastRange(myHero,_E),60,false,true)
		
	if CanUseSpell(myHero, _Q) == READY and JinxMenu.Harass.Q:Value() and GoS:ValidTarget(target, 700) then
          if GoS:GetDistance(myHero, target) > 525 and GotBuff(myHero, "jinxqicon") > 0 then
          CastSpell(_Q)
          elseif GoS:GetDistance(myHero, target) < 525 and GotBuff(myHero, "JinxQ") > 0 then
          CastSpell(_Q)
          end
        end
	
	if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and JinxMenu.Harass.W:Value() then
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end
	
	if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and IsFacing(target,GetCastRange(myHero,_E)) and JinxMenu.Harass.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x-100,EPred.PredPos.y-100,EPred.PredPos.z-100)
        elseif CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and JinxMenu.Harass.E:Value() then
        CastSkillShot(_E,EPred.PredPos.x+100,EPred.PredPos.y+100,EPred.PredPos.z+100)
        end
		
	end

local target = GetCurrentTarget()
local targetpos = GetOrigin(target)

if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
  if GotBuff(target, "snare") > 0 or GotBuff(target, "suppression") > 0 or GotBuff(target, "stun") > 0 then
  CastSkillShot(_E, targetPos.x, targetPos.y, targetPos.z)
  end
end

if IOW:Mode() == "LastHit" then
  if GotBuff(myHero, "JinxQ") > 0 and JinxMenu.Combo.Farm:Value() then
  CastSpell(_Q)
  end
end
  
if IOW:Mode() == "LaneClear" then
  if GotBuff(myHero, "JinxQ") > 0 and JinxMenu.Combo.Farm:Value() then
  CastSpell(_Q)
  end
end
  

    for i,enemy in pairs(GoS:GetEnemyHeroes()) do
    
	local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),3300,600,GetCastRange(myHero,_W),60,true,true)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2300,700,4000,140,false,true)
		
	if GetItemSlot(myHero,3153) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > JinxMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3153))
        end

        if GetItemSlot(myHero,3144) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < JinxMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > JinxMenu.Combo.targetHP:Value() then
        CastTargetSpell(enemy, GetItemSlot(myHero,3144))
        end

        if GetItemSlot(myHero,3142) > 0 and JinxMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 600) then
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if Ignite and JinxMenu.Misc.AutoIgnite:Value() then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
		
        if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_W)) and JinxMenu.Killsteal.W:Value() and WPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 50*GetCastLevel(myHero,_Q) - 40 + 1.4*GetBaseDamage(myHero)) then  
        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	elseif CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(enemy, 4000) and GoS:GetDistance(myHero, enemy) > 400 and JinxMenu.Killsteal.R:Value() and RPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, (GetMaxHP(enemy)-GetCurrentHP(enemy))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GoS:GetDistance(enemy)/1700))) then 
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
    end

if JinxMenu.Misc.Autolvl:Value() then
    if JinxMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
    elseif JinxMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
    end
LevelSpell(leveltable[GetLevel(myHero)])
end

if JinxMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),0,1,0xff00ff00) end
if JinxMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),0,1,0xff00ff00) end

end)

--------------------------------------Thanks Maxxxel For this <3--------------------------------
local myHero = GetMyHero()
local lastattackposition={true,true,true}

function IsFacing(targetFace,range,unit) 
	range=range or 99999
	unit=unit or myHero
	targetFace=targetFace
	if (targetFace and unit)~=nil and (ValidtargetUnit(targetFace,range,unit)) and GetDistance2(targetFace,unit)<=range then
		local unitXYZ= GetOrigin(unit)
		local targetFaceXYZ=GetOrigin(targetFace)
		local lastwalkway={true,true,true}
		local walkway = GetPredictionForPlayer(GetOrigin(unit),targetFace,GetMoveSpeed(targetFace),0,1000,2000,0,false,false)

		if walkway.PredPos.x==targetFaceXYZ.x then

			if lastwalkway.x~=nil then

				local d1 = GetDistance2(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1


    	elseif lastwalkway.x==nil then
    		if lastattackposition.x~=nil and lastattackposition.name==GetObjectName(targetFace) then
					local d1 = GetDistance2(targetFace,unit)
    			local d2 = GetDistance2XYZ(lastattackposition.x,lastattackposition.z,unitXYZ.x,unitXYZ.z)
    			return d2 < d1
    		end
    	end
    elseif walkway.PredPos.x~=targetFaceXYZ.x then
    	lastwalkway={x=walkway.PredPos.x,y=walkway.PredPos.y,z=walkway.PredPos.z} 

    	if lastwalkway.x~=nil then
		local d1 = GetDistance2(targetFace,unit)
    		local d2 = GetDistance2XYZ(lastwalkway.x,lastwalkway.z,unitXYZ.x,unitXYZ.z)
    		return d2 < d1
    	end
    end
	end
end


function ValidtargetUnit(targetFace,range,unit)
    range = range or 25000
    unit = unit or myHero
    if targetFace == nil or GetOrigin(targetFace) == nil or IsImmune(targetFace,unit) or IsDead(targetFace) or not IsVisible(targetFace) or GetTeam(targetFace) == GetTeam(unit) or GetDistance2(targetFace,unit)>range then return false end
    return true
end

function GetDistance2(p1,p2)
    p1 = GetOrigin(p1) or p1
    p2 = GetOrigin(p2) or p2
    return math.sqrt(GetDistance2Sqr(p1,p2))
end

function GetDistance2Sqr(p1,p2)
    p2 = p2 or GetMyHeroPos()
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
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

OnProcessSpell(function(Object,spellProc)
	local Obj_Type = GetObjectType(Object)
	if Object~=nil and Obj_Type==Obj_AI_Hero then
		if spellProc.name~=nil then
			for i,enemy in pairs(GoS:GetEnemyHeroes()) do
				if ValidtargetUnit(enemy,25000) then
					local targetFaceXYZ=GetOrigin(enemy)
					if (spellProc.name:find("Attack") and spellProc.BaseName~=nil and spellProc.BaseName:find(GetObjectName(enemy))) then 

						if spellProc.startPos.x==targetFaceXYZ.x and spellProc.startPos.y==targetFaceXYZ.y and spellProc.startPos.z==targetFaceXYZ.z then 
							if spellProc.endPos.x ~=targetFaceXYZ.x and spellProc.endPos.y ~=targetFaceXYZ.y and spellProc.endPos.z ~=targetFaceXYZ.z then 

								lastattackposition={x=spellProc.endPos.x,y=spellProc.endPos.y,z=spellProc.endPos.z,Name=GetObjectName(enemy)}
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
	end
end)

local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = false

function RecallTracker()
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
	
	if CanUseSpell(myHero, _R) == READY and BaseultMenu.Enabled:Value() and GetTeam(Object) ~= GetTeam(myHero) then
		if damage(Object) > GetCurrentHP(Object) then
			local timeToRecall = recallProc.totalTime
			local distance = GoS:GetDistance(enemyBasePos)
			local timeToHit = delay + (distance * 1000 / missileSpeed)
			if timeToRecall > timeToHit then
				recallPos = Vector(Object)
				PrintChat("BaseUlt on "..GetObjectName(Object)"")
				GoS:DelayAction(
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

GoS:AddGapcloseEvent(_E, 0, false) -- hi Copy-Pasters ^^
