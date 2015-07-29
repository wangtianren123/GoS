Config = scriptConfig("Volibear", "Volibear:")
Config.addParam("W", "Use W if killable", SCRIPT_PARAM_ONOFF, true)
PrintChat("VolibearAutoW by Deftsu. Enjoy :)")
OnLoop(function(myHero)
local target = GetTarget(400, DAMAGE_PHYSICAL)
	if ValidTarget(target, 400) then
	if IWalkConfig.Combo then
local Wlvl = GetCastLevel(myHero,_W)
local mhp = GetMaxHP(myHero)
local lvl = GetLevel(myHero)
local tmhp = GetMaxHP(target)
local thp = GetCurrentHP(target)
local damage = CalcDamage(myHero, target, (45*(Wlvl-1)+80+(mhp-(440+lvl*86))*.15)*((tmhp-thp)/tmhp) ,0)
        
		
				   if CanUseSpell(myHero, _W) == READY and Config.W and damage > GetCurrentHP(target) then
				   CastTargetSpell(target, _W)
				   end
				   
				end
		end
end)
