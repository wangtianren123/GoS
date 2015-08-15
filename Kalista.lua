PrintChat("D3ftland Kalista By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item1", "Use BotRK", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item2", "Use Bilgewater", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item3", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Item4", "Use QSS", SCRIPT_PARAM_ONOFF, true)
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
    if spell.name:lower():find("kalistapspellcast") then
      PrintChat("Nebel is Pledged to you")
    end
  end
 end
end)
