Config = scriptConfig("Garen", "Garen:")
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R if Killable", SCRIPT_PARAM_ONOFF, true)
PrintChat("D3ftland Garen By Deftsu.")

OnLoop(function(myHero)
        if IWalkConfig.Combo then
		    local target = GetTarget(400, DAMAGE_PHYSICAL)
		        if ValidTarget(target, 400) then
				
				    if CanUseSpell(myHero, _E) == READY and IsInDistance(target, 300) and Config.E then
				    CastSpell(_E)
					end
					
			    
			     
				    local target = GetTarget(400, DAMAGE_MAGIC)
					if CanUseSpell(myHero, _R) == READY and IsInDistance(target, 400) and Config.R and CalcDamage(myHero, target, 0, 175*GetCastLevel(myHero,_R)+(GetMaxHP(target)-GetCurrentHP(target))/((8-GetCastLevel(myHero,_R))/2) > GetCurrentHP(target) then
					CastTargetSpell(target, _R)
					end
				end
		    end
		end
end)
