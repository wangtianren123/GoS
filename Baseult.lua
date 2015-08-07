PrintChat("Baseult 4.0 Made By Deftsu / Credits : Inspired <3 and Feretorix for this awesome tool #MissLaihaSenpai")
local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
BaseUltConfig = scriptConfig("BaseUlt", "BaseUlt")
BaseUltConfig.addParam("doIt", "Do BaseUlt", SCRIPT_PARAM_ONOFF, true) 
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
elseif GetObjectName(myHero) == "Draven" then
	delay = 400
	missileSpeed = 2000
	damage = function(target) return CalcDamage(myHero, target, 75 + 100*GetCastLevel(myHero,_R) + 1.1*GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Ezreal" then
	delay = 1000
	missileSpeed = 2000
	damage = function(target) return CalcDamage(myHero, target, 0, 200 + 150*GetCastLevel(myHero,_R) + .9*GetBonusAP(myHero)+GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Jinx" then
	delay = 600
	missileSpeed = 2300
	damage = function(target) return CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R)) + 150 + 100*GetCastLevel(myHero,_R) + GetBonusDmg(myHero)) end
end

OnProcessRecall(function(Object,recallProc)
	if CanUseSpell(myHero, _R) == READY and BaseUltConfig.doIt and GetTeam(Object) ~= GetTeam(myHero) then
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
end)

local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = true

OnLoop(function()
	
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
PrintChat("Recall tracker by Krystian loaded.")
