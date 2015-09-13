AutoIgniteMenu = Menu("AutoIgnite", "Auto Ignite")
AutoIgniteMenu:Boolean("Enabled", "Enabled", true)

for i,enemy in pairs(GoS:GetEnemyHeroes()) do
      if Ignite and AutoIgniteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
      end
end
