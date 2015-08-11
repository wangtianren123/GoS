Config = scriptConfig("Sion", "Sion")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R (Exploit)", SCRIPT_PARAM_KEYDOWN, string.byte("R")

myIAC = IAC()

OnLoop(function(myHero)
local HeroPos = GetOrigin(myHero)
local mousePos = GetMousePos()
local Pos = Vector(HeroPos) + 400 * (Vector(mousePos) - Vector(HeroPos)):normalized()
if Config.R anf GotBuff(myHero, "SionR") > 0 then
MoveToXYZ(Pos.x, Pos.y, Pos.z)
end
end
end)
