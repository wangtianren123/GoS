Config = scriptConfig("Sion", "Sion")
Config.addParam("R", "Use R (Exploit)", SCRIPT_PARAM_KEYDOWN, string.byte("R"))

myIAC = IAC()

OnLoop(function(myHero)
local HeroPos = GetOrigin(myHero)
local mousePos = GetMousePos()
local Pos = Vector(HeroPos) + 400 * (Vector(mousePos) - Vector(HeroPos)):normalized()
if Config.R and GotBuff(myHero, "SionR") > 0 then
MoveToXYZ(Pos.x, Pos.y, Pos.z)
end
end)
