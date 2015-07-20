require('Common')
function AfterObjectLoopEvent(myHer0)
    myHero = myHer0
    myHeroPos = GetOrigin(myHero)
		DrawText("D3ftsu Fizz Loaded.",24,0,0,0xffff0000);
	
	local target = GetCurrentTarget()
	if KeyIsDown(0x20) then 
	    if ValidTarget(target, 1275) then
		    local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1875,250,1275,55,true,true)
            if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
            CastSkillShot(_R,RPred.PredPos.x,Rred.PredPos.y,RPred.PredPos.z)
            end
			if CanUseSpell(myHero, _W) == READY and GetDistance(GetOrigin(target), GetOrigin(myHero)) < 200*200 then
				CastTargetSpell(myHero, _W)
			end
			if CanUseSpell(myHero, _Q) == READY and GetDistance(GetOrigin(target), GetOrigin(myHero)) < 550*550 then
				CastTargetSpell(target, _Q)
			end
			if CanUseSpell(myHero, _E) == READY and GetDistance(GetOrigin(target), GetOrigin(myHero)) < 900*900 then
				CastTargetSpell(target, _E)
			end
	  	end
	end	
end
