if GetObjectName(myHero) ~= "Fizz" then return end
Config = scriptConfig("Fizz", "Fizz")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, false)
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, false)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()
		
		if IWalkConfig.Combo then
        
            local target = GetTarget(1275, DAMAGE_MAGIC)
		    if ValidTarget(target, 1275) then
			       local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1350,250,1275,120,false,true)
                    if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
                    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	                end
				
				    if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 300) and Config.W then
				    CastTargetSpell(myHero, _W)
				    end
				
				    if CanUseSpell(myHero, _Q) == READY and Config.Q then
				    CastTargetSpell(target, _Q)
			        end
				 
			        if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 800) and Config.E then
				    CastTargetSpell(target, _E)
			        end
				
            end
        end
		
		if IWalkConfig.Harass then
		local target = GetTarget(1275, DAMAGE_MAGIC)
		    if ValidTarget(target, 1275) then
		            if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 300) and HarassConfig.HarassW then
				    CastTargetSpell(myHero, _W)
				    end
				
				    if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ then
				    CastTargetSpell(target, _Q)
			        end
				 
			        if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 800) and HarassConfig.HarassE then
				    CastTargetSpell(target, _E)
			        end
				
            end
		end
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero, _Q) and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, GetBaseDamage(myHero)+GetBonusDmg(myHero), (15*GetCastLevel(myHero,_Q) - 5 + 0.3*GetBonusAP(myHero))) then
		CastTargetSpell(enemy, _Q)
		elseif CanUseSpell(myHero, _E) == READY and ValidTarget(enemy,800) and KSConfig.KSE and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (50*GetCastLevel(myHero,_W) + 20 + 0.75*GetBonusAP(myHero))) then
		CastTargetSpell(enemy, _E)
	    end
	end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
