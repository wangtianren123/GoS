require('Inspired')
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

        if GetKeyValue("Combo") then
          local target = GetCurrentTarget()
          if ValidTarget(target, 1000) then
				
	        if GetButtonValue("E") then
		 if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 300) then
		 CastTargetSpell(myHero, _E)
		 end
		end
			
	        if GetButtonValue("R") then
		 if CanUseSpell(myHero, _R) == READY and CalcDamage(myHero, unit, 0, GetRdmg()) > GetCurrentHP(Target) and IsInDistance(target, 650) then
                 CastTargetSpell(Target, _R)
		 end
                end  
          end	
        end
end

function GetRdmg()
local target = GetCurrentTarget()
local spelllevel = GetCastLevel(MyHero,_R);
local missingHealth = GetMaxHP(target)-GetCurrentHP(target);
local MR = GetMagicResist(target);
local MagicReduction =MR/(MR+100);
local dmg=( (8-spelllevel)*0.5*missingHealth + 175*spelllevel) * 1- MagicReduction
end
