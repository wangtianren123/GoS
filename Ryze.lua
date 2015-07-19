require('Common')
local ARCANE_MASTERY = "ryzepassivestack"
local SUPERCHARGED = "ryzepassivecharged"
function AfterObjectLoopEvent(myHer0)
    myHero = myHer0
    myHeroPos = GetOrigin(myHero)
		DrawText("D3ftland Ryze Loaded.",24,0,0,0xffff0000);
	
	local target = GetCurrentTarget()
	if KeyIsDown(0x20) then 
	    if ValidTarget(target, 900) then
			local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1875,250,900,55,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
			
            if CanUseSpell(myHero, _R) == READY and (GotBuff(myHero, SUPERCHARGED) > 0 or GotBuff(myHero, ARCANE_MASTERY) > 3) then
            CastTargetSpell(myHero, _R)
	    end
			
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(target, _W)
            end
		
	        if CanUseSpell(myHero, _E) == READY then
            CastTargetSpell(target, _E)
            end
	  	end
	end	
end
