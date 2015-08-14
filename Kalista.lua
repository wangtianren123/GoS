OnProcessSpell(function(unit, spell)
 for _, ally in pairs(GetAllyHeroes()) do
  if unit and unit == myHero and spell then
    if spell.name:lower():find("kalistapspellcast") then
      PrintChat("Nebel is Pledged to you")
    end
  end
 end
end)
