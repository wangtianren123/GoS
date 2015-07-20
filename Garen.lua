require('Inspired')
require('IMenu')
require('IWalk')


AddButton("E", "Use E", true)
AddButton("R", "R if Killable", true)
AddKey("Combo", "Do Combo", string.byte(" "))
AddKey("LastHit", "Do LastHit", string.byte("X"))
AddKey("LaneClear", "Do LaneClear", string.byte("V"))

function AfterObjectLoopEvent(myHero)
    myHero = myHer0
    myHeroPos = GetOrigin(myHero)
		IWalk()
		DrawMenu()
	    AutoIgnite()
        if GetKeyValue("Combo") then return end
        local unit = GetTarget(1000)
		if ValidTarget(unit, 1000) then
				
	        if GetButtonValue("E") then
			 if CanUseSpell(myHero, _E) == READY and GetDistance(GetOrigin(target), GetOrigin(myHero)) < 300*300 then
				CastTargetSpell(myHero, _E)
			 end
			end
			
		    if GetButtonValue("R") then
			 if CalcDamage(myHero, unit, 0, 175*GetCastLevel(myHero,_R)+(GetMaxHP(unit)-GetCurrentHP(unit))/(4-GetCastLevel(myHero,_R)*0.5)) > GetCurrentHP(unit) then
             CastTargetSpell(unit, _R)
             end
			end
		end
end    
