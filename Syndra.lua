Config = scriptConfig("Syndra", "Syndra")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

local Balls = {}
local BallDuration = 6900

function GetUltCombo()
	local result = {}
	for i = 1, #GetValidBalls() do
		table.insert(result, _R)
	end
	return result
end
-- Credits go to Sania For his Balls :P i mean Balls Functions :3
function OnProcessSpell(unit, spell)
      if unit and unit == GetMyHero() and spell and spell.name == "SyndraQ" then
			Q.LastCastTime = GetTickCount()
			OnCastQ(spell)
		elseif spell and spell.name == "SyndraE" then	
			E.LastCastTime = GetTickCount()
		elseif spell and spell.name =="SyndraW" then
			W.LastCastTime = GetTickCount()
            Recieved = 0
			RecvCounter = 0
		elseif spell and spell.name == "syndrawcast" then
			Recieved = 1
		elseif spell and spell.name == "syndrae5" then
			E.LastCastTime = GetTickCount()
		end
end

function GetValidBalls(ForE)
	if (ForE == nil) or (ForE == false) then
		local result = {}
		for i, ball in ipairs(Balls) do
			if (ball.added or ball.startT <= GetTickCount()) and Balls[i].endT >= GetTickCount() and ball.object.valid then
				if not WObject or ball.object.networkID ~= WObject.networkID then
					table.insert(result, ball)
				end
			end
		end
		return result
	else
		local result = {}
		for i, ball in ipairs(Balls) do
			if (ball.added or ball.startT <= GetTickCount() + (E.delay + GetDistance(myHero, ball.object) / E.speed)) and Balls[i].endT >= GetTickCount() + (E.delay + GetDistance(myHero, ball.object) / E.speed) and ball.object.valid then
				if not WObject or ball.object.networkID ~= WObject.networkID then
					table.insert(result, ball)
				end
			end
		end
		return result
	end
end

function AddBall(obj)
	for i = #Balls, 1, -1 do
		if not Balls[i].added and GetDistanceSqr(Balls[i].object, obj) < 50*50 then
			Balls[i].added = true
			Balls[i].object = obj
			do return end
		end
	end

	local BallInfo = {
							 added = true, 
							 object = obj,
							 startT = GetTickCount(),
							 endT = GetTickCount() + BallDuration
					}
	table.insert(Balls, BallInfo)						
end

function BTOnTick()
	for i = #Balls, 1, -1 do
		if Balls[i].endT <= GetTickCount() then
			table.remove(Balls, i)
		end
	end
end


function GetWValidBall(OnlyBalls)
	local all = GetValidBalls()
	local inrange = {}

	for i, ball in ipairs(all) do
		if GetDistanceSqr(ball.object, myHero) <= W.rangeSqr then
			table.insert(inrange, ball)
		end
	end

	local minEnd = math.huge
	local minBall

	for i, ball in ipairs(inrange) do
		if ball.endT < minEnd then
			minBall = ball
			minEnd = ball.endT
		end
	end

	if minBall then
		return minBall
	end
	if OnlyBalls then 
		return 
	end
end

function OnCastQ(spell)
	local BallInfo = {
						added = false, 
						object = {valid = true, x = spell.endPos.x, y = myHero.y, z = spell.endPos.z},
						startT = GetTickCount() + Q.delay,
						endT = GetTickCount() + BallDuration + Q.delay, 
					 }
	if (GetTickCount() - QECombo < 1.5) then
		local Delay = Q.delay - (E.delay + GetDistance(myHero, BallInfo.object) / E.speed)
		DelayAction(function(t) CastQE2(t) end, Delay, {BallInfo})
	else
		Qdistance = nil
		EQTarget = nil
		EQCombo = 0
	end
	table.insert(Balls, BallInfo)
end
	
OnLoop(function(myHero)

	if IWalkConfig.Combo then
	       local target = GetTarget(1000, DAMAGE_MAGIC)
	                if ValidTarget(target, 1000) then
		
		
		                        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,790,125,false,true)
								local QEPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2500,500,730,45,false,true)
                                if QPred.HitChance == 1 and QEPred.HitChance == 1 and Config.Q and Config.E then
								CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)								
			                    DelayAction(function() CastSkillShot(_E,QEPred.PredPos.x,QEPred.PredPos.y,QEPred.PredPos.z) end, 0.25)
					            end
								
								local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,800,925,190,false,true)
								local validball = GetWValidBall()
			                    if validball and Config.W then
								DelayAction(function() CastTargetSpell(_W, validball.object.x, validball.object.z) end, 0.2)
                                end
								
                                if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
                                CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                                end
								
								if CanUseSpell(myHero, _R) == READY and CalcDamage(myHero, target, 0, math.max(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero),(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero))*BallInfo)) > GetCurrentHP(target) and Config.R then
								CastTargetSpell(target, _R)
								end
								
                      end
    end
end)
		
