spawnTable = {
[100] = Vector(redTeam),
[200] = Vector(blueTeam)
}

local recalling = {}
local leftTime = recallProc.totalTime - recallProc.passedTime

function enemyBasePos
 if GetTeam(myHero) == 100 then enemyBasePos = Vector(14340, 171, 14390)
 elseif GetTeam(myHero) == 200 then enemyBasePos = Vector(529, -36, 4169)
 end
end



OnLoop(function(myHero)
 local target = GetCurrentTarget()
 if ValidTarget(target, 20000) then
 local myHeroPos = GetOrigin(myHero)
  if GetObjectName(myHero) == "Ashe" then
    delay = 250
    missileSpeed = 1600
    local damage = CalcDamage(myHero, target, 0, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero))
  elseif GetObjectName(myHero) == "Draven" then
    delay = 400
    missileSpeed = 2000
    local damage = CalcDamage(myHero, target, 75 + 100*GetCastLevel(myHero,_R) + 1.1*GetBonusDmg(myHero), 0)
  elseif GetObjectName(myHero) == "Ezreal" then
    delay = 1000
    missileSpeed = 2000
    local damage = CalcDamage(myHero, target, 0, 200 + 150*GetCastLevel(myHero,_R) + .9*GetBonusAP(myHero)+GetBonusDmg(myHero))
  elseif GetObjectName(myHero) == "Jinx" then
    delay = 600
    missileSpeed = 1700
    local damage = CalcDamage(myHero, target, 150 + 100*GetCastLevel(myHero,_R) + 0.5*GetBonusDmg(myHero), 0 )
  end

 end
end)

OnProcessRecall(function(Object,recallProc)
end)

if CanUseSpell(_R) == READY then
   if damage > GetCurrentHP(target) then
        local timeToRecall = recallProc.totalTime
        local distance = GetDistance(enemyBasePos)
        local TimeToHit = delay + (distance / missileSpeed)
        if timeToRecall < TimeToHit and damage > GetCurrentHP(target) then
        CastSkillShot(_R, enemyBasePos.x, enemyBasePos.y, enemyBasePos.z)
        end
   end
end
