local AutoIgniteMenu = Menu("AutoIgnite", "Auto Ignite")
AutoIgniteMenu:Boolean("Enabled", "Enabled", true)

local AutoSmiteMenu = Menu("AutoSmite", "Auto Smite")
AutoSmiteMenu:Boolean("Enabled", "Enabled", true)

ChillingSmite = (summonerNameOne:lower():find("s5_summonersmiteplayerganker") and SUMMONER_1 or (summonerNameTwo:lower():find("s5_summonersmiteplayerganker") and SUMMONER_2 or nil))
DuelSmite = (summonerNameOne:lower():find("s5_summonersmiteduel") and SUMMONER_1 or (summonerNameTwo:lower():find("s5_summonersmiteduel") and SUMMONER_2 or nil))

for i,enemy in pairs(GoS:GetEnemyHeroes()) do
      if ChillingSmite and AutoSmiteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, ChillingSmite) == READY and 20+8*GetLevel(myHero) > GetCurrentHP(enemy)+GetDmgShield(enemy) and GoS:ValidTarget(enemy, 500) then
                  CastTargetSpell(enemy, ChillingSmite)
                  end
      elseif Ignite and AutoIgniteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
      elseif DuelSmite and AutoSmiteMenu.Enabled:Value() then
                  if CanUseSpell(myHero, DuelSmite) == READY and 54+6*GetLevel(myHero) > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*3 and GoS:ValidTarget(enemy, 500) then
                  CastTargetSpell(enemy, DuelSmite)
                  end
      end
end
