PrintChat("D3ftland Ryze By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Ryze", "Ryze")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal")
KSConfig.addParam("KSQ", "KillSteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSW", "KillSteal with W", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "KillSteal with E", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, false)
MiscConfig = scriptConfig("Misc", "Misc")
MiscConfig.addParam("Autolvl", "Autolvl", SCRIPT_PARAM_ONOFF, false)

myIAC = IAC()


OnLoop(function(myHero)
Drawings()
Killsteal()

if MiscConfig.Autolvl then
LevelUp()
end

	
	       local target = GetTarget(900, DAMAGE_MAGIC)
                    if IWalkConfig.Combo then	
					     
						if GotBuff(myHero, "ryzepassivecharged") > 0 and CanUseSpell(myHero, _R) ~= READY then
						  local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,true,true)
				          local Q2Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,false,true)
						  local targetPos = GetOrigin(target) 
						  
						  if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and Config.W then
                          CastTargetSpell(target, _W)
		                  end
						  
						  if CanUseSpell(myHero, _Q) == READY and Config.Q and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)  
	                      elseif CanUseSpell(myHero, _Q) == READY and Config.Q then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and Config.E then
                          CastTargetSpell(target, _E)
		                  end
						  
					
						
						elseif GotBuff(myHero, "ryzepassive") > 0 then
						
						  local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,true,true)
				          local Q2Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,false,true)
						  local targetPos = GetOrigin(target)
						  
			              if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and Config.W then
                          CastTargetSpell(target, _W)
						  end
						  
						  if CanUseSpell(myHero, _Q) == READY and Config.Q and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and Config.Q then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and Config.E then
                          CastTargetSpell(target, _E)
		                  end
						  
						  if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 700) and Config.R and GotBuff(myHero, "ryzepassivestack") == 4 then
                          CastSpell(_R)
		                  end
						  
						
						  
						end 
						
	                end
					
			local target = GetTarget(900, DAMAGE_MAGIC)		
					if IWalkConfig.Harass then
					      local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,true,true)
				          local Q2Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1400,250,GetCastRange(myHero,_Q),55,false,true)
						  local targetPos = GetOrigin(target)
						  
			              if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and HarassConfig.HarassW then
                          CastTargetSpell(target, _W)
						  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and HarassConfig.HarassE then
                          CastTargetSpell(target, _E)
		                  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and HarassConfig.HarassE then
                          CastTargetSpell(target, _E)
		                  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and HarassConfig.HarassW then
                          CastTargetSpell(target, _W)
						  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and HarassConfig.HarassE then
                          CastTargetSpell(target, _E)
		                  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and HarassConfig.HarassW then
                          CastTargetSpell(target, _W)
						  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and HarassConfig.HarassE then
                          CastTargetSpell(target, _E)
		                  end
						  
						  if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ and ValidTarget(target, GetCastRange(myHero, _Q)) and GotBuff(target, "RyzeW") == 1 then
                          CastSkillShot(_Q,targetPos.x,targetPos.y,targetPos.z)
				          elseif CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			              elseif CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "ryzepassivestack") > 3 or GotBuff(myHero, "ryzepassivecharged") > 0 and HarassConfig.HarassQ then
				          CastSkillShot(_Q,Q2Pred.PredPos.x,Q2Pred.PredPos.y,Q2Pred.PredPos.z)
						  end
						  
						  if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and HarassConfig.HarassW then
                          CastTargetSpell(target, _W)
						  end
					end				
end)

function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1400,250,GetCastRange(myHero,_Q),55,true,true)
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") == 100 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 25*GetCastLevel(myHero,_Q)+35+.55*GetBonusAP(myHero)+0.015*GetMaxMana(myHero)+0.005*GetCastLevel(myHero,_Q)*GetMaxMana(myHero) + ExtraDmg) then 
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		elseif CanUseSpell(myHero, _W) and ValidTarget(enemy,GetCastRange(myHero,_W)) and KSConfig.KSW and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 60+20*GetCastLevel(myHero,_W)+0.4*GetBonusAP(myHero)+0.025*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _W)
		elseif CanUseSpell(myHero, _E) and ValidTarget(enemy,GetCastRange(myHero,_E)) and KSConfig.KSE and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 20+16*GetCastLevel(myHero,_E)+0.2*GetBonusAP(myHero)+0.02*GetMaxMana(myHero) + ExtraDmg) then
		CastTargetSpell(enemy, _E)
		end
	end
end

function LevelUp()     

if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
end

function Drawings()
HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
end
