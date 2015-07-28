local activeRecalls = { }

spawnTable = {
[100] = Vector(redTeam),
[200] = Vector(blueTeam)
}
function enemySpawnPos
    enemySpawnPos = GetTeam(myHero) == 200 and Vector(529, -36, 4169) or Vector(13311, -38, 4161)
  else
    enemySpawnPos = GetTeam(myHero) == 200 and Vector(1066, 150, 7303) or Vector(14312, 152, 7235)
  else
    enemySpawnPos = GetTeam(myHero) == 200 and Vector(396, 182, 462) or Vector(14340, 171, 14390)
  else
 end
  
OnLoop(function(myHero)
local target = GetTarget(20000, DAMAGE_MAGIC)
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

Config = scriptConfig("BaseUlt", "baseUlt")
local mousePos = GetMousePos()
DrawText("x: "..myHeroPos.x, 25, 250, 200, 0xffffffff)
DrawText("y: "..myHeroPos.y, 25, 250, 225, 0xffffffff)
DrawText("z: "..myHeroPos.z, 25, 250, 250, 0xffffffff)

end
end)

OnProcessRecall(function(Object,recallProc)
end)

function BaseUlt()
  if CanUseSpell(_R) == READY then
    for nID, recall in pairs(activeRecalls) do
      if damage >= GetCurrentHP(target) then
        local timeToRecall = recallProc.totalTime
        local distance = GetDistance(enemySpawnPos)
        local timeToHit = delay + (distance / missileSpeed) + (GetLatency() / 2000)
        if timeToRecall < timeToHit and damage >= GetCurrentHP(target) then
          nextCastTime = GetInGameTimer() + 12500
          return CastSpell(_R, enemySpawnPos.x, enemySpawnPos.z)
        end
      end
    end
  end
end
