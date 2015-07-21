require("Inspired")
require("IMenu")
require("IWalk")

local ARCANE_MASTERY = "ryzepassivestack"
local SUPERCHARGED = "ryzepassivecharged"

AddInfo("Ryze", "Ryze")
AddButton("Q", "Use Q", true)
AddButton("W", "Use W", true)
AddButton("E", "Use E", true)
AddButton("R", "Use R", true)

AddAfterObjectLoopEvent(function(myHero)
        IWalk()
        DrawMenu()
	AutoIgnite()

	if GetKeyValue("Combo") then
	local target = GetCurrentTarget()
	    if ValidTarget(target, 900) then
		local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,900,55,true,true)
		if GetButtonValue("Q") then
                 if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	         end
                end
			
		if GetButtonValue("R") then
                 if CanUseSpell(myHero, _R) == READY and (GotBuff(myHero, SUPERCHARGED) > 0 or GotBuff(myHero, ARCANE_MASTERY) > 3) then
                 CastTargetSpell(myHero, _R)
		 end
		end
			
		if GetButtonValue("W") then
                 if CanUseSpell(myHero, _W) == READY then
                 CastTargetSpell(target, _W)
		 end
                end
			
		if GetButtonValue("E") then
	         if CanUseSpell(myHero, _E) == READY then
                 CastTargetSpell(target, _E)
		 end
                end
	    end
	end	
end)
