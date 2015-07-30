
local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
BaseUltConfig = scriptConfig("BaseUlt", "BaseUlt")
BaseUltConfig.addParam("doIt", "Do BaseUlt", SCRIPT_PARAM_ONOFF, true) 
myHero = GetMyHero()

if GetTeam(myHero) == 100 then 
	enemyBasePos = Vector(14340, 171, 14390)
elseif GetTeam(myHero) == 200 then 
	enemyBasePos = Vector(529, -36, 4169)
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
