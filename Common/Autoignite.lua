require('Deftlib')

if Ignite ~= nil then 
local AutoIgniteMenu = Menu("AutoIgnite", "Auto Ignite")
AutoIgniteMenu:Boolean("Enabled", "Enabled", true)
end

if Smite ~= nil then 
local AutoSmiteMenu = Menu("AutoSmite", "Auto Smite")
AutoSmiteMenu:Boolean("Enabled", "Enabled", true)
end

for i,enemy in pairs(GoS:GetEnemyHeroes()) do
      if SmiteBlue and AutoSmiteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, SmiteBlue) == READY and 20+8*GetLevel(myHero) > GetCurrentHP(enemy)+GetDmgShield(enemy) and GoS:ValidTarget(enemy, 500) then
                  CastTargetSpell(enemy, SmiteBlue)
                  end
      elseif Ignite and AutoIgniteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
      elseif SmiteRed and AutoSmiteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, SmiteRed) == READY and 54+6*GetLevel(myHero) > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*3 and GoS:ValidTarget(enemy, 500) then
                  CastTargetSpell(enemy, SmiteRed)
                  end
      end
end
