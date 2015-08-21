PrintChat("Singed Q Exploit By Deftsu Loaded!")
Config = scriptConfig("Singed", "Singed")
Config.addParam("Q", "Q Exploit", SCRIPT_PARAM_ONOFF, false)

OnLoop(function(myHero)
local target = GetTarget(550, DAMAGE_MAGIC)
if CanUseSpell(myHero, _Q) == READY and Config.Q and IsInDistance(target, 550) then
CastSpell(_Q)
end
end)
