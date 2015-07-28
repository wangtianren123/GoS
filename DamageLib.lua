--[[
	Spell Damage Library 
		by eXtragoZ
		
		Is designed to calculate the damage of the skills to champions, although most of the calculations
		work for creeps
			
-------------------------------------------------------	
	Usage:

		local target = heroManager:getHero(2)
		local damage, TypeDmg = getDmg(R,target,myHero,3)	
-------------------------------------------------------
	Full function:
		getDmg(spellname,target,myHero,stagedmg,spellGetLevel(myHero))
		
	Returns:
		damage, TypeDmg
		
		TypeDmg:
			1	Normal damage
			2	Attack damage and on hit passives needs to be added to the damage
		
		Skill:			(in capitals!)
			Q
			W
			E
			R
			QM			-Q in melee form (Jayce, Nidalee and Elise only)
			WM			-W in melee form (Jayce, Nidalee and Elise only)
			EM			-E in melee form (Jayce, Nidalee and Elise only)
			"AD"			-Attack damage
			"IGNITE"		-Ignite
			"HXG"			-Hextech Gunblade
			"BWC"			-Bilgewater Cutlass
			"WITSEND"		-Wit's End
			"SHEEN"			-Sheen
			"TRINITY"		-Trinity Force 
			"LICHBANE"		-Lich Bane
			"LIANDRYS"		-Liandry's Torment
			"STATIKK"		-Statikk Shiv
			"ICEBORN"		-Iceborn Gauntlet
			"TIAMAT"		-Tiamat
			"HYDRA"			-Ravenous Hydra
			"RUINEDKING"	-Blade of the Ruined King
			"MURAMANA"		-Muramana
			"HURRICANE"		-Runaan's Hurricane
			"SUNFIRE"		-Sunfire Cape
			"NTOOTH"		-Nashor's Tooth
			"MOUNTAIN"		-Face of the Mountain
			
		Stagedmg:
			nil	Active or first instance of dmg
			1	Active or first instance of dmg
			2	Passive or second instance of dmg
			3	Max damage or third instance of dmg
			
		-Returns the damage they will do "myHero" to "target" with the "skill"
		-With some skills returns a percentage of increased damage
		-Many skills are shown per second, hit and other
		
]]--

function getDmg(spellname,target,myHero,stagedmg,spellGetLevel(myHero))
    local Q=GetCastName(myHero_Q)
	local W=GetCastName(myHero_W)
	local E=GetCastName(myHero_E)
	local R=GetCastName(myHero_R)
	local stagedmg1,stagedmg2,stagedmg3 = 1,0,0
	if stagedmg == 2 then stagedmg1,stagedmg2,stagedmg3 = 0,1,0
	elseif stagedmg == 3 then stagedmg1,stagedmg2,stagedmg3 = 0,0,1 end
	local TrueDmg = 0
	local TypeDmg = 1 --1 ability/normal--2 bonus to attack
	if ((spellname == Q or spellname == QM) and GetCastLevel(myHero,_Q) == 0) or ((spellname == W or spellname == WM) and GetCastLevel(myHero,_W) == 0) or ((spellname == E or spellname == EM) and GetCastLevel(myHero,_E) == 0) or (spellname == R and GetCastLevel(myHero,_R) == 0) then
		TrueDmg = 0
	elseif spellname == Q or spellname == W or spellname == E or spellname == R or spellname == "P" or spellname == QM or spellname == WM or spellname == EM then
		local DmgM = 0
		local DmgP = 0
		local DmgT = 0
		if GetObjectName(myHero) == "Aatrox" then
			if spellname == Q then DmgP = 45*GetCastLevel(myHero,_Q)+25+.6*GetBonusDmg(myHero)
			elseif spellname == W then DmgP = (35*GetCastLevel(myHero,_W)+25+GetBonusDmg(myHero))*(stagedmg1+stagedmg3) TypeDmg = 2
			elseif spellname == E then DmgM = 35*GetCastLevel(myHero,_E)+40+.6*GetBonusAP(myHero)+.6*GetBonusDmg(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Ahri" then
			if spellname == Q then DmgM = (25*GetCastLevel(myHero,_Q)+15+.35*GetBonusAP(myHero))*(stagedmg1+stagedmg3) DmgT = (25*GetCastLevel(myHero,_Q)+15+.35*GetBonusAP(myHero))*(stagedmg2+stagedmg3) -- stage1:Initial. stage2:way back. stage3:total.
			elseif spellname == W then DmgM = math.max(25*GetCastLevel(myHero,_W)+15+.4*GetBonusAP(myHero),(25*GetCastLevel(myHero,_W)+15+.4*GetBonusAP(myHero))*1.6*stagedmg3) -- xfox-fires ,  30% damage from each GetBaseDamage(myHero)ditional fox-fire beyond the first. stage3: Max damage
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+30+.35*GetBonusAP(myHero) --Enemies hit by ChGetArmor(myHero)m take 20% increased damage from Ahri for 6 seconds
			elseif spellname == R then DmgM = 40*GetCastLevel(myHero,_R)+30+.3*GetBonusAP(myHero) -- xbolt (3 bolts)
			end
		elseif GetObjectName(myHero) == "Akali" then
			if spellname == Q then DmgM = math.max((20*GetCastLevel(myHero,_Q)+15+.4*GetBonusAP(myHero))*stagedmg1,(25*GetCastLevel(myHero,_Q)+20+.5*GetBonusAP(myHero))*stagedmg2,(45*GetCastLevel(myHero,_Q)+35+.9*GetBonusAP(myHero))*stagedmg3) --stage1:Initial. stage2:Detonation. stage3:Max damage
			elseif spellname == E then DmgP = 25*GetCastLevel(myHero,_E)+5+.3*GetBonusAP(myHero)+.6*GetBaseDamage(myHero)
			elseif spellname == R then DmgM = 75*GetCastLevel(myHero,_R)+25+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Alistar" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+15+.5*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 55*GetCastLevel(myHero,_W)+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Amumu" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+30+.7*GetBonusAP(myHero)
			elseif spellname == W then DmgM = ((.5*GetCastLevel(myHero,_W)+.5+.01*GetBonusAP(myHero))*GetMaxHP(target)/100)+4*GetCastLevel(myHero,_W)+4 --xsec
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+50+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Anivia" then
			if spellname == Q then DmgM = math.max(30*GetCastLevel(myHero,_Q)+30+.5*GetBonusAP(myHero),(30*GetCastLevel(myHero,_Q)+30+.5*GetBonusAP(myHero))*2*stagedmg3) -- x2 if it detonates. stage3: Max damage
			elseif spellname == E then DmgM = math.max(30*GetCastLevel(myHero,_E)+25+.5*GetBonusAP(myHero),(30*GetCastLevel(myHero,_E)+25+.5*GetBonusAP(myHero))*2*stagedmg3) -- x2  If the target has been chilled. stage3: Max damage
			elseif spellname == R then DmgM = 40*GetCastLevel(myHero,_R)+40+.25*GetBonusAP(myHero) --xsec
			end
		elseif GetObjectName(myHero) == "Annie" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+45+.8*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 45*GetCastLevel(myHero,_W)+25+.85*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 10*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero) --x each attack suffered
			elseif spellname == R then DmgM = math.max((125*GetCastLevel(myHero,_R)+50+.8*GetBonusAP(myHero))*stagedmg1,(35+.2*GetBonusAP(myHero))*stagedmg2,(125*GetCastLevel(myHero,_R)+50+.8*GetBonusAP(myHero))*stagedmg3) DmgP = (25*GetCastLevel(myHero,_R)+55)*stagedmg2 --stage1:Summon Tibbers . stage2:Aura AoE xsec + 1 Tibbers Attack. stage3:Summon Tibbers
			end
		elseif GetObjectName(myHero) == "Ashe" then
			if spellname == Q then TypeDmg = 2
			elseif spellname == W then DmgP = 10*GetCastLevel(myHero,_W)+30+GetBaseDamage(myHero)
			elseif spellname == R then DmgM = 175*GetCastLevel(myHero,_R)+75+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Azir" then
			if spellname == Q then DmgM = 30*GetCastLevel(myHero,_Q)+45+.5*GetBonusAP(myHero) --beyond the first will deal only 25% damage
			elseif spellname == W then DmgM = math.max(5*GetLevel(myHero)+45,10*GetLevel(myHero)-10)+.6*GetBonusAP(myHero)--after the first deals 25% damage
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_Q)+30+.4*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 75*GetCastLevel(myHero,_R)+75+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Blitzcrank" then
			if spellname == Q then DmgM = 55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)
			elseif spellname == E then DmgP = GetBaseDamage(myHero) TypeDmg = 2
			elseif spellname == R then DmgM = math.max((125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero))*stagedmg1,(100*GetCastLevel(myHero,_R)+.2*GetBonusAP(myHero))*stagedmg2,(125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero))*stagedmg3) --stage1:the active. stage2:the passive. stage3:the active
			end
		elseif GetObjectName(myHero) == "Brand" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+40+.65*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max(45*GetCastLevel(myHero,_W)+30+.6*GetBonusAP(myHero),(45*GetCastLevel(myHero,_W)+30+.6*GetBonusAP(myHero))*1.25*stagedmg3) --125% for units that GetArmor(myHero)e ablaze. stage3: Max damage
			elseif spellname == E then DmgM = 35*GetCastLevel(myHero,_E)+35+.55*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(100*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero),(100*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero))*3*stagedmg3) --xbounce (can hit the same enemy up to three times). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Braum" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+15+.025*GetMaxHP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Caitlyn" then
			if spellname == "P" then DmgP = .5*GetBaseDamage(myHero) TypeDmg = 2 --xheGetBaseDamage(myHero)shot (bonus)
			elseif spellname == Q then DmgP = 40*GetCastLevel(myHero,_Q)-20+1.3*GetBaseDamage(myHero) --deal 10% less damage for each subsequent target hit, down to a minimum of 50%
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+30+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+30+.8*GetBonusAP(myHero)
			elseif spellname == R then DmgP = 225*GetCastLevel(myHero,_R)+25+2*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Cassiopeia" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+35+.45*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 5*GetCastLevel(myHero,_W)+5+.1*GetBonusAP(myHero) --xsec
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+30+.55*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Chogath" then
			if spellname == Q then DmgM = 56.25*GetCastLevel(myHero,_Q)+23.75+GetBonusAP(myHero)
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+25+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 15*GetCastLevel(myHero,_E)+5+.3*GetBonusAP(myHero) TypeDmg = 2 --xhit (bonus)
			elseif spellname == R then DmgT = 175*GetCastLevel(myHero,_R)+125+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Corki" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+30+.5*GetBonusDmg(myHero)+.5*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 30*GetCastLevel(myHero,_W)+30+.4*GetBonusAP(myHero) --xsec (2.5 sec)
			elseif spellname == E then DmgP = 12*GetCastLevel(myHero,_E)+8+.4*GetBonusDmg(myHero) --xsec (4 sec)
			elseif spellname == R then DmgM = math.max(70*GetCastLevel(myHero,_R)+50+.3*GetBonusAP(myHero)+(.1*GetCastLevel(myHero,_R)+.1)*GetBaseDamage(myHero),(70*GetCastLevel(myHero,_R)+50+.3*GetBonusAP(myHero)+(.1*GetCastLevel(myHero,_R)+.1)*GetBaseDamage(myHero))*1.5*stagedmg3) --150% the big one. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Darius" then
			if spellname == Q then DmgP = math.max(35*GetCastLevel(myHero,_Q)+35+.7*GetBonusDmg(myHero),(35*GetCastLevel(myHero,_Q)+35+.7*GetBonusDmg(myHero))*1.5*stagedmg3) --150% Champions in the outer half. stage3: Max damage
			elseif spellname == W then DmgP = .2*GetCastLevel(myHero,_W)*GetBaseDamage(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == R then DmgT = math.max(90*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero),(90*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero))*2*stagedmg3) --xstack of Hemorrhage deals an GetBaseDamage(myHero)ditional 20% damage. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Diana" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+25+.7*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max(12*GetCastLevel(myHero,_W)+10+.2*GetBonusAP(myHero),(12*GetCastLevel(myHero,_W)+10+.2*GetBonusAP(myHero))*3*stagedmg3) --xOrb (3 orbs). stage3: Max damage
			elseif spellname == R then DmgM = 60*GetCastLevel(myHero,_R)+40+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "DrMundo" then
			if spellname == Q then DmgM = math.max((2.5*GetCastLevel(myHero,_Q)+12.5)*GetCurrentHP(target)/100,50*GetCastLevel(myHero,_Q)+30)
			elseif spellname == W then DmgM = 15*GetCastLevel(myHero,_W)+20+.2*GetBonusAP(myHero) --xsec
			end
		elseif GetObjectName(myHero) == "Draven" then
			if spellname == Q then DmgP = (.1*GetCastLevel(myHero,_Q)+.35)*GetBaseDamage(myHero) TypeDmg = 2 --xhit (bonus)
			elseif spellname == E then DmgP = 35*GetCastLevel(myHero,_E)+35+.5*GetBonusDmg(myHero)
			elseif spellname == R then DmgP = 100*GetCastLevel(myHero,_R)+75+1.1*GetBonusDmg(myHero) --xhit (max 2 hits), deals 8% less damage for each unit hit, down to a minimum of 40%
			end
		elseif GetObjectName(myHero) == "Elise" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+5+(8+.03*GetBonusAP(myHero))*GetCurrentHP(target)/100
			elseif spellname == QM then DmgM = 40*GetCastLevel(myHero,_Q)+20+(8+.03*GetBonusAP(myHero))*(GetMaxHP(target)-GetCurrentHP(target))/100
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+25+.8*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 10*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) TypeDmg = 2 --xhit (bonus)
			end
		elseif GetObjectName(myHero) == "Evelynn" then
			if spellname == Q then DmgM = 15*GetCastLevel(myHero,_Q)+15+(.05*GetCastLevel(myHero,_Q)+.3)*GetBonusAP(myHero)+(.05*GetCastLevel(myHero,_Q)+.45)*GetBonusDmg(myHero)
			elseif spellname == E then DmgP = 40*GetCastLevel(myHero,_E)+30+GetBonusAP(myHero)+GetBonusDmg(myHero) --total
			elseif spellname == R then DmgM = (5*GetCastLevel(myHero,_R)+10+.01*GetBonusAP(myHero))*GetCurrentHP(target)/100
			end
		elseif GetObjectName(myHero) == "Ezreal" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)+15+.4*GetBonusAP(myHero)+.1*GetBaseDamage(myHero) TypeDmg = 2 -- (bonus)
			elseif spellname == W then DmgM = 45*GetCastLevel(myHero,_W)+25+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+25+.75*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 150*GetCastLevel(myHero,_R)+200+.9*GetBonusAP(myHero)+GetBonusDmg(myHero) --deal 10% less damage for each subsequent target hit, down to a minimum of 30%
			end
		elseif GetObjectName(myHero) == "FiddleSticks" then
			if spellname == W then DmgM = math.max(30*GetCastLevel(myHero,_W)+30+.45*GetBonusAP(myHero),(30*GetCastLevel(myHero,_W)+30+.45*GetBonusAP(myHero))*5*stagedmg3) --xsec (5 sec). stage3: Max damage
			elseif spellname == E then DmgM = math.max(20*GetCastLevel(myHero,_E)+45+.45*GetBonusAP(myHero),(20*GetCastLevel(myHero,_E)+45+.45*GetBonusAP(myHero))*3*stagedmg3) --xbounce. stage3: Max damage
			elseif spellname == R then DmgM = math.max(100*GetCastLevel(myHero,_R)+25+.45*GetBonusAP(myHero),(100*GetCastLevel(myHero,_R)+25+.45*GetBonusAP(myHero))*5*stagedmg3) --xsec (5 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Fiora" then
			if spellname == Q then DmgP = 25*GetCastLevel(myHero,_Q)+15+.6*GetBonusDmg(myHero) --xstrike
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+10+GetBonusAP(myHero)
			elseif spellname == R then DmgP = math.max(130*GetCastLevel(myHero,_R)-5+.9*GetBonusDmg(myHero),(170*GetCastLevel(myHero,_R)-10+.9*GetBonusDmg(myHero))*2.6*stagedmg3) --xstrike , without counting on-hit effects, Successive hits against the same target deal 40% damage. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Fizz" then
			if spellname == Q then DmgM = 30*GetCastLevel(myHero,_Q)-20+.6*GetBonusAP(myHero) TypeDmg = 2 -- (bonus)
			elseif spellname == W then DmgM = math.max(((15*GetCastLevel(myHero,_W)+25+.6*GetBonusAP(myHero))+(GetCastLevel(myHero,_W)+3)*(GetMaxHP(target)-GetCurrentHP(target))/100)*(stagedmg1+stagedmg3),((10*GetCastLevel(myHero,_W)+20+.35*GetBonusAP(myHero))+(GetCastLevel(myHero,_W)+3)*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg2) TypeDmg = 2 --stage1:when its active. stage2:Passive. stage3:when its active
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+20+.75*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+75+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Galio" then
			if spellname == Q then DmgM = 55*GetCastLevel(myHero,_Q)+25+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+15+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(110*GetCastLevel(myHero,_R)+110+.6*GetBonusAP(myHero),(110*GetCastLevel(myHero,_R)+110+.6*GetBonusAP(myHero))*1.4*stagedmg3) --GetBaseDamage(myHero)ditional 5% damage for each attack suffered while channeling and cGetBonusAP(myHero)ping at 40%. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Gangplank" then
			if spellname == Q then DmgP = 25*GetCastLevel(myHero,_Q)-5 TypeDmg = 2 --without counting on-hit effects
			elseif spellname == R then DmgM = 45*GetCastLevel(myHero,_R)+30+.2*GetBonusAP(myHero) --xSec (7 sec)
			end
		elseif GetObjectName(myHero) == "Garen" then
			if spellname == Q then DmgP = 25*GetCastLevel(myHero,_Q)+5+.4*GetBaseDamage(myHero) TypeDmg = 2 -- (bonus)
			elseif spellname == E then DmgP = math.max(25*GetCastLevel(myHero,_E)-5+(.1*GetCastLevel(myHero,_E)+.6)*GetBaseDamage(myHero),(25*GetCastLevel(myHero,_E)-5+(.1*GetCastLevel(myHero,_E)+.6)*GetBaseDamage(myHero))*2.5*stagedmg3) --xsec (2.5 sec). stage3: Max damage
			elseif spellname == R then DmgM = 175*GetCastLevel(myHero,_R)+(GetMaxHP(target)-GetCurrentHP(target))/((8-GetCastLevel(myHero,_R))/2)
			end
		elseif GetObjectName(myHero) == "Gnar" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)-25+1.15*GetBaseDamage(myHero) -- 50% damage beyond the first
			elseif spellname == QM then DmgP = 40*GetCastLevel(myHero,_Q)-35+1.2*GetBaseDamage(myHero)
			elseif spellname == W then DmgM = 10*GetCastLevel(myHero,_W)+GetBonusAP(myHero)+(2*GetCastLevel(myHero,_W)+4)*GetMaxHP(target)/100
			elseif spellname == WM then DmgP = 20*GetCastLevel(myHero,_W)+5+GetBaseDamage(myHero)
			elseif spellname == E then DmgP = 40*GetCastLevel(myHero,_E)-20+6*GetMaxHP(myHero)/100
			elseif spellname == EM then DmgP = 40*GetCastLevel(myHero,_E)-20+6*GetMaxHP(myHero)/100
			elseif spellname == R then DmgP = math.max(100*GetCastLevel(myHero,_R)+100+.2*GetBonusDmg(myHero)+.5*GetBonusAP(myHero),(100*GetCastLevel(myHero,_R)+100+.2*GetBonusDmg(myHero)+.5*GetBonusAP(myHero))*1.5*stagedmg3) --x1.5 If collide with terrain. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Gragas" then
			if spellname == Q then DmgM = math.max(40*GetCastLevel(myHero,_Q)+40+.6*GetBonusAP(myHero),(40*GetCastLevel(myHero,_Q)+40+.6*GetBonusAP(myHero))*1.5*stagedmg3) --Damage increase by up to 50% over 2 seconds. stage3: Max damage
			elseif spellname == W then DmgM = 30*GetCastLevel(myHero,_W)-10+.3*GetBonusAP(myHero)+(.01*GetCastLevel(myHero,_W)+.07)*GetMaxHP(target) TypeDmg = 2 -- (bonus)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+30+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+100+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Graves" then
			if spellname == Q then DmgP = math.max(35*GetCastLevel(myHero,_Q)+25+.8*GetBonusDmg(myHero),(35*GetCastLevel(myHero,_Q)+25+.8*GetBonusDmg(myHero))*1.8*stagedmg3) --xbullet , 40% damage xeach bullet beyond the first. stage3: Max damage
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+10+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgP = math.max((150*GetCastLevel(myHero,_R)+100+1.5*GetBonusDmg(myHero))*(stagedmg1+stagedmg3),(120*GetCastLevel(myHero,_R)+80+1.2*GetBonusDmg(myHero))*stagedmg2) --stage1-3:Initial. stage2:Explosion.
			end
		elseif GetObjectName(myHero) == "Hecarim" then
			if spellname == Q then DmgP = 35*GetCastLevel(myHero,_Q)+25+.6*GetBonusDmg(myHero)
			elseif spellname == W then DmgM = math.max(11.25*GetCastLevel(myHero,_W)+8.75+.2*GetBonusAP(myHero),(11.25*GetCastLevel(myHero,_W)+8.75+.2*GetBonusAP(myHero))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			elseif spellname == E then DmgP = math.max(35*GetCastLevel(myHero,_E)+5+.5*GetBonusDmg(myHero),(35*GetCastLevel(myHero,_E)+5+.5*GetBonusDmg(myHero))*2*stagedmg3) --Minimum , 200% Maximum (bonus). stage3: Max damage
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Heimerdinger" then
			if spellname == Q then DmgM = math.max((5.5*GetCastLevel(myHero,_Q)+6.5+.15*GetBonusAP(myHero))*stagedmg1,(math.max(20*GetCastLevel(myHero,_Q)+20,25*GetCastLevel(myHero,_Q)+5)+.55*GetBonusAP(myHero))*stagedmg2,(60*GetCastLevel(myHero,_R)+120+.7*GetBonusAP(myHero))*stagedmg3) --stage1:x Turrets attack. stage2:Beam. stage3:UPGRGetBaseDamage(myHero)E Beam
			elseif spellname == W then DmgM = 30*GetCastLevel(myHero,_W)+30+.45*GetBonusAP(myHero) --x Rocket, 20% magic damage for each rocket beyond the first
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+20+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max((20*GetCastLevel(myHero,_R)+50+.3*GetBonusAP(myHero))*stagedmg1,(45*GetCastLevel(myHero,_R)+90+.45*GetBonusAP(myHero))*stagedmg2,(50*GetCastLevel(myHero,_R)+100+.6*GetBonusAP(myHero))*stagedmg3) --stage1:x Turrets attack. stage2:x Rocket, 20% magic damage for each rocket beyond the first. stage3:x Bounce
			end
		elseif GetObjectName(myHero) == "Irelia" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)-10 TypeDmg = 2 -- (bonus)
			elseif spellname == W then DmgT = 15*GetCastLevel(myHero,_W) TypeDmg = 2 --xhit (bonus)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+30+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgP = 40*GetCastLevel(myHero,_R)+40+.5*GetBonusAP(myHero)+.6*GetBonusDmg(myHero) --xblGetBaseDamage(myHero)e
			end
		elseif GetObjectName(myHero) == "Janna" then
			if spellname == Q then DmgM = math.max((25*GetCastLevel(myHero,_Q)+35+.35*GetBonusAP(myHero))*stagedmg1,(5*GetCastLevel(myHero,_Q)+10+.1*GetBonusAP(myHero))*stagedmg2,(25*GetCastLevel(myHero,_Q)+35+.35*GetBonusAP(myHero)+(5*GetCastLevel(myHero,_Q)+10+.1*GetBonusAP(myHero))*3)*stagedmg3) --stage1:Initial. stage2:GetBaseDamage(myHero)ditional Damage xsec (3 sec). stage3:Max damage
			elseif spellname == W then DmgM = 55*GetCastLevel(myHero,_W)+5+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "JarvanIV" then
			if spellname == Q then DmgP = 45*GetCastLevel(myHero,_Q)+25+1.2*GetBonusDmg(myHero)
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+15+.8*GetBonusAP(myHero)
			elseif spellname == R then DmgP = 125*GetCastLevel(myHero,_R)+75+1.5*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Jax" then
			if spellname == Q then DmgP = 40*GetCastLevel(myHero,_Q)+30+.6*GetBonusAP(myHero)+GetBonusDmg(myHero)
			elseif spellname == W then DmgM = 35*GetCastLevel(myHero,_W)+5+.6*GetBonusAP(myHero) TypeDmg = 2
			elseif spellname == E then DmgP = math.max(25*GetCastLevel(myHero,_E)+25+.5*GetBonusDmg(myHero),(25*GetCastLevel(myHero,_E)+25+.5*GetBonusDmg(myHero))*2*stagedmg3) --deals 20% GetBaseDamage(myHero)ditional damage for each attack dodged to a maximum of 100%. stage3: Max damage
			elseif spellname == R then DmgM = 60*GetCastLevel(myHero,_R)+40+.7*GetBonusAP(myHero) TypeDmg = 2 --every third basic attack (bonus)
			end
		elseif GetObjectName(myHero) == "Jayce" then
			if spellname == Q then DmgP = math.max(55*GetCastLevel(myHero,_Q)+5+1.2*GetBonusDmg(myHero),(55*GetCastLevel(myHero,_Q)+5+1.2*GetBonusDmg(myHero))*1.4*stagedmg3) --If its fired through an Acceleration Gate damage will increase by 40%. stage3: Max damage
			elseif spellname == QM then DmgP = 45*GetCastLevel(myHero,_Q)-25+GetBonusDmg(myHero)
			elseif spellname == W then DmgT = 15*GetCastLevel(myHero,_W)+55 --% damage
			elseif spellname == WM then DmgM = math.max(17.5*GetCastLevel(myHero,_W)+7.5+.25*GetBonusAP(myHero),(17.5*GetCastLevel(myHero,_W)+7.5+.25*GetBonusAP(myHero))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			elseif spellname == EM then DmgM = GetBonusDmg(myHero)+((3*GetCastLevel(myHero,_E)+5)*GetMaxHP(target)/100)
			elseif spellname == R then DmgM = 40*GetCastLevel(myHero,_R)-20 TypeDmg = 2
			end
		elseif GetObjectName(myHero) == "Jinx" then
			if spellname == Q then DmgP = .1*GetBaseDamage(myHero) TypeDmg = 2
			elseif spellname == W then DmgP = 50*GetCastLevel(myHero,_W)-40+1.4*GetBaseDamage(myHero)
			elseif spellname == E then DmgM = 55*GetCastLevel(myHero,_E)+25+GetBonusAP(myHero) -- per Chomper
			elseif spellname == R then DmgP = math.max(((50*GetCastLevel(myHero,_R)+75+.5*GetBonusDmg(myHero))*2+(0.05*GetCastLevel(myHero,_R)+0.2)*(GetMaxHP(target)-GetCurrentHP(target)))*stagedmg1,(50*GetCastLevel(myHero,_R)+75+.5*GetBonusDmg(myHero))*stagedmg2,(0.05*GetCastLevel(myHero,_R)+0.2)*(GetMaxHP(target)-GetCurrentHP(target))*stagedmg3) --stage1:Maximum (after 1500 units)+GetBaseDamage(myHero)ditional Damage. stage2:Minimum Base (Maximum = x2). stage3: GetBaseDamage(myHero)ditional Damage
			end
		elseif GetObjectName(myHero) == "Kalista" then
			if spellname == Q then DmgP = 60*GetCastLevel(myHero,_Q)-50+GetBaseDamage(myHero)
			elseif spellname == W then DmgM = (2*GetCastLevel(myHero,_W)+10)*GetCurrentHP(target)/100
			elseif spellname == E then DmgP = math.max((10*GetCastLevel(myHero,_E)+10+.6*GetBaseDamage(myHero))*(stagedmg1+stagedmg3),((10*GetCastLevel(myHero,_E)+10+.6*GetBaseDamage(myHero))*(5*GetCastLevel(myHero,_E)+20)/100)*stagedmg2) --stage1,3:Base. stage2:xSpeGetArmor(myHero).
			end
		elseif GetObjectName(myHero) == "Karma" then
			if spellname == Q then DmgM = math.max((45*GetCastLevel(myHero,_Q)+35+.6*GetBonusAP(myHero))*stagedmg1,(50*GetCastLevel(myHero,_R)-25+.3*GetBonusAP(myHero))*stagedmg2,(100*GetCastLevel(myHero,_R)-50+.6*GetBonusAP(myHero))*stagedmg3) --stage1:Initial. stage2:Bonus (R). stage3: Detonation (R)
			elseif spellname == W then DmgM = math.max((50*GetCastLevel(myHero,_W)+10+.6*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(75*GetCastLevel(myHero,_R)+.6*GetBonusAP(myHero))*stagedmg2) --stage1:Initial. stage2:Bonus (R).
			elseif spellname == E then DmgM = 80*GetCastLevel(myHero,_R)-20+.6*GetBonusAP(myHero) --(R)
			end
		elseif GetObjectName(myHero) == "Karthus" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+40+.6*GetBonusAP(myHero) --50% damage if it hits multiple units
			elseif spellname == E then DmgM = 20*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero) --xsec
			elseif spellname == R then DmgM = 150*GetCastLevel(myHero,_R)+100+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Kassadin" then
			if spellname == Q then DmgM = 25*GetCastLevel(myHero,_Q)+55+.7*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max((25*GetCastLevel(myHero,_W)+15+.6*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(20+.1*GetBonusAP(myHero))*stagedmg2) TypeDmg = 2 -- stage1-3:Active. stage2: Pasive.
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+55+.7*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max((20*GetCastLevel(myHero,_R)+60+.02*GetMaxMana(myHero))*(stagedmg1+stagedmg3),(10*GetCastLevel(myHero,_R)+30+.01*GetMaxMana(myHero))*stagedmg2) --stage1-3:Initial. stage2:GetBaseDamage(myHero)ditional xstack (4 stack).
			end
		elseif GetObjectName(myHero) == "Katarina" then
			if spellname == Q then DmgM = math.max((25*GetCastLevel(myHero,_Q)+35+.45*GetBonusAP(myHero))*stagedmg1,(15*GetCastLevel(myHero,_Q)+.15*GetBonusAP(myHero))*stagedmg2,(40*GetCastLevel(myHero,_Q)+35+.6*GetBonusAP(myHero))*stagedmg3) --stage1:Dagger, Each subsequent hit deals 10% less damage. stage2:On-hit. stage3: Max damage
			elseif spellname == W then DmgM = 35*GetCastLevel(myHero,_W)+5+.25*GetBonusAP(myHero)+.6*GetBonusDmg(myHero)
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+35+.4*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(20*GetCastLevel(myHero,_R)+15+.25*GetBonusAP(myHero)+.375*GetBonusDmg(myHero),(20*GetCastLevel(myHero,_R)+15+.25*GetBonusAP(myHero)+.375*GetBonusDmg(myHero))*10*stagedmg3) --xdagger (champion can be hit by a maximum of 10 daggers (2 sec)). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Kayle" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+10+.6*GetBonusAP(myHero)+GetBonusDmg(myHero)
			elseif spellname == E then DmgM = 10*GetCastLevel(myHero,_E)+10+.25*GetBonusAP(myHero) TypeDmg = 2 --xhit (bonus)
			end
		elseif GetObjectName(myHero) == "Kennen" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+35+.75*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max((30*GetCastLevel(myHero,_W)+35+.55*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(.1*GetCastLevel(myHero,_W)+.3)*GetBaseDamage(myHero)*stagedmg2) TypeDmg = 1+stagedmg2 --stage1:Active. stage2:On-hit. stage3: stage1
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+45+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(65*GetCastLevel(myHero,_R)+15+.4*GetBonusAP(myHero),(65*GetCastLevel(myHero,_R)+15+.4*GetBonusAP(myHero))*3*stagedmg3) --xbolt (max 3 bolts). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Khazix" then
			if spellname == Q then DmgP = math.max((25*GetCastLevel(myHero,_Q)+45+1.2*GetBonusDmg(myHero))*stagedmg1,(25*GetCastLevel(myHero,_Q)+45+1.2*GetBonusDmg(myHero))*1.3*stagedmg2,((25*GetCastLevel(myHero,_Q)+45+1.2*GetBonusDmg(myHero))*1.3+10*GetLevel(myHero)+1.04*GetBonusDmg(myHero))*stagedmg3) --stage1:Normal. stage2:to Isolated. stage3:Evolved to Isolated.
			elseif spellname == W then DmgP = 30*GetCastLevel(myHero,_W)+50+GetBonusDmg(myHero)
			elseif spellname == E then DmgP = 35*GetCastLevel(myHero,_E)+30+.2*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "KogMaw" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+30+.5*GetBonusAP(myHero)
			elseif spellname == W then DmgM = (GetCastLevel(myHero,_W)+1+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 TypeDmg = 2 --xhit (bonus)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+10+.7*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 80*GetCastLevel(myHero,_R)+80+.3*GetBonusAP(myHero)+.5*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Leblanc" then
			if spellname == Q then DmgM = math.max(25*GetCastLevel(myHero,_Q)+30+.4*GetBonusAP(myHero),(25*GetCastLevel(myHero,_Q)+30+.4*GetBonusAP(myHero))*2*stagedmg3) --Initial or mGetArmor(myHero)k. stage3: Max damage
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+45+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgM = math.max(25*GetCastLevel(myHero,_Q)+15+.5*GetBonusAP(myHero),(25*GetCastLevel(myHero,_Q)+15+.5*GetBonusAP(myHero))*2*stagedmg3) --Initial or Delayed. stage3: Max damage
			elseif spellname == R then DmgM = math.max((100*GetCastLevel(myHero,_R)+.65*GetBonusAP(myHero))*stagedmg1,(150*GetCastLevel(myHero,_R)+.975*GetBonusAP(myHero))*stagedmg2,(100*GetCastLevel(myHero,_R)+.65*GetBonusAP(myHero))*stagedmg3) --stage1:Q Initial or mGetArmor(myHero)k. stage2:W. stage3:E Initial or Delayed
			end
		elseif GetObjectName(myHero) == "LeeSin" then
			if spellname == Q then DmgP = math.max((30*GetCastLevel(myHero,_Q)+20+.9*GetBonusDmg(myHero))*stagedmg1,(30*GetCastLevel(myHero,_Q)+20+.9*GetBonusDmg(myHero)+8*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg2,(60*GetCastLevel(myHero,_Q)+40+1.8*GetBonusDmg(myHero)+8*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg3) --stage1:Sonic Wave. stage2:Resonating Strike. stage3: Max damage
			elseif spellname == E then DmgM = 35*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero)
			elseif spellname == R then DmgP = 200*GetCastLevel(myHero,_R)+2*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Leona" then
			if spellname == Q then DmgM = 30*GetCastLevel(myHero,_Q)+10+.3*GetBonusAP(myHero) TypeDmg = 2 -- (bonus)
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+10+.4*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+20+.4*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lissandra" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+40+.65*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+30+.4*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+25+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lucian" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)+50+(15*GetCastLevel(myHero,_Q)+45)*GetBonusDmg(myHero)/100
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+20+.9*GetBonusAP(myHero)
			elseif spellname == R then DmgP = 10*GetCastLevel(myHero,_R)+30+.1*GetBonusAP(myHero)+.3*GetBonusDmg(myHero) --per shot
			end
		elseif GetObjectName(myHero) == "Lulu" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+35+.5*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+50+.4*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lux" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+10+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+15+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+200+.75*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Malphite" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+20+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+20+.2*GetBonusAP(myHero)+.3*GetArmor(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Malzahar" then
			if spellname == Q then DmgM = 55*GetCastLevel(myHero,_Q)+25+.8*GetBonusAP(myHero)
			elseif spellname == W then DmgM = (GetCastLevel(myHero,_W)+3+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 --xsec (5 sec)
			elseif spellname == E then DmgM = 60*GetCastLevel(myHero,_E)+20+.8*GetBonusAP(myHero) --over 4 sec
			elseif spellname == R then DmgM = 150*GetCastLevel(myHero,_R)+100+1.3*GetBonusAP(myHero) --over 2.5 sec
			end
		elseif GetObjectName(myHero) == "Maokai" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+25+.4*GetBonusAP(myHero)
			elseif spellname == W then DmgM = (1*GetCastLevel(myHero,_W)+8+.03*GetBonusAP(myHero))*GetMaxHP(target)/100
			elseif spellname == E then DmgM = math.max((20*GetCastLevel(myHero,_E)+20+.4*GetBonusAP(myHero))*stagedmg1,(40*GetCastLevel(myHero,_E)+40+.6*GetBonusAP(myHero))*stagedmg2,(60*GetCastLevel(myHero,_E)+60+GetBonusAP(myHero))*stagedmg3) --stage1:Impact. stage2:Explosion. stage3: Max damage
			elseif spellname == R then DmgM = 50*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero)+(50*GetCastLevel(myHero,_R)+150)*stagedmg3 -- +2 per point of damage absorbed (max 100/150/200). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "MasterYi" then
			if spellname == Q then DmgP = math.max((35*GetCastLevel(myHero,_Q)-10+GetBaseDamage(myHero))*stagedmg1,(.6*GetBaseDamage(myHero))*stagedmg2,(35*GetCastLevel(myHero,_Q)-10+1.6*GetBaseDamage(myHero))*stagedmg3) --stage1:normal. stage2:critically strike (bonus). stage3: critically strike
			elseif spellname == E then DmgT = 5*GetCastLevel(myHero,_E)+5+((5/2)*GetCastLevel(myHero,_E)+15/2)*GetBaseDamage(myHero)/100
			end
		elseif GetObjectName(myHero) == "MissFortune" then
			if spellname == Q then DmgP = math.max((15*GetCastLevel(myHero,_Q)+5+.85*GetBaseDamage(myHero)+.35*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(30*GetCastLevel(myHero,_Q)+10+GetBaseDamage(myHero)+.5*GetBonusAP(myHero))*stagedmg2) --stage1-stage3:1st target. stage2:2nd target.
			elseif spellname == W then DmgM = .06*GetBaseDamage(myHero) --xstack (max 5+GetCastLevel(myHero,_R) stacks) (bonus)
			elseif spellname == E then DmgM = 55*GetCastLevel(myHero,_E)+35+.8*GetBonusAP(myHero) --over 3 seconds
			elseif spellname == R then DmgP = math.max(25*GetCastLevel(myHero,_R)+25,50*GetCastLevel(myHero,_R)-25)+.2*GetBonusAP(myHero) --xwave (8 waves) GetBonusAP(myHero)plies a stack of Impure Shots
			end
		elseif GetObjectName(myHero) == "Mordekaiser" then
			if spellname == Q then DmgM = math.max(30*GetCastLevel(myHero,_Q)+50+.4*GetBonusAP(myHero)+GetBonusDmg(myHero),(30*GetCastLevel(myHero,_Q)+50+.4*GetBonusAP(myHero)+GetBonusDmg(myHero))*1.65*stagedmg3) --If the target is alone, the ability deals 65% more damage. stage3: Max damage
			elseif spellname == W then DmgM = math.max(14*GetCastLevel(myHero,_W)+10+.2*GetBonusAP(myHero),(14*GetCastLevel(myHero,_W)+10+.2*GetBonusAP(myHero))*6*stagedmg3) --xsec (6 sec). stage3: Max damage
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+25+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = (5*GetCastLevel(myHero,_R)+19+.04*GetBonusAP(myHero))*GetMaxHP(target)/100 --half Initial and half over 10 sec
			end
		elseif GetObjectName(myHero) == "Morgana" then
			if spellname == Q then DmgM = 55*GetCastLevel(myHero,_Q)+25+.6*GetBonusAP(myHero)
			elseif spellname == W then DmgM = (7*GetCastLevel(myHero,_W)+5+.11*GetBonusAP(myHero))*(1+.5*(1-GetCurrentHP(target)/GetMaxHP(target))) --x 1/2 sec (5 sec)
			elseif spellname == R then DmgM = math.max(75*GetCastLevel(myHero,_R)+75+.7*GetBonusAP(myHero),(75*GetCastLevel(myHero,_R)+75+.7*GetBonusAP(myHero))*2*stagedmg3) --x2 If the target stay in range for the full duration. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Nami" then
			if spellname == Q then DmgM = 55*GetCastLevel(myHero,_Q)+20+.5*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+30+.5*GetBonusAP(myHero) --The percentage power of later bounces now scales. Each bounce gains 0.75% more power per 10 GetBonusAP(myHero)
			elseif spellname == E then DmgM = 15*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero) TypeDmg = 2 --xhit (max 3 hits)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nasus" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)+10 TypeDmg = 2 --+3 per enemy killed by Siphoning Strike (bonus)
			elseif spellname == E then DmgM = math.max((80*GetCastLevel(myHero,_E)+30+1.2*GetBonusAP(myHero))/5,(80*GetCastLevel(myHero,_E)+30+1.2*GetBonusAP(myHero))*stagedmg3) --xsec (5 sec). stage3: Max damage
			elseif spellname == R then DmgM = (GetCastLevel(myHero,_R)+2+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 --xsec (15 sec)
			end
		elseif GetObjectName(myHero) == "Nautilus" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+15+.75*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 15*GetCastLevel(myHero,_W)+25+.4*GetBonusAP(myHero) TypeDmg = 2 --xhit (bonus)
			elseif spellname == E then DmgM = math.max(40*GetCastLevel(myHero,_E)+20+.5*GetBonusAP(myHero),(40*GetCastLevel(myHero,_E)+20+.5*GetBonusAP(myHero))*2*stagedmg3) --xexplosions , 50% less damage from GetBaseDamage(myHero)ditional explosions. stage3: Max damage
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+75+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nidalee" then
			if spellname == Q then DmgM = 25*GetCastLevel(myHero,_Q)+25+.4*GetBonusAP(myHero) --deals 300% damage the further away the target is, gains damage from 525 units until 1300 units
			elseif spellname == QM then DmgM = (math.max(4,30*GetCastLevel(myHero,_R)-40,40*GetCastLevel(myHero,_R)-70)+.75*GetBaseDamage(myHero)+.36*GetBonusAP(myHero))*(1+1.5*(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target)) --Deals 33% increased damage against Hunted
			elseif spellname == W then DmgM = 20*GetCastLevel(myHero,_W)+(2*GetCastLevel(myHero,_W)+8+.02*GetBonusAP(myHero))*GetCurrentHP(target)/100 -- over 4 sec
			elseif spellname == WM then DmgM = 50*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero)
			elseif spellname == EM then DmgM = 60*GetCastLevel(myHero,_R)+10+.45*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nocturne" then
			if spellname == Q then DmgP = 45*GetCastLevel(myHero,_Q)+15+.75*GetBonusDmg(myHero)
			elseif spellname == E then DmgM = 50*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
			elseif spellname == R then DmgP = 100*GetCastLevel(myHero,_R)+50+1.2*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Nunu" then
			if spellname == Q then DmgM = .01*GetMaxHP(myHero) --xhit Ornery Monster Tails passive
			elseif spellname == E then DmgM = 37.5*GetCastLevel(myHero,_E)+47.5+GetBonusAP(myHero)
			elseif spellname == R then DmgM = 250*GetCastLevel(myHero,_R)+375+2.5*GetBonusAP(myHero) --After 3 sec
			end
		elseif GetObjectName(myHero) == "Olaf" then
			if spellname == Q then DmgP = 45*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero)
			elseif spellname == E then DmgT = 45*GetCastLevel(myHero,_E)+25+.4*GetBaseDamage(myHero)
			end
		elseif GetObjectName(myHero) == "Orianna" then
			if spellname == Q then DmgM = 30*GetCastLevel(myHero,_Q)+30+.5*GetBonusAP(myHero) --10% less damage for each subsequent target hit down to a minimum of 40%
			elseif spellname == W then DmgM = 45*GetCastLevel(myHero,_W)+25+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+30+.3*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 75*GetCastLevel(myHero,_R)+75+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Pantheon" then
			if spellname == Q then DmgP = (40*GetCastLevel(myHero,_Q)+25+1.4*GetBonusDmg(myHero))*(1+math.floor((GetMaxHP(target)-GetCurrentHP(target))/(GetMaxHP(target)*0.85)))
			elseif spellname == W then DmgM = 25*GetCastLevel(myHero,_W)+25+GetBonusAP(myHero)
			elseif spellname == E then DmgP = math.max(20*GetCastLevel(myHero,_E)+6+1.2*GetBonusDmg(myHero),(20*GetCastLevel(myHero,_E)+6+1.2*GetBonusDmg(myHero))*3*stagedmg3) --xStrike (3 strikes). stage3: Max damage
			elseif spellname == R then DmgM = 300*GetCastLevel(myHero,_R)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Poppy" then
			if spellname == Q then DmgM = 25*GetCastLevel(myHero,_Q)+.6*GetBonusAP(myHero)+GetBaseDamage(myHero)+math.min(0.08*GetMaxHP(target),75*GetCastLevel(myHero,_Q)) --(GetBonusAP(myHero)plies on hit?) TypeDmg = 3
			elseif spellname == E then DmgM = math.max((25*GetCastLevel(myHero,_E)+25+.4*GetBonusAP(myHero))*stagedmg1,(50*GetCastLevel(myHero,_E)+25+.4*GetBonusAP(myHero))*stagedmg2,(75*GetCastLevel(myHero,_E)+50+.8*GetBonusAP(myHero))*stagedmg3) --stage1:initial. stage2:Collision. stage3: Max damage
			elseif spellname == R then DmgT = 10*GetCastLevel(myHero,_R)+10 --% Increased Damage
			end
		elseif GetObjectName(myHero) == "Quinn" then
			if spellname == "P" then DmgP = math.max(10*GetLevel(myHero)+15,15*GetLevel(myHero)-55)+.5*GetBonusDmg(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == Q then DmgP = 40*GetCastLevel(myHero,_Q)+30+.65*GetBonusDmg(myHero)+.5*GetBonusAP(myHero)
			elseif spellname == E then DmgP = 30*GetCastLevel(myHero,_E)+10+.2*GetBonusDmg(myHero)
			elseif spellname == R then DmgP = (50*GetCastLevel(myHero,_R)+70+.5*GetBonusDmg(myHero))*(2-GetCurrentHP(target)/GetMaxHP(target))
			end
		elseif GetObjectName(myHero) == "Rammus" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+50+GetBonusAP(myHero)
			elseif spellname == W then DmgM = 10*GetCastLevel(myHero,_W)+5+.1*GetArmor(myHero) --x each attack suffered
			elseif spellname == R then DmgM = 65*GetCastLevel(myHero,_R)+.3*GetBonusAP(myHero) --xsec (8 sec)
			end
		elseif GetObjectName(myHero) == "RekSai" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)-5+.4*GetBonusDmg(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == QM then DmgM = 30*GetCastLevel(myHero,_Q)+30+GetBonusAP(myHero)
			elseif spellname == WM then DmgP = 50*GetCastLevel(myHero,_W)+10+.5*GetBonusDmg(myHero)
			elseif spellname == E then DmgP = (.1*GetCastLevel(myHero,_E)+.7)*GetBaseDamage(myHero)*(1+GetCurrentMana(myHero)/GetMaxMana(myHero))*(1-math.floor(GetCurrentMana(myHero)/GetMaxMana(myHero))) DmgT = (.1*GetCastLevel(myHero,_E)+.7)*GetBaseDamage(myHero)*2*math.floor(GetCurrentMana(myHero)/GetMaxMana(myHero))
			end
		elseif GetObjectName(myHero) == "Renekton" then
			if spellname == Q then DmgP = math.max(30*GetCastLevel(myHero,_Q)+30+.8*GetBonusDmg(myHero),(30*GetCastLevel(myHero,_Q)+30+.8*GetBonusDmg(myHero))*1.5*stagedmg3) --stage1:with 50 fury deals 50% GetBaseDamage(myHero)ditional damage. stage3: Max damage
			elseif spellname == W then DmgP = math.max(20*GetCastLevel(myHero,_W)-10+1.5*GetBaseDamage(myHero),(20*GetCastLevel(myHero,_W)-10+1.5*GetBaseDamage(myHero))*1.5*stagedmg3) --stage1:with 50 fury deals 50% GetBaseDamage(myHero)ditional damage. stage3: Max damage -- on hit x2 or x3
			elseif spellname == E then DmgP = math.max(30*GetCastLevel(myHero,_E)+.9*GetBonusDmg(myHero),(30*GetCastLevel(myHero,_E)+.9*GetBonusDmg(myHero))*1.5*stagedmg3) --stage1:Slice or Dice , with 50 fury Dice deals 50% GetBaseDamage(myHero)ditional damage. stage3: Max damage of Dice
			elseif spellname == R then DmgM = math.max(30*GetCastLevel(myHero,_R),60*GetCastLevel(myHero,_R)-60)+.1*GetBonusAP(myHero) --xsec (15 sec)
			end
		elseif GetObjectName(myHero) == "Rengar" then
			if spellname == Q then DmgP = math.max((30*GetCastLevel(myHero,_Q)+(.05*GetCastLevel(myHero,_Q)-.05)*GetBaseDamage(myHero))*stagedmg1,(math.min(15*GetLevel(myHero)+15,10*GetLevel(myHero)+60)+.5*GetBaseDamage(myHero))*(stagedmg2+stagedmg3)) TypeDmg = 2 --stage1:Savagery. stage2-stage3:Empowered Savagery.
			elseif spellname == W then DmgM = math.max((30*GetCastLevel(myHero,_W)+20+.8*GetBonusAP(myHero))*stagedmg1,(math.min(15*GetLevel(myHero)+25,math.max(145,10*GetLevel(myHero)+60))+.8*GetBonusAP(myHero))*(stagedmg2+stagedmg3)) --stage1:Battle RoGetArmor(myHero). stage2-stage3:Empowered Battle RoGetArmor(myHero).
			elseif spellname == E then DmgP = math.max((50*GetCastLevel(myHero,_E)+.7*GetBonusDmg(myHero))*stagedmg1,(math.min(25*GetLevel(myHero)+25,10*GetLevel(myHero)+160)+.7*GetBonusDmg(myHero))*(stagedmg2+stagedmg3))
			end
		elseif GetObjectName(myHero) == "Riven" then
			if spellname == "P" then DmgP = 5+math.max(5*math.floor((GetLevel(myHero)+2)/3)+10,10*math.floor((GetLevel(myHero)+2)/3)-15)*GetBaseDamage(myHero)/100 --xchGetArmor(myHero)ge
			elseif spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)-10+(.05*GetCastLevel(myHero,_Q)+.35)*GetBaseDamage(myHero) --xstrike (3 strikes)
			elseif spellname == W then DmgP = 30*GetCastLevel(myHero,_W)+20+GetBonusDmg(myHero)
			elseif spellname == R then DmgP = math.min((40*GetCastLevel(myHero,_R)+40+.6*GetBonusDmg(myHero))*(1+(100-25)/100*8/3),120*GetCastLevel(myHero,_R)+120+1.8*GetBonusDmg(myHero))
			end
		elseif GetObjectName(myHero) == "Rumble" then
			if spellname == "P" then DmgM = 20+5*GetLevel(myHero)+.25*GetBonusAP(myHero) TypeDmg = 2 --xhit
			elseif spellname == Q then DmgM = math.max(20*GetCastLevel(myHero,_Q)+5+.33*GetBonusAP(myHero),(20*GetCastLevel(myHero,_Q)+5+.33*GetBonusAP(myHero))*3*stagedmg3) --xsec (3 sec) , with 50 heat deals 150% damage. stage3: Max damage , with 50 heat deals 150% damage
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+20+.4*GetBonusAP(myHero) --xshoot (2 shoots) , with 50 heat deals 150% damage
			elseif spellname == R then DmgM = math.max(55*GetCastLevel(myHero,_R)+75+.3*GetBonusAP(myHero),(55*GetCastLevel(myHero,_R)+75+.3*GetBonusAP(myHero))*5*stagedmg3) --stage1: xsec (5 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Ryze" then
			if spellname == Q then DmgM = 20*GetCastLevel(myHero,_Q)+20+.4*GetBonusAP(myHero)+.065*GetMaxMana(myHero)
			elseif spellname == W then DmgM = 35*GetCastLevel(myHero,_W)+25+.6*GetBonusAP(myHero)+.045*GetMaxMana(myHero)
			elseif spellname == E then DmgM = math.max(20*GetCastLevel(myHero,_E)+30+.35*GetBonusAP(myHero)+.01*GetMaxMana(myHero),(20*GetCastLevel(myHero,_E)+30+.35*GetBonusAP(myHero)+.01*GetMaxMana(myHero))*3*stagedmg3) --xbounce. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Sejuani" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+35+.4*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max(((2*GetCastLevel(myHero,_W)+2+.03*GetBonusAP(myHero))*GetMaxHP(target)/100)*stagedmg1,(30*GetCastLevel(myHero,_W)+10+.6*GetBonusAP(myHero)+(2*GetCastLevel(myHero,_W)+2)*GetMaxHP(myHero)/100)/4*(stagedmg2+stagedmg3)) TypeDmg = 1+stagedmg1 --stage1: bonus. stage2-3: xsec (4 sec)
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+30+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Shaco" then
			if spellname == Q then DmgP = (.2*GetCastLevel(myHero,_Q)+.2)*GetBaseDamage(myHero) --(bonus)
			elseif spellname == W then DmgM = 15*GetCastLevel(myHero,_W)+20+.2*GetBonusAP(myHero) --xhit
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+10+GetBonusAP(myHero)+GetBonusDmg(myHero)
			elseif spellname == R then DmgM = 150*GetCastLevel(myHero,_R)+150+GetBonusAP(myHero) --The clone deals 75% of Shaco's damage
			end
		elseif GetObjectName(myHero) == "Shen" then
			if spellname == "P" then DmgM = 4+4*GetLevel(myHero)+(GetMaxHP(myHero)-(428+85*GetLevel(myHero)))*.1 TypeDmg = 2 --(bonus)
			elseif spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+20+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 35*GetCastLevel(myHero,_E)+15+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Shyvana" then
			if spellname == Q then DmgP = (.05*GetCastLevel(myHero,_Q)+.75)*GetBaseDamage(myHero) TypeDmg = 2 --Second Strike
			elseif spellname == W then DmgM = 15*GetCastLevel(myHero,_W)+5+.2*GetBonusDmg(myHero) --xsec (3 sec + 4 extra sec)
			elseif spellname == E then DmgM = math.max((40*GetCastLevel(myHero,_E)+20+.6*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(2*GetMaxHP(target)/100)*stagedmg2) --stage1-3:Active. stage2:Each autoattack that hits debuffed targets
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Singed" then
			if spellname == Q then DmgM = 12*GetCastLevel(myHero,_Q)+10+.3*GetBonusAP(myHero) --xsec
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+35+.75*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Sion" then
			if spellname == "P" then DmgP = 10*GetMaxHP(target)/100 TypeDmg = 2
			elseif spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)+.6*GetBaseDamage(myHero) --Minimum, x3 over 2 sec
			elseif spellname == W then DmgM = 25*GetCastLevel(myHero,_W)+15+.4*GetBonusAP(myHero)+(GetCastLevel(myHero,_W)+9)*GetMaxHP(target)/100
			elseif spellname == E then DmgM = math.max(35*GetCastLevel(myHero,_W)+35+.4*GetBonusAP(myHero),(35*GetCastLevel(myHero,_W)+35+.4*GetBonusAP(myHero))*1.5*stagedmg3) --Minimum. stage3: x1.5 if hits a minion
			elseif spellname == R then DmgP = 150*GetCastLevel(myHero,_Q)+.4*GetBonusDmg(myHero) --Minimum, x2 over 1.75 sec
			end
		elseif GetObjectName(myHero) == "Sivir" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)+5+.5*GetBonusAP(myHero)+(.1*GetCastLevel(myHero,_Q)+.6)*GetBaseDamage(myHero) --x2 , 15% reduced damage to each subsequent target
			elseif spellname == W then DmgP = (.05*GetCastLevel(myHero,_W)+.45)*GetBaseDamage(myHero)*stagedmg2 TypeDmg = 2 --stage1:bonus to attack target. stage2: Bounce Damage
			end
		elseif GetObjectName(myHero) == "Skarner" then
			if spellname == "P" then DmgM = 5*GetLevel(myHero)+15 TypeDmg = 2
			elseif spellname == Q then DmgP = (10*GetCastLevel(myHero,_Q)+8+.4*GetBonusDmg(myHero))*(stagedmg1+stagedmg3) QDmgM = (10*GetCastLevel(myHero,_Q)+8+.2*GetBonusAP(myHero))*(stagedmg2+stagedmg3) --stage1:basic. stage2: chGetArmor(myHero)ge bonus. stage2: total
			elseif spellname == E then DmgM = 20*GetCastLevel(myHero,_E)+20+.4*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max((100*GetCastLevel(myHero,_R)+100+GetBonusAP(myHero))*(stagedmg1+stagedmg3),(25*GetCastLevel(myHero,_R)+25)*stagedmg2)--stage1-3:basic. stage2: per stacks of Crystal Venom.
			end
		elseif GetObjectName(myHero) == "Sona" then
			if spellname == "P" then DmgM = (math.max(7*GetLevel(myHero)+6,8*GetLevel(myHero)+3,9*GetLevel(myHero)-2,10*GetLevel(myHero)-8,15*GetLevel(myHero)-78)+.2*GetBonusAP(myHero))*(1+stagedmg1) TypeDmg = 2 --stage1: Staccato. stage2:Diminuendo or Tempo
			elseif spellname == Q then DmgM = math.max((40*GetCastLevel(myHero,_Q)+.5*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(10*GetCastLevel(myHero,_Q)+30+.2*GetBonusAP(myHero)+10*GetCastLevel(myHero,_R))*stagedmg2) TypeDmg = 1+stagedmg2 --stage1-3: Active. stage2:On-hit
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Soraka" then
			if spellname == Q then DmgM = math.max(40*GetCastLevel(myHero,_Q)+30+.35*GetBonusAP(myHero),(40*GetCastLevel(myHero,_Q)+30+.35*GetBonusAP(myHero))*1.5*stagedmg3) --stage1: border. stage3: center
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+30+.4*GetBonusAP(myHero) --Initial or SecondGetArmor(myHero)y
			end
		elseif GetObjectName(myHero) == "Swain" then
			if spellname == Q then DmgM = math.max(15*GetCastLevel(myHero,_Q)+10+.3*GetBonusAP(myHero),(15*GetCastLevel(myHero,_Q)+10+.3*GetBonusAP(myHero))*3*stagedmg3) --xsec (3 sec). stage3: Max damage
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+40+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = (40*GetCastLevel(myHero,_E)+35+.8*GetBonusAP(myHero))*(stagedmg1+stagedmg3) DmgT = (3*GetCastLevel(myHero,_E)+5)*stagedmg2 --stage1-3:Active.  stage2:% Extra Damage.
			elseif spellname == R then DmgM = 20*GetCastLevel(myHero,_R)+30+.2*GetBonusAP(myHero) --xstrike (1 strike x sec)
			end
		elseif GetObjectName(myHero) == "Syndra" then
			if spellname == Q then DmgM = math.max(40*GetCastLevel(myHero,_Q)+30+.6*GetBonusAP(myHero),(40*GetCastLevel(myHero,_Q)+30+.6*GetBonusAP(myHero))*1.15*(GetCastLevel(myHero,_Q)-4))
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+40+.7*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+25+.4*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero),(45*GetCastLevel(myHero,_R)+45+.2*GetBonusAP(myHero))*7*stagedmg3) --stage1:xSphere (Minimum 3). stage3:7 Spheres
			end
		elseif GetObjectName(myHero) == "Talon" then
			if spellname == Q then DmgP = 40*GetCastLevel(myHero,_Q)+1.3*GetBonusDmg(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgP = math.max(25*GetCastLevel(myHero,_W)+5+.6*GetBonusDmg(myHero),(25*GetCastLevel(myHero,_W)+5+.6*GetBonusDmg(myHero))*2*stagedmg3) --x2 if the target is hit twice. stage3: Max damage
			elseif spellname == E then DmgT = 3*GetCastLevel(myHero,_E) --% Damage Amplification
			elseif spellname == R then DmgP = math.max(50*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero),(50*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero))*2*stagedmg3) --x2 if the target is hit twice. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Taric" then
			if spellname == "P" then DmgM = .2*GetArmor(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgM = 40*GetCastLevel(myHero,_W)+.2*GetArmor(myHero)
			elseif spellname == E then DmgM = math.max(30*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero),(30*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero))*2*stagedmg3) --min (lower damage the fGetArmor(myHero)ther the target is) up to 200%. stage3: Max damage
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Teemo" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+35+.8*GetBonusAP(myHero)
			elseif spellname == E then DmgM = math.max((10*GetCastLevel(myHero,_E)+.3*GetBonusAP(myHero))*stagedmg1,(6*GetCastLevel(myHero,_E)+.1*GetBonusAP(myHero))*stagedmg2,(34*GetCastLevel(myHero,_E)+.7*GetBonusAP(myHero))*stagedmg3) --stage1:Hit (bonus). stage2:poison xsec (4 sec). stage3:Hit+poison for 4 sec
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+75+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Thresh" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+40+.5*GetBonusAP(myHero)
			elseif spellname == E then DmgM = math.max((40*GetCastLevel(myHero,_E)+25+.4*GetBonusAP(myHero))*(stagedmg1+stagedmg3),((.3*GetCastLevel(myHero,_Q)+.5)*GetBaseDamage(myHero))*stagedmg2) --stage1:Active. stage2:Passive (+ Souls). stage3:stage1
			elseif spellname == R then DmgM = 150*GetCastLevel(myHero,_R)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Tristana" then
			if spellname == W then DmgM = 45*GetCastLevel(myHero,_W)+25+.8*GetBonusAP(myHero)
			elseif spellname == E then DmgM = math.max((45*GetCastLevel(myHero,_E)+35+GetBonusAP(myHero))*(stagedmg1+stagedmg3),(25*GetCastLevel(myHero,_E)+25+.25*GetBonusAP(myHero))*stagedmg2) --stage1-3:Active. stage2:Passive.
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+200+1.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Trundle" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q)+(5*GetCastLevel(myHero,_Q)+95)*GetBaseDamage(myHero)/100 TypeDmg = 2 --(bonus)
			elseif spellname == R then DmgM = (2*GetCastLevel(myHero,_R)+18+.02*GetBonusAP(myHero))*GetMaxHP(target)/100 --over 4 sec
			end
		elseif GetObjectName(myHero) == "Tryndamere" then
			if spellname == E then DmgP = 30*GetCastLevel(myHero,_E)+40+GetBonusAP(myHero)+1.2*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "TwistedFate" then
			if spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+10+.65*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max((7.5*GetCastLevel(myHero,_W)+7.5+.5*GetBonusAP(myHero)+GetBaseDamage(myHero))*stagedmg1,(15*GetCastLevel(myHero,_W)+15+.5*GetBonusAP(myHero)+GetBaseDamage(myHero))*stagedmg2,(20*GetCastLevel(myHero,_W)+20+.5*GetBonusAP(myHero)+GetBaseDamage(myHero))*stagedmg3) --stage1:Gold CGetArmor(myHero)d.  stage2:Red CGetArmor(myHero)d.  stage3:Blue CGetArmor(myHero)d
			elseif spellname == E then DmgM = 25*GetCastLevel(myHero,_E)+30+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Twitch" then
			if spellname == "P" then DmgT = math.floor((GetLevel(myHero)+2)/3) --xstack xsec (6 stack 6 sec)
			elseif spellname == E then DmgP = math.max((5*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero)+.25*GetBonusDmg(myHero))*stagedmg1,(15*GetCastLevel(myHero,_E)+5)*stagedmg2,((5*GetCastLevel(myHero,_E)+10+.2*GetBonusAP(myHero)+.25*GetBonusDmg(myHero))*6+15*GetCastLevel(myHero,_E)+5)*stagedmg3) --stage1:xstack (6 stack). stage2:Base. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Udyr" then
			if spellname == Q then DmgP = math.max((50*GetCastLevel(myHero,_Q)-20+(.1*GetCastLevel(myHero,_Q)+1.1)*GetBaseDamage(myHero))*(stagedmg2+stagedmg3),(.15*GetBaseDamage(myHero))*stagedmg1) TypeDmg = 2 --stage1:persistent effect. stage2:(bonus). stage3:stage2
			elseif spellname == W then TypeDmg = 2
			elseif spellname == E then TypeDmg = 2
			elseif spellname == R then DmgM = math.max((40*GetCastLevel(myHero,_R)+.45*GetBonusAP(myHero))*stagedmg2,(10*GetCastLevel(myHero,_R)+5+.25*GetBonusAP(myHero))*stagedmg3) TypeDmg = 2 --stage1:0. stage2:xThird Attack. stage3:x wave (5 waves)
			end
		elseif GetObjectName(myHero) == "Urgot" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)-20+.85*GetBaseDamage(myHero)
			elseif spellname == E then DmgP = 55*GetCastLevel(myHero,_E)+20+.6*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Varus" then
			if spellname == Q then DmgP = math.max(.625*(55*GetCastLevel(myHero,_Q)-40+1.6*GetBaseDamage(myHero)),(55*GetCastLevel(myHero,_Q)-40+1.6*GetBaseDamage(myHero))*stagedmg3) --stage1:min. stage3:max. reduced by 15% per enemy hit (minimum 33%)
			elseif spellname == W then DmgM = math.max((4*GetCastLevel(myHero,_W)+6+.25*GetBonusAP(myHero))*stagedmg1,((.0075*GetCastLevel(myHero,_W)+.0125+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)*stagedmg2,((.0075*GetCastLevel(myHero,_W)+.0125+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)*3*stagedmg3) --stage1:xhit. stage2:xstack (3 stacks). stage3: 3 stacks
			elseif spellname == E then DmgP = 35*GetCastLevel(myHero,_E)+30+.6*GetBaseDamage(myHero)
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Vayne" then
			if spellname == Q then DmgP = (.05*GetCastLevel(myHero,_Q)+.25)*GetBaseDamage(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgT = 10*GetCastLevel(myHero,_W)+10+((1*GetCastLevel(myHero,_W)+3)*GetMaxHP(target)/100)
			elseif spellname == E then DmgP = math.max(35*GetCastLevel(myHero,_E)+10+.5*GetBonusDmg(myHero),(35*GetCastLevel(myHero,_E)+10+.5*GetBonusDmg(myHero))*2*stagedmg3) --x2 If they collide with terrain. stage3: Max damage
			elseif spellname == R then TypeDmg = 2
			end
		elseif GetObjectName(myHero) == "Veigar" then
			if spellname == Q then DmgM = 45*GetCastLevel(myHero,_Q)+35+.6*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 50*GetCastLevel(myHero,_W)+70+GetBonusAP(myHero)
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+125+1.2*GetBonusAP(myHero)+.8*GetBonusAP(target)
			end
		elseif GetObjectName(myHero) == "Velkoz" then
			if spellname == "P" then DmgT = 10*GetLevel(myHero)+25
			elseif spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+40+.6*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max(20*GetCastLevel(myHero,_W)+10+.25*GetBonusAP(myHero),(20*GetCastLevel(myHero,_W)+10+.25*GetBonusAP(myHero))*1.5*stagedmg2) --stage1-3:Initial. stage2:Detonation.
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+40+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 20*GetCastLevel(myHero,_R)+30+.6*GetBonusAP(myHero) --every 0.25 sec (2.5 sec), Organic Deconstruction every 0.5 sec
			end
		elseif GetObjectName(myHero) == "Vi" then
			if spellname == Q then DmgP = math.max(25*GetCastLevel(myHero,_Q)+25+.8*GetBonusDmg(myHero),(25*GetCastLevel(myHero,_Q)+25+.8*GetBonusDmg(myHero))*2*stagedmg3) --x2 If chGetArmor(myHero)ging up to 1.5 seconds. stage3: Max damage
			elseif spellname == W then DmgP = ((3/2)*GetCastLevel(myHero,_W)+5/2+(1/35)*GetBonusDmg(myHero))*GetCurrentHP(target)/100
			elseif spellname == E then DmgP = 15*GetCastLevel(myHero,_E)-10+.15*GetBaseDamage(myHero)+.7*GetBonusAP(myHero) TypeDmg = 2 --(Bonus)
			elseif spellname == R then DmgP = 150*GetCastLevel(myHero,_R)+50+1.4*GetBonusDmg(myHero) --deals 75% damage to enemies in her way
			end
		elseif GetObjectName(myHero) == "Viktor" then
			if spellname == Q then DmgM = math.max((20*GetCastLevel(myHero,_Q)+20+.2*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(math.max(5*GetLevel(myHero)+15,10*GetLevel(myHero)-30,20*GetLevel(myHero)-150)+.5*GetBonusAP(myHero)+GetBaseDamage(myHero))*stagedmg2) --stage1-3:Initial. stage2:basic attack.
			elseif spellname == E then DmgM = math.max(45*GetCastLevel(myHero,_E)+25+.7*GetBonusAP(myHero),(45*GetCastLevel(myHero,_E)+25+.7*GetBonusAP(myHero))*1.4*stagedmg3) --Initial or Aftershock. stage3: Max damage
			elseif spellname == R then DmgM = math.max((100*GetCastLevel(myHero,_R)+50+.55*GetBonusAP(myHero))*stagedmg1,(15*GetCastLevel(myHero,_R)+.1*GetBonusAP(myHero))*stagedmg2,(100*GetCastLevel(myHero,_R)+50+.55*GetBonusAP(myHero)+(15*GetCastLevel(myHero,_R)+.1*GetBonusAP(myHero))*7)*stagedmg3) --stage1:initial. stage2: xsec (7 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Vladimir" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+55+.6*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 55*GetCastLevel(myHero,_W)+25+(GetMaxHP(myHero)-(400+85*GetLevel(myHero)))*.15 --(2 sec)
			elseif spellname == E then DmgM = math.max((25*GetCastLevel(myHero,_E)+35+.45*GetBonusAP(myHero))*stagedmg1,((25*GetCastLevel(myHero,_E)+35)*0.25)*stagedmg2,((25*GetCastLevel(myHero,_E)+35)*2+.45*GetBonusAP(myHero))*stagedmg3) --stage1:25% more base damage x stack. stage2:+x stack. stage3: Max damage
			elseif spellname == R then DmgM = 100*GetCastLevel(myHero,_R)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Volibear" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgP = ((GetCastLevel(myHero,_W)-1)*45+80+(GetMaxHP(myHero)-(440+GetLevel(myHero)*86))*.15)*(1+(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target))
			elseif spellname == E then DmgM = 45*GetCastLevel(myHero,_E)+15+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 80*GetCastLevel(myHero,_R)-5+.3*GetBonusAP(myHero) TypeDmg = 2 --xhit
			end
		elseif GetObjectName(myHero) == "Warwick" then
			if spellname == "P" then DmgM = math.max(.5*GetLevel(myHero)+2.5,(.5*GetLevel(myHero)+2.5)*3*stagedmg3) --xstack (3 stacks). stage3: Max damage
			elseif spellname == Q then DmgM = 50*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)+((2*GetCastLevel(myHero,_Q)+6)*GetMaxHP(target)/100)
			elseif spellname == R then DmgM = math.max((100*GetCastLevel(myHero,_R)+50+2*GetBonusDmg(myHero))/5,(100*GetCastLevel(myHero,_R)+50+2*GetBonusDmg(myHero))*stagedmg3) --xstrike (5 strikes) , without counting on-hit effects. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "MonkeyKing" then
			if spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)+.1*GetBaseDamage(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgM = 45*GetCastLevel(myHero,_W)+25+.6*GetBonusAP(myHero)
			elseif spellname == E then DmgP = 45*GetCastLevel(myHero,_E)+15+.8*GetBonusDmg(myHero)
			elseif spellname == R then DmgP = math.max(90*GetCastLevel(myHero,_R)-70+1.1*GetBaseDamage(myHero),(90*GetCastLevel(myHero,_R)-70+1.1*GetBaseDamage(myHero))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Xerath" then
			if spellname == Q then DmgM = 40*GetCastLevel(myHero,_Q)+40+.75*GetBonusAP(myHero)
			elseif spellname == W then DmgM = math.max((30*GetCastLevel(myHero,_Q)+30+.6*GetBonusAP(myHero))*1.5*(stagedmg1+stagedmg3),(30*GetCastLevel(myHero,_Q)+30+.6*GetBonusAP(myHero))*stagedmg2) --stage1,3: Center. stage2: Border
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+50+.45*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 55*GetCastLevel(myHero,_R)+135+.43*GetBonusAP(myHero) --xcast (3 cast)
			end
		elseif GetObjectName(myHero) == "XinZhao" then
			if spellname == Q then DmgP = 15*GetCastLevel(myHero,_Q)+.2*GetBaseDamage(myHero) TypeDmg = 2 --(bonus x hit)
			elseif spellname == E then DmgM = 35*GetCastLevel(myHero,_E)+35+.6*GetBonusAP(myHero)
			elseif spellname == R then DmgP = 100*GetCastLevel(myHero,_R)-25+GetBonusDmg(myHero)+15*GetCurrentHP(target)/100
			end
		elseif GetObjectName(myHero) == "Yasuo" then
			if spellname == Q then DmgP = 20*GetCastLevel(myHero,_Q) TypeDmg = 2 -- can critically strike, dealing X% GetBaseDamage(myHero)
			elseif spellname == E then DmgM = 20*GetCastLevel(myHero,_E)+50+.6*GetBonusAP(myHero) --Each cast increases the next dash's base damage by 25%, up to 50% bonus damage
			elseif spellname == R then DmgP = 100*GetCastLevel(myHero,_R)+100+1.5*GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Yorick" then
			if spellname == "P" then DmgP = .35*GetBaseDamage(myHero) --xhit of ghouls
			elseif spellname == Q then DmgP = 30*GetCastLevel(myHero,_Q)+.2*GetBaseDamage(myHero) TypeDmg = 2 --(bonus)
			elseif spellname == W then DmgM = 35*GetCastLevel(myHero,_W)+25+GetBonusAP(myHero)
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+25+GetBonusDmg(myHero)
			end
		elseif GetObjectName(myHero) == "Zac" then
			if spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+40+.5*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 25*GetCastLevel(myHero,_W)+15+((1*GetCastLevel(myHero,_W)+3+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)
			elseif spellname == E then DmgM = 40*GetCastLevel(myHero,_E)+50+.7*GetBonusAP(myHero)
			elseif spellname == R then DmgM = math.max(70*GetCastLevel(myHero,_R)+70+.4*GetBonusAP(myHero),(70*GetCastLevel(myHero,_R)+70+.4*GetBonusAP(myHero))*2.5*stagedmg3) 
			end
		elseif GetObjectName(myHero) == "Zed" then
			if spellname == "P" then DmgM = (6+2*(math.floor((GetLevel(myHero)-1)/6)))*GetMaxHP(target)/100 TypeDmg = 2
			elseif spellname == Q then DmgP = math.max((40*GetCastLevel(myHero,_Q)+35+GetBonusDmg(myHero))*stagedmg1,(40*GetCastLevel(myHero,_Q)+35+GetBonusDmg(myHero))*.6*stagedmg2,(40*GetCastLevel(myHero,_Q)+35+GetBonusDmg(myHero))*1.5*stagedmg3)  
			elseif spellname == E then DmgP = 30*GetCastLevel(myHero,_E)+30+.8*GetBonusDmg(myHero)
			elseif spellname == R then DmgP = GetBaseDamage(myHero)*(stagedmg1+stagedmg3) DmgT = (15*GetCastLevel(myHero,_R)+5)*stagedmg2 
			end
		elseif GetObjectName(myHero) == "Ziggs" then
			if spellname == "P" then DmgM = math.max(4*GetLevel(myHero)+16,8*GetLevel(myHero)-8,12*GetLevel(myHero)-56)+(.2+.05*math.floor((GetLevel(myHero)+5)/6))*GetBonusAP(myHero) TypeDmg = 2
			elseif spellname == Q then DmgM = 37.5*GetCastLevel(myHero,_Q)+45+.65*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 35*GetCastLevel(myHero,_W)+35+.35*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 20*GetCastLevel(myHero,_E)+25+.3*GetBonusAP(myHero) 
			elseif spellname == R then DmgM = 125*GetCastLevel(myHero,_R)+125+.9*GetBonusAP(myHero) 
			end
		elseif GetObjectName(myHero) == "Zilean" then
			if spellname == Q then DmgM = 37.5*GetCastLevel(myHero,_Q)+40+.9*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Zyra" then
			if spellname == "P" then DmgT = 80+20*GetLevel(myHero)
			elseif spellname == Q then DmgM = 35*GetCastLevel(myHero,_Q)+35+.65*GetBonusAP(myHero)
			elseif spellname == W then DmgM = 29.5+6.5*GetLevel(myHero)+.2*GetBonusAP(myHero)
			elseif spellname == E then DmgM = 30*GetCastLevel(myHero,_E)+35+.5*GetBonusAP(myHero)
			elseif spellname == R then DmgM = 90*GetCastLevel(myHero,_R)+85+.7*GetBonusAP(myHero)
			end
		end
		if DmgM > 0 then DmgM = CalcMagicDamage(target,DmgM) end
		if DmgP > 0 then DmgP = CalcDamage(target,DmgP) end
		TrueDmg = DmgM+DmgP+DmgT
	elseif (spellname == "GetBaseDamage(myHero)") then
		TrueDmg = myHero:CalcDamage(target,GetBaseDamage(myHero))
	elseif (spellname == "IGNITE") then
		TrueDmg = 50+20*GetLevel(myHero)
	elseif (spellname == "SMITESS") then
		TrueDmg = 54+6*GetLevel(myHero) 
	elseif (spellname == "SMITESB") then
		TrueDmg = 20+8*GetLevel(myHero)
	elseif (spellname == "HXG") then
		TrueDmg = myHero:CalcMagicDamage(target,150+.4*GetBonusAP(myHero))
	elseif (spellname == "BWC") then
		TrueDmg = myHero:CalcMagicDamage(target,100)
	elseif (spellname == "NTOOTH") then
		TrueDmg = myHero:CalcMagicDamage(target,15+.15*GetBonusAP(myHero))
	elseif (spellname == "WITSEND") then
		TrueDmg = myHero:CalcMagicDamage(target,42)
	elseif (spellname == "SHEEN") then
		TrueDmg = myHero:CalcDamage(target,GetBaseDamage(myHero)-GetBonusDmg(myHero)) 
	elseif (spellname == "TRINITY") then
		TrueDmg = myHero:CalcDamage(target,2*(GetBaseDamage(myHero)-GetBonusDmg(myHero))) 
	elseif (spellname == "LICHBANE") then
		TrueDmg = myHero:CalcMagicDamage(target,.75*(GetBaseDamage(myHero)-GetBonusDmg(myHero))+.5*GetBonusAP(myHero)) 
	elseif (spellname == "LIANDRYS") then
		TrueDmg = myHero:CalcMagicDamage(target,.06*GetCurrentHP(target)) 
	elseif (spellname == "STATIKK") then
		TrueDmg = myHero:CalcMagicDamage(target,100)
	elseif (spellname == "ICEBORN") then
		TrueDmg = myHero:CalcDamage(target,1.25*(GetBaseDamage(myHero)-GetBonusDmg(myHero))) 
	elseif (spellname == "TIAMAT") then
		TrueDmg = myHero:CalcDamage(target,.6*GetBaseDamage(myHero)) 
	elseif (spellname == "HYDRA") then
		TrueDmg = myHero:CalcDamage(target,.6*GetBaseDamage(myHero)) 
	elseif (spellname == "RUINEDKING") then
		TrueDmg = math.max(myHero:CalcDamage(target,.08*GetCurrentHP(target))*(stagedmg1+stagedmg3),myHero:CalcDamage(target,math.max(.1*GetMaxHP(target),100))*stagedmg2) 
	elseif (spellname == "MURAGetCurrentMana(myHero)") then
		TrueDmg = myHero:CalcDamage(target,.06*GetCurrentMana(myHero))
	elseif (spellname == "HURRICANE") then
		TrueDmg = myHero:CalcDamage(target,10+.5*GetBaseDamage(myHero)) 
	elseif (spellname == "SUNFIRE") then
		TrueDmg = myHero:CalcMagicDamage(target,25+GetLevel(myHero)) 
	elseif (spellname == "LIGHTBRINGER") then
		TrueDmg = myHero:CalcMagicDamage(target,100) 
	elseif (spellname == "MOUNTAIN") then
		TrueDmg = myHero:CalcMagicDamage(target,.3*GetBonusAP(myHero)+GetBaseDamage(myHero))
		
	return TrueDmg, TypeDmg
end
