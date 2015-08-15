PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item4", "Use QSS (broken)", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawEdmg", "Draw E Dmg %", SCRIPT_PARAM_ONOFF, true)

OnProcessSpell(function(unit, spell)
 for _, ally in pairs(GetAllyHeroes()) do
  if unit and unit == myHero and spell then
    if spell.name:lower():find("kalistapinvocation") then
      PrintChat("Nebel is Pledged to you "..GetObjectName(spell.target).."")
    end
  end
 end
end)

--function Killsteal()


function Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
