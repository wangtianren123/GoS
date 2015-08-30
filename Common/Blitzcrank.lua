Config = scriptConfig("Blitzcrank", "Blitzcrank:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, false)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, false)
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()

        if IWalkConfig.Combo then
	      local target = GetTarget(1000, DAMAGE_MAGIC)
	              	
		        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),70,true,true)
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	                end
                          
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 700) and GetDistance(myHero, target) > 200 and Config.W then
                        CastSpell(_W)
		        end
			
                        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 250) and Config.E then
                        CastSpell(_E)
		        end
		              
		        if CanUseSpell(myHero, _R) == READY and ValidTarget(target, GetCastRange(myHero,_R)) and Config.R then
                        CastSpell(_R)
	                end
	                      
	end	
	
	if IWalkConfig.Harass then
	     local target = GetTarget(1000, DAMAGE_MAGIC)
		
			        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),70,true,true)
                                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target,GetCastRange(myHero,_Q)) and HarassConfig.HarassQ then 
                                CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
				elseif CanUseSpell(myHero, _E) == READY and ValidTarget(target, 250) and HarassConfig.HarassE then
				CastSpell(_E)
				end
	end
end)

function Killsteal()
        for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),70,true,true)
  	    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero))) then 
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            elseif CanUseSpell(myHero, _R) == READY and ValidTarget(enemy,GetCastRange(myHero,_R)) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero))) then
            CastSpell(_R)
	    end
	end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
