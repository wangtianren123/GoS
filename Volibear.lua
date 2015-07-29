Config = scriptConfig("Volibear", "Volibear:")
Config.addParam("W", "Use W if killable", SCRIPT_PARAM_ONOFF, true)
PrintChat("VolibearAutoW by Deftsu. Enjoy :)")
OnLoop(function(myHero)
	
	
        if IWalkConfig.Combo then
		local target = GetTarget(400, DAMAGE_PHYSICAL)
		local Wdamage = CalcDamage(myHero, target, ((GetCastLevel(myHero,_W)-1)*45+80+(GetMaxHP(myHero)-(440+GetLevel(myHero)*86))*.15)*(1+(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target)), 0)
		        if ValidTarget(target, 400) then
				   if CanUseSpell(myHero, _W) == READY and Config.W and Wdamage > GetCurrentHP(target) then
				   CastTargetSpell(target, _W)
				   end
				   
				end
		end
end)
				   
