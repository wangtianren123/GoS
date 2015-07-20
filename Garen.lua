require('Inspired')
require('IMenu')
require('IWalk')


AddButton("E", "Use E", true)
AddButton("R", "R if Killable", true)
AddKey("Combo", "Do Combo", string.byte(" "))
AddKey("LastHit", "Do LastHit", string.byte("X"))
AddKey("LaneClear", "Do LaneClear", string.byte("V"))

function AfterObjectLoopEvent(myHero)
		IWalk()
		DrawMenu()
	        AutoIgnite()
            if GetKeyValue("Combo") then
            local Target = GetTarget(1000)
		  if ValidTarget(unit, 1000) then
				
	                if GetButtonValue("E") then
			 if CanUseSpell(myHero, _E) == READY and GetDistance(target, myHero) < 300 then
				CastTargetSpell(target, _E)
			 end
			end
			
		        if GetButtonValue("R") then
			 if CanUseSpell(myHero, _R) == READY and CalcDamage(myHero, Target, 0, GetRdmg) > GetCurrentHP(Target) then
                         CastTargetSpell(Target, _R)
			 end
		    end
          end  
        end	
end

function GetRdmg()
local spelllevel = GetCastLevel(MyHero,_R);
local missingHealth = GetMaxhealth(target)-GetCurrentHealth(target);
local MagicReduction = GetMagicRediction(target) / 100;
local dmg=( (8-spelllevel)*0.5*missingHealth + 175*spelllevel) * 1- MagicReduction
end
