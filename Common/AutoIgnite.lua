Ignite = (GetCastName(myHero,SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
function AutoIgnite()
        for _,target in pairs(GetEnemyHeroes()) do
                if ValidTarget(target, 600) then
                        if Ignite and CanUseSpell(GetMyHero(), Ignite) and WillIgniteKill(target) then
                                CastTargetSpell(target, Ignite)
                        end
                end
        end
end
 
function WillIgniteKill(target)
  local currhp = GetCurrentHP(target)
  local hpregen = GetHPRegen(target)
  local igniteDamage = 50 * GetLevel(GetMyHero()) + 20
  if igniteDamage >= currhp + hpregen * 2.5 then
    return true
  else
    return false
  end
end
