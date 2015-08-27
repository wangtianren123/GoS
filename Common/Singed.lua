PrintChat("Singed Q Exploit By Deftsu Loaded!")
Config = scriptConfig("Singed", "Singed")
Config.addParam("Q", "Q Exploit", SCRIPT_PARAM_KEYDOWN, string.byte("T"))

OnLoop(function(myHero)
local mousePos = GetMousePos()
if CanUseSpell(myHero, _Q) == READY and Config.Q then
MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
CastSpell(_Q)
end
end)
