if GetObjectName(myHero) ~= "Fizz" then return end

local FizzMenu = Menu("Fizz", "Fizz")
FizzMenu:SubMenu("Combo", "Combo")
FizzMenu.Combo:List("Mode", "Mode", 1, {"R>W>Q>E", "W>Q>R>E", "R>E>W>Q"})
FizzMenu.Combo:Boolean("Q", "Use Q", true)
FizzMenu.Combo:Boolean("W", "Use W", true)
FizzMenu.Combo:Boolean("E", "Use E", true)
FizzMenu.Combo:Boolean("R", "Use R", true)

FizzMenu.Harass:Boolean("Q", "Use Q", true)
FizzMenu.Harass:Boolean("W", "Use W", true)
FizzMenu.Harass:Boolean("E", "Use E", true)
FizzMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

FizzMenu:SubMenu("Killsteal", "Killsteal")
FizzMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
FizzMenu.Killsteal:Boolean("E", "Killsteal with E", false)

FizzMenu:SubMenu("Misc", "Misc")
FizzMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
FizzMenu.Misc:Boolean("Autolvl", "Auto level", true)
FizzMenu.Misc:List("Autolvltable", "Autolvl Priority", 1, {"W-Q-E", "Q-W-E", "Q-E-W"})

FizzMenu:SubMenu("JungleClear", "JungleClear")
FizzMenu.JungleClear:Boolean("Q", "Use Q", true)
FizzMenu.JungleClear:Boolean("W", "Use W", true)
FizzMenu.JungleClear:Boolean("E", "Use E", true)

FizzMenu:SubMenu("Drawings", "Drawings")
FizzMenu.Drawings:Boolean("Q", "Draw Q Range", true)
FizzMenu.Drawings:Boolean("E", "Draw E Range", true)
FizzMenu.Drawings:Boolean("R", "Draw R Range", true)


OnLoop(function(myHero)
		
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
