PrintChat("D3ftland Viktor By Deftsu Loaded, Have A Good Game!")
Config = scriptConfig("Viktor", "Viktor")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassW", "Harass W (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()


OnLoop(function(myHero)
Drawings()
Killsteal()
        local target = GetTarget(1000, DAMAGE_MAGIC)
        local damage = CalcDamage(myHero, target, 0, (25 + 200*GetCastLevel(myHero,_R) + 1.25*GetBonusAP(myHero)
        local targetpos=GetOrigin(target)
		if ValidTarget(target, 1000) then
            
	           
				if IWalkConfig.Combo then	
					local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,0,1225,80,false,true)
					local myHeroPos = GetMyHeroPos()
                                        local StartPos = Vector(myHero) - 525 * (Vector(myHero) - Vector(target)):normalized()
					if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
					CastSkillShot3(_E,StartPos,EPred.PredPos)
					end
					
					 if CanUseSpell(myHero, _Q) == READY and Config.Q then
					 CastTargetSpell(target, _Q)
					 end
					 
					 local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,500,700,300,false,true)
					 if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and Config.W then
					 CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
					 end
					 
					 local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,250,700,450,false,true)
					 if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R and damage > GetCurrentHP(target) then
					 CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                                         elseif GetCastName(myHero, _R) == "viktorchaosstormguide" then
                                         CastSkillShot(_R, targetpos.x,targetpos.y, targetpos.z)
                                          end
				end
				
				 if IWalkConfig.Harass then	
					local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1200,0,1225,80,false,true)
					local myHeroPos = GetMyHeroPos()
                                        local StartPos = Vector(myHero) - 525 * (Vector(myHero) - Vector(target)):normalized()
					if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and HarassConfig.HarassE then
					CastSkillShot3(_E,StartPos,EPred.PredPos)
					end
					
					 if CanUseSpell(myHero, _Q) == READY and HarassConfig.HarassQ then
					 CastTargetSpell(target, _Q)
					 end
					 
					 local WPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,500,700,300,false,true)
					 if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and HarassConfig.HarassW then
					 CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
					 end
					 
					 if GetCastName(myHero, _R) == "viktorchaosstormguide" then
    CastSkillShot(_R, targetpos.x,targetpos.y, targetpos.z)
         end
				
		end
end)

--function Killsteal()
	--for i,enemy in pairs(GetEnemyHeroes()) do
	--end
--end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,1225,3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end
AddGapcloseEvent(_W, 0, false)
