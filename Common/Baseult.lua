local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
BaseultMenu = Menu("Baseult", "Baseult")
BaseultMenu:Boolean("Enabled", "Enabled", true)
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

if GetObjectName(myHero) == "Ashe" then
	delay = 250
	missileSpeed = 1600
	damage = function(target) return GoS:CalcDamage(myHero, target, 0, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero)) end
elseif GetObjectName(myHero) == "Draven" then
	delay = 400
	missileSpeed = 2000
	damage = function(target) return GoS:CalcDamage(myHero, target, 75 + 100*GetCastLevel(myHero,_R) + 1.1*GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Ezreal" then
	delay = 1000
	missileSpeed = 2000
	damage = function(target) return GoS:CalcDamage(myHero, target, 0, 200 + 150*GetCastLevel(myHero,_R) + .9*GetBonusAP(myHero)+GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Jinx" then
	delay = 600
        missileSpeed = (GoS:GetDistance(enemyBasePos) / (1 + (GoS:GetDistance(enemyBasePos)-1500)/2500)) -- thanks Noddy
	damage = function(target) return GoS:CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R)) + 150 + 100*GetCastLevel(myHero,_R) + GetBonusDmg(myHero)) end
end

OnProcessRecall(function(Object,recallProc)
	if CanUseSpell(myHero, _R) == READY and BaseultMenu.Enabled:Value() and GetTeam(Object) ~= GetTeam(myHero) then
		if damage(Object) > GetCurrentHP(Object) then
			local timeToRecall = recallProc.totalTime
			local distance = GoS:GetDistance(enemyBasePos)
			local timeToHit = delay + (distance * 1000 / missileSpeed)
			if timeToRecall > timeToHit then
				recallPos = Vector(Object)
				PrintChat("BaseUlt on "..GetObjectName(Object).."")
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
end)
