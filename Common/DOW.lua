local projSpeed = 0
local AttackSpeed = 0.665
local attackDelay = 600
local lastAttack = 0
local projAt = 0
local Skills
local enemyMinions
local allyMinions
local lastEnemy
local lastRange
local killableMinion
local pluginMinion
local minionInfo = {}
local incomingDamage = {}
local jungleMobs = {}
local turretMinion = {timeToHit = 0, Object = nil}
local isMelee = GetRange(myHero) < 300
local movementStopped = false
local TimedMode = false
local Tristana = false
local ChampInfo = {}
local lastAttacked = nil
local previousWindUp = 0
local previousAttackCooldown = 0  
DOW.Orbwalker = nil
DOW.SkillsCrosshair = nil
DOW.CanMove = true
DOW.CanAttack = true
DOW.MainMenu = nil
DOW.EnemyTable = nil
DOW.shotFired = false
DOW.CurrentlyShooting = false
 
function getTrueRange()
return GetRange(myHero + GoS:GetDistance(GetHitBox(myHero))
end
