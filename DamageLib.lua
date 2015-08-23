--[[
	Spell Damage LibrGetArmor(myHero)y 1.48
		by eXtragoZ
		
		Is designed to calculate the damage of the skills to champions, although most of the calculations
		work for creeps
			
-------------------------------------------------------	
	Usage:

		local target = GetCurrentTarget()
		local damage, Typedmg = dmg + getdmg("R",target,myHero,3)	
-------------------------------------------------------
	Full function:
		getdmg("SKILL",target,myHero,stagedmg,spelllvl)
		
	Returns:
		damage, Typedmg
		
		Typedmg:
			1	Normal damage
			2	Attack damage and on hit passives needs to be added to the damage
		
		Skill:			(in cGetBonusAP(myHero)itals!)
			"P"				-Passive
			"Q"
			"W"
			"E"
			"R"
			"QM"			-Q in melee form (Jayce, Nidalee and Elise only)
			"WM"			-W in melee form (Jayce, Nidalee and Elise only)
			"EM"			-E in melee form (Jayce, Nidalee and Elise only)
			
		Stagedmg:
			nil	Active or first instance of dmg
			1	Active or first instance of dmg
			2	Passive or second instance of dmg
			3	Max damage or third instance of dmg
			
		-Returns the damage they will do "myHero" to "target" with the "skill"
		-With some skills returns a percentage of increased damage
		-Many skills GetArmor(myHero)e shown per second, hit and other
		-Use spelllvl only if you want to specify the level of skill
		
]]--

function getdmg(spellname,target,myHero,stagedmg,spelllvl)
	local Qlvl(myHero) = spelllvl and spelllvl or GetCastLevel(myHero,_Q)
	local Wlvl(myHero) = spelllvl and spelllvl or GetCastLevel(myHero,_W)
	local Elvl(myHero) = spelllvl and spelllvl or GetCastLevel(myHero,_E)
	local Rlvl(myHero) = spelllvl and spelllvl or GetCastLevel(myHero,_R)
	local stagedmg1,stagedmg2,stagedmg3 = 1,0,0
	if stagedmg = dmg += 2 then stagedmg1,stagedmg2,stagedmg3 = 0,1,0
	elseif stagedmg = dmg += 3 then stagedmg1,stagedmg2,stagedmg3 = 0,0,1 end
	local dmg = dmg + 0
	local Typedmg = dmg + 1 --1 ability/normal--2 bonus to attack
	if ((spellname == "Q" or spellname == "QM") and Qlvl(myHero) == 0) or ((spellname == "W" or spellname == "WM") and Wlvl(myHero) == 0) or ((spellname == "E" or spellname == "EM") and Elvl(myHero) == 0) or (spellname == "R" and Rlvl(myHero) == 0) then
		dmg = dmg + 0
	elseif spellname == "Q" or spellname == "W" or spellname == "E" or spellname == "R" or spellname == "P" or spellname == "QM" or spellname == "WM" or spellname == "EM" then
		local apdmg = 0
		local addmg = 0
		local dmg = dmg + 0
		if GetObjectName(myHero) == "Aatrox" then
			if spellname == "Q" then addmg = 45*Qlvl(myHero)+25+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then addmg = (35*Wlvl(myHero)+25+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg1+stagedmg3) Typedmg = dmg + 2
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+40+.6*GetBonusAP(myHero)+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Ahri" then
			if spellname == "Q" then apdmg = (25*Qlvl(myHero)+15+.35*GetBonusAP(myHero))*(stagedmg1+stagedmg3) dmg = dmg + (25*Qlvl(myHero)+15+.35*GetBonusAP(myHero))*(stagedmg2+stagedmg3) -- stage1:Initial. stage2:way back. stage3:total.
			elseif spellname == "W" then apdmg = math.max(25*Wlvl(myHero)+15+.4*GetBonusAP(myHero),(25*Wlvl(myHero)+15+.4*GetBonusAP(myHero))*1.6*stagedmg3) -- xfox-fires ,  30% damage from each (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional fox-fire beyond the first. stage3: Max damage
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+25+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 40*Rlvl(myHero)+30+.3*GetBonusAP(myHero) -- per dash
			end
		elseif GetObjectName(myHero) == "Akali" then
			if spellname == "P" then apdmg = (6+GetBonusAP(myHero)/6)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))/100
			elseif spellname == "Q" then apdmg = math.max((20*Qlvl(myHero)+15+.4*GetBonusAP(myHero))*stagedmg1,(25*Qlvl(myHero)+20+.5*GetBonusAP(myHero))*stagedmg2,(45*Qlvl(myHero)+35+.9*GetBonusAP(myHero))*stagedmg3) --stage1:Initial. stage2:Detonation. stage3:Max damage
			elseif spellname == "E" then addmg = 25*Elvl(myHero)+5+.4*GetBonusAP(myHero)+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then apdmg = 75*Rlvl(myHero)+25+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Alistar" then
			if spellname == "P" then apdmg = math.max(6+GetLevel(myHero)+.1*GetBonusAP(myHero),(6+GetLevel(myHero)+.1*GetBonusAP(myHero))*3*stagedmg3)
			elseif spellname == "Q" then apdmg = 45*Qlvl(myHero)+15+.5*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 55*Wlvl(myHero)+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Amumu" then
			if spellname == "Q" then apdmg = 50*Qlvl(myHero)+30+.7*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = ((.5*Wlvl(myHero)+.5+.01*GetBonusAP(myHero))*GetMaxHP(target)/100)+4*Wlvl(myHero)+4 --xsec
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+50+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Anivia" then
			if spellname == "Q" then apdmg = math.max(30*Qlvl(myHero)+30+.5*GetBonusAP(myHero),(30*Qlvl(myHero)+30+.5*GetBonusAP(myHero))*2*stagedmg3) -- x2 if it detonates. stage3: Max damage
			elseif spellname == "E" then apdmg = math.max(30*Elvl(myHero)+25+.5*GetBonusAP(myHero),(30*Elvl(myHero)+25+.5*GetBonusAP(myHero))*2*stagedmg3) -- x2  If the target has been chilled. stage3: Max damage
			elseif spellname == "R" then apdmg = 40*Rlvl(myHero)+40+.25*GetBonusAP(myHero) --xsec
			end
		elseif GetObjectName(myHero) == "Annie" then
			if spellname == "Q" then apdmg = 35*Qlvl(myHero)+45+.8*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 45*Wlvl(myHero)+25+.85*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 10*Elvl(myHero)+10+.2*GetBonusAP(myHero) --x each attack suffered
			elseif spellname == "R" then apdmg = math.max((125*Rlvl(myHero)+50+.8*GetBonusAP(myHero))*stagedmg1,(10*Rlevel+10+.2*GetBonusAP(myHero))*stagedmg2,(125*Rlvl(myHero)+50+.8*GetBonusAP(myHero))*stagedmg3) addmg = (25*Rlvl(myHero)+55)*stagedmg2 --stage1:Summon Tibbers . stage2:Aura AoE xsec + 1 Tibbers Attack. stage3:Summon Tibbers
			end
		elseif GetObjectName(myHero) == "Ashe" then  -- script doesn't calculate autos and therefore doesn't take Ashe's crit mechanic on slowed targets into effect
			if spellname == "Q" then addmg = (.05*Qlvl(myHero)+.1)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "W" then addmg = 15*Wlvl(myHero)+5+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then apdmg = 175*Rlvl(myHero)+75+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Azir" then
			if spellname == "Q" then apdmg = 20*Qlvl(myHero)+45+.5*GetBonusAP(myHero) --beyond the first will deal only 25% damage
			elseif spellname == "W" then apdmg = math.max(5*GetLevel(myHero)+45,10*GetLevel(myHero)-10)+.6*GetBonusAP(myHero)--after the first deals 25% damage
			elseif spellname == "E" then apdmg = 30*Qlvl(myHero)+30+.4*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 75*Rlvl(myHero)+75+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Bard" then
			if spellname == "P" then apdmg = 30+.3*GetBonusAP(myHero)  --I don't know how to check Meep count to calculate damage
			elseif spellname == "Q" then apdmg = 45*Qlevel+35+.65*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Blitzcrank" then
			if spellname == "Q" then apdmg = 55*Qlvl(myHero)+25+GetBonusAP(myHero)
			elseif spellname == "E" then addmg = (GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2
			elseif spellname == "R" then apdmg = math.max((125*Rlvl(myHero)+125+GetBonusAP(myHero))*stagedmg1,(100*Rlvl(myHero)+.2*GetBonusAP(myHero))*stagedmg2,(125*Rlvl(myHero)+125+GetBonusAP(myHero))*stagedmg3) --stage1:the active. stage2:the passive. stage3:the active
			end
		elseif GetObjectName(myHero) == "Brand" then
			if spellname == "P" then apdmg = math.max(2*GetMaxHP(target)/100,(2*GetMaxHP(target)/100)*4*stagedmg3) --xsec (4sec). stage3: Max damage
			elseif spellname == "Q" then apdmg = 40*Qlvl(myHero)+40+.65*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max(45*Wlvl(myHero)+30+.6*GetBonusAP(myHero),(45*Wlvl(myHero)+30+.6*GetBonusAP(myHero))*1.25*stagedmg3) --125% for units that GetArmor(myHero)e ablaze. stage3: Max damage
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+35+.55*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(100*Rlvl(myHero)+50+.5*GetBonusAP(myHero),(100*Rlvl(myHero)+50+.5*GetBonusAP(myHero))*3*stagedmg3) --xbounce (can hit the same enemy up to three times). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Braum" then
			if spellname == "P" then apdmg = math.max((8*GetLevel(myHero)+32)*(stagedmg1+stagedmg3),(2*GetLevel(myHero)+12)*stagedmg2) --stage1-stage3:Stun. stage2:bonus damage.
			elseif spellname == "Q" then apdmg = 45*Qlvl(myHero)+25+.025*GetMaxHP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Caitlyn" then
			if spellname == "P" then addmg = .5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))*1.5 Typedmg = dmg + 2 --xhe(GetBonusdmg(myHero)+GetBaseDamage(myHero))shot (bonus)
			elseif spellname == "Q" then addmg = 40*Qlvl(myHero)-20+1.3*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --deal 10% less damage for each subsequent target hit, down to a minimum of 50%
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+30+.6*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+30+.8*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 225*Rlvl(myHero)+25+2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Cassiopeia" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+35+.45*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 5*Wlvl(myHero)+5+.1*GetBonusAP(myHero) --xsec
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+30+.55*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Chogath" then
			if spellname == "Q" then apdmg = 56.25*Qlvl(myHero)+23.75+GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+25+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 15*Elvl(myHero)+5+.3*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "R" then dmg = dmg + 175*Rlvl(myHero)+125+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Corki" then
			if spellname == "P" then dmg = dmg + .1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "Q" then apdmg = 50*Qlvl(myHero)+30+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 30*Wlvl(myHero)+30+.4*GetBonusAP(myHero) --xsec (2.5 sec)
			elseif spellname == "E" then addmg = 12*Elvl(myHero)+8+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xsec (4 sec)
			elseif spellname == "R" then apdmg = math.max(70*Rlvl(myHero)+50+.3*GetBonusAP(myHero)+(.1*Rlvl(myHero)+.1)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(70*Rlvl(myHero)+50+.3*GetBonusAP(myHero)+(.1*Rlvl(myHero)+.1)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3) --150% the big one. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Darius" then
			if spellname == "P" then apdmg = (-.75)*((-1)^GetLevel(myHero)-2*GetLevel(myHero)-13)+.3*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xstack over 5 sec
			elseif spellname == "Q" then addmg = math.max(35*Qlvl(myHero)+35+.7*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(35*Qlvl(myHero)+35+.7*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3) --150% Champions in the outer half. stage3: Max damage
			elseif spellname == "W" then addmg = .2*Wlvl(myHero)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "R" then dmg = dmg + math.max(90*Rlvl(myHero)+70+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(90*Rlvl(myHero)+70+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --xstack of Hemorrhage deals an (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional 20% damage. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Diana" then
			if spellname == "P" then apdmg = math.max(5*GetLevel(myHero)+15,10*GetLevel(myHero)-10,15*GetLevel(myHero)-60,20*GetLevel(myHero)-125,25*GetLevel(myHero)-200)+.8*GetBonusAP(myHero) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "Q" then apdmg = 35*Qlvl(myHero)+25+.7*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max(12*Wlvl(myHero)+10+.2*GetBonusAP(myHero),(12*Wlvl(myHero)+10+.2*GetBonusAP(myHero))*3*stagedmg3) --xOrb (3 orbs). stage3: Max damage
			elseif spellname == "R" then apdmg = 60*Rlvl(myHero)+40+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "DrMundo" then
			if spellname == "Q" then apdmg = math.max((2.5*Qlvl(myHero)+12.5)*GetCurrentHP(target)/100,50*Qlvl(myHero)+30)
			elseif spellname == "W" then apdmg = 15*Wlvl(myHero)+20+.2*GetBonusAP(myHero) --xsec
			end
		elseif GetObjectName(myHero) == "Draven" then
			if spellname == "Q" then addmg = (.1*Qlvl(myHero)+.35)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "E" then addmg = 35*Elvl(myHero)+35+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = 100*Rlvl(myHero)+75+1.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xhit (max 2 hits), deals 8% less damage for each unit hit, down to a minimum of 40%
			end
		elseif GetObjectName(myHero) == "Ekko" then
		    if spellname == "P" then apdmg = 10+10*GetLevel(myHero)+.8*GetBonusAP(myHero)
			elseif spellname == "Q" then apdmg = (15*Qlvl+45+.1*GetBonusAP(myHero))+(25*Qlvl+35+.6*GetBonusAP(myHero))
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+20+.2*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+50+1.3*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Elise" then
			if spellname == "P" then apdmg = 10*Rlvl(myHero)+.1*GetBonusAP(myHero) --xhit Spiderling Damage
			elseif spellname == "Q" then apdmg = 35*Qlvl(myHero)+5+(8+.03*GetBonusAP(myHero))*GetCurrentHP(target)/100
			elseif spellname == "QM" then apdmg = 40*Qlvl(myHero)+20+(8+.03*GetBonusAP(myHero))*(GetMaxHP(target)-GetCurrentHP(target))/100
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+25+.8*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 10*Rlvl(myHero)+.3*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit (bonus)
			end
		elseif GetObjectName(myHero) == "Evelynn" then
			if spellname == "Q" then apdmg = 15*Qlvl(myHero)+25+(.05*Qlvl(myHero)+.3)*GetBonusAP(myHero)+(.05*Qlvl(myHero)+.45)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then addmg = 40*Elvl(myHero)+30+GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --total
			elseif spellname == "R" then apdmg = (5*Rlvl(myHero)+10+.01*GetBonusAP(myHero))*GetCurrentHP(target)/100
			end
		elseif GetObjectName(myHero) == "Ezreal" then
			if spellname == "Q" then addmg = 20*Qlvl(myHero)+15+.4*GetBonusAP(myHero)+.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "W" then apdmg = 45*Wlvl(myHero)+25+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+25+.75*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+200+.9*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --deal 10% less damage for each subsequent target hit, down to a minimum of 30%
			end
		elseif GetObjectName(myHero) == "FiddleSticks" then
			if spellname == "W" then apdmg = math.max(30*Wlvl(myHero)+30+.45*GetBonusAP(myHero),(30*Wlvl(myHero)+30+.45*GetBonusAP(myHero))*5*stagedmg3) --xsec (5 sec). stage3: Max damage
			elseif spellname == "E" then apdmg = math.max(20*Elvl(myHero)+45+.45*GetBonusAP(myHero),(20*Elvl(myHero)+45+.45*GetBonusAP(myHero))*3*stagedmg3) --xbounce. stage3: Max damage
			elseif spellname == "R" then apdmg = math.max(100*Rlvl(myHero)+25+.45*GetBonusAP(myHero),(100*Rlvl(myHero)+25+.45*GetBonusAP(myHero))*5*stagedmg3) --xsec (5 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Fiora" then
			if spellname == "Q" then addmg = 25*Qlvl(myHero)+15+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xstrike
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+10+GetBonusAP(myHero)
			elseif spellname == "R" then addmg = math.max(130*Rlvl(myHero)-5+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(170*Rlvl(myHero)-10+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2.6*stagedmg3) --xstrike , without counting on-hit effects, Successive hits against the same target deal 40% damage. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Fizz" then
			if spellname == "Q" then apdmg = 15*Qlvl(myHero)-5+.3*GetBonusAP(myHero) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "W" then apdmg = math.max(((20*Wlvl(myHero)+10+.7*GetBonusAP(myHero))+(Wlvl(myHero)+3)*(GetMaxHP(target)-GetCurrentHP(target))/100)*(stagedmg1+stagedmg3),((10*Wlvl(myHero)+10+.35*GetBonusAP(myHero))+(Wlvl(myHero)+3)*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg2) Typedmg = dmg + 2 --stage1:when its active. stage2:Passive. stage3:when its active
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+20+.75*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+75+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Galio" then
			if spellname == "Q" then apdmg = 55*Qlvl(myHero)+25+.6*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+15+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(100*Rlvl(myHero)+100+.6*GetBonusAP(myHero),(100*Rlvl(myHero)+100+.6*GetBonusAP(myHero))*1.8*stagedmg3) --additional 5% damage for each attack suffered while channeling and cGetBonusAP(myHero)ping at 40%. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Gangplank" then
			if spellname == "P" then apdmg = 3+GetLevel(myHero) Typedmg = dmg + 2 --xstack
			elseif spellname == "Q" then addmg = 25*Qlvl(myHero)-5 Typedmg = dmg + 2 --without counting on-hit effects
			elseif spellname == "R" then apdmg = 45*Rlvl(myHero)+30+.2*GetBonusAP(myHero) --xSec (7 sec)
			end
		elseif GetObjectName(myHero) == "Garen" then
			if spellname == "Q" then addmg = 25*Qlvl(myHero)+5+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "E" then addmg = math.max(25*Elvl(myHero)-5+(.1*Elvl(myHero)+.6)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(25*Elvl(myHero)-5+(.1*Elvl(myHero)+.6)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2.5*stagedmg3) --xsec (2.5 sec). stage3: Max damage
			elseif spellname == "R" then apdmg = 175*Rlvl(myHero)+(GetMaxHP(target)-GetCurrentHP(target))/((8-Rlvl(myHero))/2)
			end
		elseif GetObjectName(myHero) == "Gnar" then
			if spellname == "Q" then addmg = 30*Qlvl(myHero)-25+1.15*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) -- 50% damage beyond the first
			elseif spellname == "QM" then addmg = 40*Qlvl(myHero)-35+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then apdmg = 10*Wlvl(myHero)+GetBonusAP(myHero)+(2*Wlvl(myHero)+4)*GetMaxHP(target)/100
			elseif spellname == "WM" then addmg = 20*Wlvl(myHero)+5+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then addmg = 40*Elvl(myHero)-20+6*GetMaxHP(myHero)/100
			elseif spellname == "EM" then addmg = 40*Elvl(myHero)-20+6*GetMaxHP(myHero)/100
			elseif spellname == "R" then addmg = math.max(100*Rlvl(myHero)+100+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero),(100*Rlvl(myHero)+100+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero))*1.5*stagedmg3) --x1.5 If collide with terrain. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Gragas" then
			if spellname == "Q" then apdmg = math.max(40*Qlvl(myHero)+40+.6*GetBonusAP(myHero),(40*Qlvl(myHero)+40+.6*GetBonusAP(myHero))*1.5*stagedmg3) --Damage increase by up to 50% over 2 seconds. stage3: Max damage
			elseif spellname == "W" then apdmg = 30*Wlvl(myHero)-10+.3*GetBonusAP(myHero)+(.01*Wlvl(myHero)+.07)*GetMaxHP(target) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+30+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+100+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Graves" then
			if spellname == "Q" then addmg = math.max(30*Qlvl(myHero)+30+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(30*Qlvl(myHero)+30+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --xbullet , 50% damage xeach bullet beyond the first. stage3: Max damage
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+10+.6*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = math.max((150*Rlvl(myHero)+100+1.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg1+stagedmg3),(120*Rlvl(myHero)+80+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2) --stage1-3:Initial. stage2:Explosion.
			end
		elseif GetObjectName(myHero) == "Hecarim" then
			if spellname == "Q" then addmg = 35*Qlvl(myHero)+25+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then apdmg = math.max(11.25*Wlvl(myHero)+8.75+.2*GetBonusAP(myHero),(11.25*Wlvl(myHero)+8.75+.2*GetBonusAP(myHero))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			elseif spellname == "E" then addmg = math.max(35*Elvl(myHero)+5+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(35*Elvl(myHero)+5+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --Minimum , 200% Maximum (bonus). stage3: Max damage
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Heimerdinger" then
			if spellname == "Q" then apdmg = math.max((5.5*Qlvl(myHero)+6.5+.15*GetBonusAP(myHero))*stagedmg1,(math.max(20*Qlvl(myHero)+20,25*Qlvl(myHero)+5)+.55*GetBonusAP(myHero))*stagedmg2,(60*Rlvl(myHero)+120+.7*GetBonusAP(myHero))*stagedmg3) --stage1:x Turrets attack. stage2:Beam. stage3:UPGR(GetBonusdmg(myHero)+GetBaseDamage(myHero))E Beam
			elseif spellname == "W" then apdmg = 30*Wlvl(myHero)+30+.45*GetBonusAP(myHero) --x Rocket, 20% magic damage for each rocket beyond the first
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+20+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max((20*Rlvl(myHero)+50+.3*GetBonusAP(myHero))*stagedmg1,(45*Rlvl(myHero)+90+.45*GetBonusAP(myHero))*stagedmg2,(50*Rlvl(myHero)+100+.6*GetBonusAP(myHero))*stagedmg3) --stage1:x Turrets attack. stage2:x Rocket, 20% magic damage for each rocket beyond the first. stage3:x Bounce
			end
		elseif GetObjectName(myHero) == "Irelia" then
			if spellname == "Q" then addmg = 30*Qlvl(myHero)-10 Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "W" then dmg = dmg + 15*Wlvl(myHero) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+40+.5*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 40*Rlvl(myHero)+40+.5*GetBonusAP(myHero)+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xbl(GetBonusdmg(myHero)+GetBaseDamage(myHero))e
			end
		elseif GetObjectName(myHero) == "Janna" then
			if spellname == "Q" then apdmg = math.max((25*Qlvl(myHero)+35+.35*GetBonusAP(myHero))*stagedmg1,(5*Qlvl(myHero)+10+.1*GetBonusAP(myHero))*stagedmg2,(25*Qlvl(myHero)+35+.35*GetBonusAP(myHero)+(5*Qlvl(myHero)+10+.1*GetBonusAP(myHero))*3)*stagedmg3) --stage1:Initial. stage2:(GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional Damage xsec (3 sec). stage3:Max damage
			elseif spellname == "W" then apdmg = 55*Wlvl(myHero)+5+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "JarvanIV" then
			if spellname == "P" then addmg = math.min(.01*GetMaxHP(target),400) Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = 45*Qlvl(myHero)+25+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+15+.8*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 125*Rlvl(myHero)+75+1.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Jax" then
			if spellname == "Q" then addmg = 40*Qlvl(myHero)+30+.6*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then apdmg = 35*Wlvl(myHero)+5+.6*GetBonusAP(myHero) Typedmg = dmg + 2
			elseif spellname == "E" then addmg = math.max(25*Elvl(myHero)+25+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(25*Elvl(myHero)+25+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --deals 20% (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional damage for each attack dodged to a maximum of 100%. stage3: Max damage
			elseif spellname == "R" then apdmg = 60*Rlvl(myHero)+40+.7*GetBonusAP(myHero) Typedmg = dmg + 2 --every third basic attack (bonus)
			end
		elseif GetObjectName(myHero) == "Jayce" then
			if spellname == "Q" then addmg = math.max(50*Qlvl(myHero)+20+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(50*Qlvl(myHero)+20+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.4*stagedmg3) --If its fired through an Acceleration Gate damage will increase by 40%. stage3: Max damage
			elseif spellname == "QM" then addmg = 40*Qlvl(myHero)-10+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then dmg = dmg + 8*Wlvl(myHero)+62 --% damage
			elseif spellname == "WM" then apdmg = math.max(15*Wlvl(myHero)+10+.25*GetBonusAP(myHero),(15*Wlvl(myHero)+10+.25*GetBonusAP(myHero))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			elseif spellname == "EM" then apdmg = (GetBonusdmg(myHero)+GetBaseDamage(myHero))+((2.4*Elvl(myHero)+6)*GetMaxHP(target)/100)
			elseif spellname == "R" then apdmg = 40*Rlvl(myHero)-20 Typedmg = dmg + 2
			end
		elseif GetObjectName(myHero) == "Jinx" then
			if spellname == "Q" then addmg = .1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2
			elseif spellname == "W" then addmg = 50*Wlvl(myHero)-40+1.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 55*Elvl(myHero)+25+GetBonusAP(myHero) -- per Chomper
			elseif spellname == "R" then addmg = math.max(((50*Rlvl(myHero)+75+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2+(0.05*Rlvl(myHero)+0.2)*(GetMaxHP(target)-GetCurrentHP(target)))*stagedmg1,(10*Rlvl(myHero)+15+.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2,(0.05*Rlvl(myHero)+0.2)*(GetMaxHP(target)-GetCurrentHP(target))*stagedmg3) --stage1:Maximum (after 1500 units)+(GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional Damage. stage2:Minimum Base (Maximum = x2). stage3: (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional Damage
			end
		elseif GetObjectName(myHero) == "Kalista" then
			if spellname == "Q" then addmg = 60*Qlvl(myHero)-50+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "W" then apdmg = (2*Wlvl(myHero)+10)*GetCurrentHP(target)/100
			elseif spellname == "E" then addmg = math.max((10*Elvl(myHero)+10+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg1+stagedmg3),((10*Elvl(myHero)+10+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(5*Elvl(myHero)+20)/100)*stagedmg2) --stage1,3:Base. stage2:xSpeGetArmor(myHero).
			end
		elseif GetObjectName(myHero) == "Karma" then
			if spellname == "Q" then apdmg = math.max((45*Qlvl(myHero)+35+.6*GetBonusAP(myHero))*stagedmg1,(50*Rlvl(myHero)-25+.3*GetBonusAP(myHero))*stagedmg2,(100*Rlvl(myHero)-50+.6*GetBonusAP(myHero))*stagedmg3) --stage1:Initial. stage2:Bonus (R). stage3: Detonation (R)
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+10+.9*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Karthus" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+40+.6*GetBonusAP(myHero) --50% damage if it hits multiple units
			elseif spellname == "E" then apdmg = 20*Elvl(myHero)+10+.2*GetBonusAP(myHero) --xsec
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+100+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Kassadin" then
			if spellname == "Q" then apdmg = 25*Qlvl(myHero)+45+.7*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max((25*Wlvl(myHero)+15+.6*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(20+.1*GetBonusAP(myHero))*stagedmg2) Typedmg = dmg + 2 -- stage1-3:Active. stage2: Pasive.
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+55+.7*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max((20*Rlvl(myHero)+60+.02*GetMaxGetCurrentMana(myHero)(myHero))*(stagedmg1+stagedmg3),(10*Rlvl(myHero)+30+.01*GetMaxGetCurrentMana(myHero)(myHero))*stagedmg2) --stage1-3:Initial. stage2:(GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional xstack (4 stack).
			end
		elseif GetObjectName(myHero) == "Katarina" then
			if spellname == "Q" then apdmg = math.max((25*Qlvl(myHero)+35+.45*GetBonusAP(myHero))*stagedmg1,(15*Qlvl(myHero)+.15*GetBonusAP(myHero))*stagedmg2,(40*Qlvl(myHero)+35+.6*GetBonusAP(myHero))*stagedmg3) --stage1:Dagger, Each subsequent hit deals 10% less damage. stage2:On-hit. stage3: Max damage
			elseif spellname == "W" then apdmg = 35*Wlvl(myHero)+5+.25*GetBonusAP(myHero)+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+10+.25*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(20*Rlvl(myHero)+15+.25*GetBonusAP(myHero)+.375*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(20*Rlvl(myHero)+15+.25*GetBonusAP(myHero)+.375*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*10*stagedmg3) --xdagger (champion can be hit by a maximum of 10 daggers (2 sec)). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Kayle" then
			if spellname == "Q" then apdmg = 50*Qlvl(myHero)+10+.6*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 10*Elvl(myHero)+10+.25*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit (bonus)
			end
		elseif GetObjectName(myHero) == "Kennen" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+35+.75*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max((30*Wlvl(myHero)+35+.55*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(.1*Wlvl(myHero)+.3)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))*stagedmg2) Typedmg = dmg + 1+stagedmg2 --stage1:Active. stage2:On-hit. stage3: stage1
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+45+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(65*Rlvl(myHero)+15+.4*GetBonusAP(myHero),(65*Rlvl(myHero)+15+.4*GetBonusAP(myHero))*3*stagedmg3) --xbolt (max 3 bolts). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Khazix" then
			if spellname == "P" then apdmg = math.max(5*GetLevel(myHero)+10,10*GetLevel(myHero)-5,15*GetLevel(myHero)-55)-math.max(0,5*(GetLevel(myHero)-13))+.5*GetBonusAP(myHero) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "Q" then addmg = math.max((25*Qlvl(myHero)+45+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(25*Qlvl(myHero)+45+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.3*stagedmg2,((25*Qlvl(myHero)+45+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.3+10*GetLevel(myHero)+1.04*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg3) --stage1:Normal. stage2:to Isolated. stage3:Evolved to Isolated.
			elseif spellname == "W" then addmg = 30*Wlvl(myHero)+50+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then addmg = 35*Elvl(myHero)+30+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "KogMaw" then
			if spellname == "P" then dmg = dmg + 100+25*GetLevel(myHero)
			elseif spellname == "Q" then apdmg = 50*Qlvl(myHero)+30+.5*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = (Wlvl(myHero)+1+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+10+.7*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 80*Rlvl(myHero)+80+.3*GetBonusAP(myHero)+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Leblanc" then
			if spellname == "Q" then apdmg = math.max(25*Qlvl(myHero)+30+.4*GetBonusAP(myHero),(25*Qlvl(myHero)+30+.4*GetBonusAP(myHero))*2*stagedmg3) --Initial or mGetArmor(myHero)k. stage3: Max damage
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+45+.6*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = math.max(25*Qlvl(myHero)+15+.5*GetBonusAP(myHero),(25*Qlvl(myHero)+15+.5*GetBonusAP(myHero))*2*stagedmg3) --Initial or Delayed. stage3: Max damage
			elseif spellname == "R" then apdmg = math.max((100*Rlvl(myHero)+.6*GetBonusAP(myHero))*stagedmg1,(150*Rlvl(myHero)+.9*GetBonusAP(myHero))*stagedmg2,(100*Rlvl(myHero)+.6*GetBonusAP(myHero))*stagedmg3) --stage1:Q Initial or mGetArmor(myHero)k. stage2:W. stage3:E Initial or Delayed
			end
		elseif GetObjectName(myHero) == "LeeSin" then
			if spellname == "Q" then addmg = math.max((30*Qlvl(myHero)+20+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(30*Qlvl(myHero)+20+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+8*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg2,(60*Qlvl(myHero)+40+1.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+8*(GetMaxHP(target)-GetCurrentHP(target))/100)*stagedmg3) --stage1:Sonic Wave. stage2:Resonating Strike. stage3: Max damage
			elseif spellname == "E" then apdmg = 35*Qlvl(myHero)+25+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = 200*Rlvl(myHero)+2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Leona" then
			if spellname == "P" then apdmg = (-1.25)*(3*(-1)^GetLevel(myHero)-6*GetLevel(myHero)-7)
			elseif spellname == "Q" then apdmg = 30*Qlvl(myHero)+10+.3*GetBonusAP(myHero) Typedmg = dmg + 2 -- (bonus)
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+10+.4*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+20+.4*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lissandra" then
			if spellname == "Q" then apdmg = 30*Qlvl(myHero)+40+.65*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+30+.4*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+25+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lucian" then
			if spellname == "P" then addmg = (.3+.1*math.floor((GetLevel(myHero)-1)/6))*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = 30*Qlvl(myHero)+50+(15*Qlvl(myHero)+45)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))/100
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+20+.9*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 10*Rlvl(myHero)+30+.1*GetBonusAP(myHero)+.3*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --per shot
			end
		elseif GetObjectName(myHero) == "Lulu" then
			if spellname == "P" then apdmg = math.max(4*math.floor(GetLevel(myHero)/2+.5)-1+.15*GetBonusAP(myHero),(4*math.floor(GetLevel(myHero)/2+.5)-1+.15*GetBonusAP(myHero))*3*stagedmg3) --xbolt (3 bolts). stage: Max damage
			elseif spellname == "Q" then apdmg = 45*Qlvl(myHero)+35+.5*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+50+.4*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Lux" then
			if spellname == "P" then apdmg = 8*GetLevel(myHero)+10+.2*GetBonusAP(myHero)
			elseif spellname == "Q" then apdmg = 50*Qlvl(myHero)+10+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+15+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+200+.75*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Malphite" then
			if spellname == "Q" then apdmg = 50*Qlvl(myHero)+20+.6*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 15*Wlvl(myHero)+.1*GetBonusAP(myHero)+.1*GetArmor(myHero)
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+20+.2*GetBonusAP(myHero)+.3*GetArmor(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Malzahar" then
			if spellname == "P" then addmg = 20+5*GetLevel(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --Voidling xhit
			elseif spellname == "Q" then apdmg = 55*Qlvl(myHero)+25+.8*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = (Wlvl(myHero)+3+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 --xsec (5 sec)
			elseif spellname == "E" then apdmg = 60*Elvl(myHero)+20+.8*GetBonusAP(myHero) --over 4 sec
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+100+1.3*GetBonusAP(myHero) --over 2.5 sec
			end
		elseif GetObjectName(myHero) == "Maokai" then
			if spellname == "Q" then apdmg = 45*Qlvl(myHero)+25+.4*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = (1*Wlvl(myHero)+8+.03*GetBonusAP(myHero))*GetMaxHP(target)/100
			elseif spellname == "E" then apdmg = math.max((20*Elvl(myHero)+20+.4*GetBonusAP(myHero))*stagedmg1,(40*Elvl(myHero)+40+.6*GetBonusAP(myHero))*stagedmg2,(60*Elvl(myHero)+60+GetBonusAP(myHero))*stagedmg3) --stage1:Impact. stage2:Explosion. stage3: Max damage
			elseif spellname == "R" then apdmg = 50*Rlvl(myHero)+50+.5*GetBonusAP(myHero)+(50*Rlvl(myHero)+150)*stagedmg3 -- +2 per point of damage absorbed (max 100/150/200). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "MasterYi" then
			if spellname == "P" then addmg = .5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = math.max((35*Qlvl(myHero)-10+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2,(35*Qlvl(myHero)-10+1.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg3) --stage1:normal. stage2:critically strike (bonus). stage3: critically strike
			elseif spellname == "E" then dmg = dmg + 5*Elvl(myHero)+5+((5/2)*Elvl(myHero)+15/2)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))/100
			end
		elseif GetObjectName(myHero) == "MissFortune" then
			if spellname == "Q" then addmg = math.max((15*Qlvl(myHero)+5+.85*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.35*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(30*Qlvl(myHero)+10+(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero))*stagedmg2) --stage1-stage3:1st target. stage2:2nd target.
			elseif spellname == "W" then apdmg = .06*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xstack (max 5+Rlvl(myHero) stacks) (bonus)
			elseif spellname == "E" then apdmg = 55*Elvl(myHero)+35+.8*GetBonusAP(myHero) --over 3 seconds
			elseif spellname == "R" then addmg = math.max(25*Rlvl(myHero)+25,50*Rlvl(myHero)-25)+.2*GetBonusAP(myHero) --xwave (8 waves) GetBonusAP(myHero)plies a stack of Impure Shots
			end
		elseif GetObjectName(myHero) == "Mordekaiser" then
			if spellname == "Q" then apdmg = math.max(30*Qlvl(myHero)+50+.4*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(30*Qlvl(myHero)+50+.4*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.65*stagedmg3) --If the target is alone, the ability deals 65% more damage. stage3: Max damage
			elseif spellname == "W" then apdmg = math.max(12*Wlvl(myHero)+8+.15*GetBonusAP(myHero),(12*Wlvl(myHero)+8+.15*GetBonusAP(myHero))*6*stagedmg3) --xsec (6 sec). stage3: Max damage
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+25+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = (5*Rlvl(myHero)+19+.04*GetBonusAP(myHero))*GetMaxHP(target)/100 --half Initial and half over 10 sec
			end
		elseif GetObjectName(myHero) == "Morgana" then
			if spellname == "Q" then apdmg = 55*Qlvl(myHero)+25+.6*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = (8*Wlvl(myHero)+.11*GetBonusAP(myHero))*(1+.5*(1-GetCurrentHP(target)/GetMaxHP(target))) --x 1/2 sec (5 sec)
			elseif spellname == "R" then apdmg = math.max(75*Rlvl(myHero)+75+.7*GetBonusAP(myHero),(75*Rlvl(myHero)+75+.7*GetBonusAP(myHero))*2*stagedmg3) --x2 If the target stay in range for the full duration. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Nami" then
			if spellname == "Q" then apdmg = 55*Qlvl(myHero)+20+.5*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+30+.5*GetBonusAP(myHero) --The percentage power of later bounces now scales. Each bounce gains 0.75% more power per 10 GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 15*Elvl(myHero)+10+.2*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit (max 3 hits)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.6*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nasus" then
			if spellname == "Q" then addmg = 20*Qlvl(myHero)+10 Typedmg = dmg + 2 --+3 per enemy killed by Siphoning Strike (bonus)
			elseif spellname == "E" then apdmg = math.max((80*Elvl(myHero)+30+1.2*GetBonusAP(myHero))/5,(80*Elvl(myHero)+30+1.2*GetBonusAP(myHero))*stagedmg3) --xsec (5 sec). stage3: Max damage
			elseif spellname == "R" then apdmg = (Rlvl(myHero)+2+.01*GetBonusAP(myHero))*GetMaxHP(target)/100 --xsec (15 sec)
			end
		elseif GetObjectName(myHero) == "Nautilus" then
			if spellname == "P" then addmg = 2+6*GetLevel(myHero) Typedmg = dmg + 2
			elseif spellname == "Q" then apdmg = 45*Qlvl(myHero)+15+.75*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 10*Wlvl(myHero)+20+.4*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit (bonus)
			elseif spellname == "E" then apdmg = math.max(40*Elvl(myHero)+20+.5*GetBonusAP(myHero),(40*Elvl(myHero)+20+.5*GetBonusAP(myHero))*2*stagedmg3) --xexplosions , 50% less damage from (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional explosions. stage3: Max damage
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+75+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nidalee" then
			if spellname == "Q" then apdmg = 25*Qlvl(myHero)+25+.4*GetBonusAP(myHero) --deals 300% damage the further away the target is, gains damage from 525 units until 1300 units
			elseif spellname == "QM" then apdmg = (math.max(4,30*Rlvl(myHero)-40,40*Rlvl(myHero)-70)+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.36*GetBonusAP(myHero))*(1+1.5*(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target)) --Deals 33% increased damage against Hunted
			elseif spellname == "W" then apdmg = 40*Qlvl(myHero)+.4*GetBonusAP(myHero) -- over 4 sec
			elseif spellname == "WM" then apdmg = 50*Rlvl(myHero)+.3*GetBonusAP(myHero)
			elseif spellname == "EM" then apdmg = 60*Rlvl(myHero)+10+.45*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Nocturne" then
			if spellname == "P" then addmg = .2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "Q" then addmg = 45*Qlvl(myHero)+15+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+40+GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 100*Rlvl(myHero)+50+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Nunu" then
			if spellname == "Q" then apdmg = .01*GetMaxHP(myHero) --xhit Ornery Monster Tails passive
			elseif spellname == "E" then apdmg = 37.5*Elvl(myHero)+47.5+GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 250*Rlvl(myHero)+375+2.5*GetBonusAP(myHero) --After 3 sec
			end
		elseif GetObjectName(myHero) == "Olaf" then
			if spellname == "Q" then addmg = 45*Qlvl(myHero)+25+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then dmg = dmg + 45*Elvl(myHero)+25+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Orianna" then
			if spellname == "P" then apdmg = 8*math.floor((GetLevel(myHero)+2)/3)+2+0.15*GetBonusAP(myHero) --xhit subsequent attack deals 20% more dmg up to 40%
			elseif spellname == "Q" then apdmg = 30*Qlvl(myHero)+30+.5*GetBonusAP(myHero) --10% less damage for each subsequent target hit down to a minimum of 40%
			elseif spellname == "W" then apdmg = 45*Wlvl(myHero)+25+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+30+.3*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 75*Rlvl(myHero)+75+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Pantheon" then
			if spellname == "Q" then addmg = (40*Qlvl(myHero)+25+1.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(1+math.floor((GetMaxHP(target)-GetCurrentHP(target))/(GetMaxHP(target)*0.85)))
			elseif spellname == "W" then apdmg = 25*Wlvl(myHero)+25+GetBonusAP(myHero)
			elseif spellname == "E" then addmg = math.max(20*Elvl(myHero)+6+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(20*Elvl(myHero)+6+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*3*stagedmg3) --xStrike (3 strikes). stage3: Max damage
			elseif spellname == "R" then apdmg = 300*Rlvl(myHero)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Poppy" then
			if spellname == "Q" then apdmg = 25*Qlvl(myHero)+.6*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero))+math.min(0.08*GetMaxHP(target),75*Qlvl(myHero)) --(GetBonusAP(myHero)plies on hit?) Typedmg = dmg + 3
			elseif spellname == "E" then apdmg = math.max((25*Elvl(myHero)+25+.4*GetBonusAP(myHero))*stagedmg1,(50*Elvl(myHero)+25+.4*GetBonusAP(myHero))*stagedmg2,(75*Elvl(myHero)+50+.8*GetBonusAP(myHero))*stagedmg3) --stage1:initial. stage2:Collision. stage3: Max damage
			elseif spellname == "R" then dmg = dmg + 10*Rlvl(myHero)+10 --% Increased Damage
			end
		elseif GetObjectName(myHero) == "Quinn" then
			if spellname == "P" then addmg = math.max(10*GetLevel(myHero)+15,15*GetLevel(myHero)-55)+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "Q" then addmg = 40*Qlvl(myHero)+30+.65*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero)
			elseif spellname == "E" then addmg = 30*Elvl(myHero)+10+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = (50*Rlvl(myHero)+70+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(2-GetCurrentHP(target)/GetMaxHP(target))
			end
		elseif GetObjectName(myHero) == "Rammus" then
			if spellname == "Q" then apdmg = 50*Qlvl(myHero)+50+GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 10*Wlvl(myHero)+5+.1*GetArmor(myHero) --x each attack suffered
			elseif spellname == "R" then apdmg = 65*Rlvl(myHero)+.3*GetBonusAP(myHero) --xsec (8 sec)
			end
		elseif GetObjectName(myHero) == "RekSai" then
			if spellname == "Q" then addmg = 10*Qlvl(myHero)+5+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "QM" then apdmg = 30*Qlvl(myHero)+30+.7*GetBonusAP(myHero)
			elseif spellname == "WM" then addmg = 40*Wlvl(myHero)+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then addmg = (.1*Elvl(myHero)+.7)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))*(1+GetCurrentMana(myHero)/GetMaxGetCurrentMana(myHero)(myHero))*(1-math.floor(GetCurrentMana(myHero)/GetMaxGetCurrentMana(myHero)(myHero))) dmg = dmg + (.1*Elvl(myHero)+.7)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))*2*math.floor(GetCurrentMana(myHero)/GetMaxGetCurrentMana(myHero)(myHero))
			end
		elseif GetObjectName(myHero) == "Renekton" then
			if spellname == "Q" then addmg = math.max(30*Qlvl(myHero)+30+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(30*Qlvl(myHero)+30+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3) --stage1:with 50 fury deals 50% (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional damage. stage3: Max damage
			elseif spellname == "W" then addmg = math.max(20*Wlvl(myHero)-10+1.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(20*Wlvl(myHero)-10+1.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3) --stage1:with 50 fury deals 50% (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional damage. stage3: Max damage -- on hit x2 or x3
			elseif spellname == "E" then addmg = math.max(30*Elvl(myHero)+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(30*Elvl(myHero)+.9*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3) --stage1:Slice or Dice , with 50 fury Dice deals 50% (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional damage. stage3: Max damage of Dice
			elseif spellname == "R" then apdmg = math.max(30*Rlvl(myHero),60*Rlvl(myHero)-60)+.1*GetBonusAP(myHero) --xsec (15 sec)
			end
		elseif GetObjectName(myHero) == "Rengar" then
			if spellname == "Q" then addmg = math.max((30*Qlvl(myHero)+(.05*Qlvl(myHero)-.05)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(math.min(15*GetLevel(myHero)+15,10*GetLevel(myHero)+60)+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg2+stagedmg3)) Typedmg = dmg + 2 --stage1:Savagery. stage2-stage3:Empowered Savagery.
			elseif spellname == "W" then apdmg = math.max((30*Wlvl(myHero)+20+.8*GetBonusAP(myHero))*stagedmg1,(math.min(15*GetLevel(myHero)+25,math.max(145,10*GetLevel(myHero)+60))+.8*GetBonusAP(myHero))*(stagedmg2+stagedmg3)) --stage1:Battle RoGetArmor(myHero). stage2-stage3:Empowered Battle RoGetArmor(myHero).
			elseif spellname == "E" then addmg = math.max((50*Elvl(myHero)+.7*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(math.min(25*GetLevel(myHero)+25,10*GetLevel(myHero)+160)+.7*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg2+stagedmg3))
			end
		elseif GetObjectName(myHero) == "Riven" then
			if spellname == "P" then addmg = 5+math.max(5*math.floor((GetLevel(myHero)+2)/3)+10,10*math.floor((GetLevel(myHero)+2)/3)-15)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))/100 --xchGetArmor(myHero)ge
			elseif spellname == "Q" then addmg = 20*Qlvl(myHero)-10+(.05*Qlvl(myHero)+.35)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xstrike (3 strikes)
			elseif spellname == "W" then addmg = 30*Wlvl(myHero)+20+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = math.min((40*Rlvl(myHero)+40+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(1+(100-25)/100*8/3),120*Rlvl(myHero)+120+1.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))
			end
		elseif GetObjectName(myHero) == "Rumble" then
			if spellname == "P" then apdmg = 20+5*GetLevel(myHero)+.25*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit
			elseif spellname == "Q" then apdmg = math.max(20*Qlvl(myHero)+5+.33*GetBonusAP(myHero),(20*Qlvl(myHero)+5+.33*GetBonusAP(myHero))*3*stagedmg3) --xsec (3 sec) , with 50 heat deals 150% damage. stage3: Max damage , with 50 heat deals 150% damage
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+20+.4*GetBonusAP(myHero) --xshoot (2 shoots) , with 50 heat deals 150% damage
			elseif spellname == "R" then apdmg = math.max(55*Rlvl(myHero)+75+.3*GetBonusAP(myHero),(55*Rlvl(myHero)+75+.3*GetBonusAP(myHero))*5*stagedmg3) --stage1: xsec (5 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Ryze" then
			if spellname == "Q" then apdmg = 35*Qlvl(myHero)+25+.55*GetBonusAP(myHero)+(0.05*Qlvl(myHero)+0.15)*GetMaxGetCurrentMana(myHero)(myHero)
			elseif spellname == "W" then apdmg = 20*Wlvl(myHero)+60+.4*GetBonusAP(myHero)+.025*GetMaxGetCurrentMana(myHero)(myHero)
			elseif spellname == "E" then apdmg = math.max(16*Elvl(myHero)+34+.3*GetBonusAP(myHero)+.02*GetMaxGetCurrentMana(myHero)(myHero),(16*Elvl(myHero)+34+.3*GetBonusAP(myHero)+.02*GetMaxGetCurrentMana(myHero)(myHero))*4*stagedmg3) --xbounce. stage3: Max damage = initial damage + 6 * 1/2 initial damage = 4 initial damage
			end
		elseif GetObjectName(myHero) == "Sejuani" then
			if spellname == "Q" then apdmg = 45*Qlvl(myHero)+35+.4*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max(((.5*Wlvl(myHero)+3.5+.03*GetBonusAP(myHero))*GetMaxHP(target)/100)*stagedmg1,(30*Wlvl(myHero)+10+.6*GetBonusAP(myHero)+(.5*Wlvl(myHero)+3.5)*GetMaxHP(myHero)/100)/4*(stagedmg2+stagedmg3)) Typedmg = dmg + 1+stagedmg1 --stage1: bonus. stage2-3: xsec (4 sec)
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+30+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.8*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Shaco" then
			if spellname == "Q" then addmg = (.2*Qlvl(myHero)+.2)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --(bonus)
			elseif spellname == "W" then apdmg = 15*Wlvl(myHero)+20+.2*GetBonusAP(myHero) --xhit
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+10+GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+150+GetBonusAP(myHero) --The clone deals 75% of Shaco's damage
			end
		elseif GetObjectName(myHero) == "Shen" then
			if spellname == "P" then apdmg = 4+4*GetLevel(myHero)+(GetMaxHP(myHero)-(428+85*GetLevel(myHero)))*.1 Typedmg = dmg + 2 --(bonus)
			elseif spellname == "Q" then apdmg = 40*Qlvl(myHero)+20+.6*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+15+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Shyvana" then
			if spellname == "Q" then addmg = (.05*Qlvl(myHero)+.75)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --Second Strike
			elseif spellname == "W" then apdmg = 15*Wlvl(myHero)+5+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xsec (3 sec + 4 extra sec)
			elseif spellname == "E" then apdmg = math.max((40*Elvl(myHero)+20+.6*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(2.5*GetMaxHP(target)/100)*stagedmg2) --stage1-3:Active. stage2:Each autoattack that hits debuffed targets
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Singed" then
			if spellname == "Q" then apdmg = 12*Qlvl(myHero)+10+.3*GetBonusAP(myHero) --xsec
			elseif spellname == "E" then apdmg = 15*Elvl(myHero)+35+.75*GetBonusAP(myHero)+((0.5*Elvl(myHero)+5.5)*GetMaxHP(target)/100)
			end
		elseif GetObjectName(myHero) == "Sion" then
			if spellname == "P" then addmg = 10*GetMaxHP(target)/100 Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = 20*Qlvl(myHero)+.65*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --Minimum, x3 over 2 sec
			elseif spellname == "W" then apdmg = 25*Wlvl(myHero)+15+.4*GetBonusAP(myHero)+(Wlvl(myHero)+9)*GetMaxHP(target)/100
			elseif spellname == "E" then apdmg = math.max(35*Wlvl(myHero)+35+.4*GetBonusAP(myHero),(35*Wlvl(myHero)+35+.4*GetBonusAP(myHero))*1.3*stagedmg3) --Minimum. stage3: x1.3 if hits a minion
			elseif spellname == "R" then addmg = 150*Qlvl(myHero)+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --Minimum, x2 over 1.75 sec
			end
		elseif GetObjectName(myHero) == "Sivir" then
			if spellname == "Q" then addmg = 20*Qlvl(myHero)+5+.5*GetBonusAP(myHero)+(.1*Qlvl(myHero)+.6)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --x2 , 15% reduced damage to each subsequent target
			elseif spellname == "W" then addmg = (.05*Wlvl(myHero)+.45)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))*stagedmg2 Typedmg = dmg + 2 --stage1:bonus to attack target. stage2: Bounce Damage
			end
		elseif GetObjectName(myHero) == "Skarner" then
			if spellname == "P" then apdmg = 5*GetLevel(myHero)+15 Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = (10*Qlvl(myHero)+10+.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg1+stagedmg3) Qapdmg = (10*Qlvl(myHero)+10+.2*GetBonusAP(myHero))*(stagedmg2+stagedmg3) --stage1:basic. stage2: chGetArmor(myHero)ge bonus. stage2: total
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+5+.4*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max((100*Rlvl(myHero)+100+GetBonusAP(myHero))*(stagedmg1+stagedmg3),(25*Rlvl(myHero)+25)*stagedmg2)--stage1-3:basic. stage2: per stacks of Crystal Venom.
			end
		elseif GetObjectName(myHero) == "Sona" then
			if spellname == "P" then apdmg = (math.max(7*GetLevel(myHero)+6,8*GetLevel(myHero)+3,9*GetLevel(myHero)-2,10*GetLevel(myHero)-8,15*GetLevel(myHero)-78)+.2*GetBonusAP(myHero))*(1+stagedmg1) Typedmg = dmg + 2 --stage1: Staccato. stage2:Diminuendo or Tempo
			elseif spellname == "Q" then apdmg = math.max((40*Qlvl(myHero)+.5*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(10*Qlvl(myHero)+30+.2*GetBonusAP(myHero)+10*Rlvl(myHero))*stagedmg2) Typedmg = dmg + 1+stagedmg2 --stage1-3: Active. stage2:On-hit
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Soraka" then
			if spellname == "Q" then apdmg = math.max(40*Qlvl(myHero)+30+.35*GetBonusAP(myHero),(40*Qlvl(myHero)+30+.35*GetBonusAP(myHero))*1.5*stagedmg3) --stage1: border. stage3: center
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+30+.4*GetBonusAP(myHero) --Initial or SecondGetArmor(myHero)y
			end
		elseif GetObjectName(myHero) == "Swain" then
			if spellname == "Q" then apdmg = math.max(15*Qlvl(myHero)+10+.3*GetBonusAP(myHero),(15*Qlvl(myHero)+10+.3*GetBonusAP(myHero))*3*stagedmg3) --xsec (3 sec). stage3: Max damage
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+40+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = (40*Elvl(myHero)+35+.8*GetBonusAP(myHero))*(stagedmg1+stagedmg3) dmg = dmg + (3*Elvl(myHero)+5)*stagedmg2 --stage1-3:Active.  stage2:% Extra Damage.
			elseif spellname == "R" then apdmg = 20*Rlvl(myHero)+30+.2*GetBonusAP(myHero) --xstrike (1 strike x sec)
			end
		elseif GetObjectName(myHero) == "Syndra" then
			if spellname == "Q" then apdmg = math.max(45*Qlvl(myHero)+5+.6*GetBonusAP(myHero),(45*Qlvl(myHero)+5+.6*GetBonusAP(myHero))*1.15*(Qlvl(myHero)-4))
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+40+.7*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+25+.4*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(45*Rlvl(myHero)+45+.2*GetBonusAP(myHero),(45*Rlvl(myHero)+45+.2*GetBonusAP(myHero))*7*stagedmg3) --stage1:xSphere (Minimum 3). stage3:7 Spheres
			end
		elseif GetObjectName(myHero) == "Talon" then
			if spellname == "Q" then addmg = 40*Qlvl(myHero)+1.3*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then addmg = math.max(25*Wlvl(myHero)+5+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(25*Wlvl(myHero)+5+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --x2 if the target is hit twice. stage3: Max damage
			elseif spellname == "E" then dmg = dmg + 3*Elvl(myHero) --% Damage Amplification
			elseif spellname == "R" then addmg = math.max(50*Rlvl(myHero)+70+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(50*Rlvl(myHero)+70+.75*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --x2 if the target is hit twice. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Taric" then
			if spellname == "P" then apdmg = .2*GetArmor(myHero) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then apdmg = 40*Wlvl(myHero)+.2*GetArmor(myHero)
			elseif spellname == "E" then apdmg = math.max(30*Elvl(myHero)+10+.2*GetBonusAP(myHero),(30*Elvl(myHero)+10+.2*GetBonusAP(myHero))*2*stagedmg3) --min (lower damage the fGetArmor(myHero)ther the target is) up to 200%. stage3: Max damage
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Teemo" then
			if spellname == "Q" then apdmg = 45*Qlvl(myHero)+35+.8*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = math.max((10*Elvl(myHero)+.3*GetBonusAP(myHero))*stagedmg1,(6*Elvl(myHero)+.1*GetBonusAP(myHero))*stagedmg2,(34*Elvl(myHero)+.7*GetBonusAP(myHero))*stagedmg3) --stage1:Hit (bonus). stage2:poison xsec (4 sec). stage3:Hit+poison for 4 sec
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+75+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Thresh" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+40+.5*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = math.max((40*Elvl(myHero)+25+.4*GetBonusAP(myHero))*(stagedmg1+stagedmg3),((.3*Qlvl(myHero)+.5)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2) --stage1:Active. stage2:Passive (+ Souls). stage3:stage1
			elseif spellname == "R" then apdmg = 150*Rlvl(myHero)+100+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Tristana" then
			if spellname == "W" then apdmg = 25*Wlvl(myHero)+55+.5*GetBonusAP(myHero), (25*Wlvl(myHero)+55+.5*GetBonusAP(myHero))*2 --max damage, jumping onto max stack explosive chGetArmor(myHero)ge
			elseif spellname == "E" then addmg = 10*Elvl(myHero)+50+(.15*Elvl(myHero)+.35)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero),(10*Elvl(myHero)+50+(.15*Elvl(myHero)+.35)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.5*GetBonusAP(myHero))*2.2*stagedmg3	--stage3: Max damage/4 auto attack stacks
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+200+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Trundle" then
			if spellname == "Q" then addmg = 20*Qlvl(myHero)+(5*Qlvl(myHero)+95)*(GetBonusdmg(myHero)+GetBaseDamage(myHero))/100 Typedmg = dmg + 2 --(bonus)
			elseif spellname == "R" then apdmg = (2*Rlvl(myHero)+18+.02*GetBonusAP(myHero))*GetMaxHP(target)/100 --over 4 sec
			end
		elseif GetObjectName(myHero) == "Tryndamere" then
			if spellname == "E" then addmg = 30*Elvl(myHero)+40+GetBonusAP(myHero)+1.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "TwistedFate" then
			if spellname == "Q" then apdmg = 50*Qlvl(myHero)+10+.65*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max((7.5*Wlvl(myHero)+7.5+.5*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(15*Wlvl(myHero)+15+.5*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2,(20*Wlvl(myHero)+20+.5*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg3) --stage1:Gold CGetArmor(myHero)d.  stage2:Red CGetArmor(myHero)d.  stage3:Blue CGetArmor(myHero)d
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+30+.5*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Twitch" then
			if spellname == "P" then dmg = dmg + math.floor((GetLevel(myHero)+3)/4 + 1) --xstack xsec (6 stack 6 sec)
			elseif spellname == "E" then addmg = math.max((5*Elvl(myHero)+10+.2*GetBonusAP(myHero)+.25*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(15*Elvl(myHero)+5)*stagedmg2,((5*Elvl(myHero)+10+.2*GetBonusAP(myHero)+.25*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*6+15*Elvl(myHero)+5)*stagedmg3) --stage1:xstack (6 stack). stage2:Base. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Udyr" then
			if spellname == "Q" then addmg = math.max((50*Qlvl(myHero)-20+(.1*Qlvl(myHero)+1.1)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*(stagedmg2+stagedmg3),(.15*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1) Typedmg = dmg + 2 --stage1:persistent effect. stage2:(bonus). stage3:stage2
			elseif spellname == "W" then Typedmg = dmg + 2
			elseif spellname == "E" then Typedmg = dmg + 2
			elseif spellname == "R" then apdmg = math.max((40*Rlvl(myHero)+.45*GetBonusAP(myHero))*stagedmg2,(10*Rlvl(myHero)+5+.25*GetBonusAP(myHero))*stagedmg3) Typedmg = dmg + 2 --stage1:0. stage2:xThird Attack. stage3:x wave (5 waves)
			end
		elseif GetObjectName(myHero) == "Urgot" then
			if spellname == "Q" then addmg = 30*Qlvl(myHero)-20+.85*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then addmg = 55*Elvl(myHero)+20+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Varus" then
			if spellname == "Q" then addmg = math.max(.625*(55*Qlvl(myHero)-40+1.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))),(55*Qlvl(myHero)-40+1.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg3) --stage1:min. stage3:max. reduced by 15% per enemy hit (minimum 33%)
			elseif spellname == "W" then apdmg = math.max((4*Wlvl(myHero)+6+.25*GetBonusAP(myHero))*stagedmg1,((.0075*Wlvl(myHero)+.0125+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)*stagedmg2,((.0075*Wlvl(myHero)+.0125+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)*3*stagedmg3) --stage1:xhit. stage2:xstack (3 stacks). stage3: 3 stacks
			elseif spellname == "E" then addmg = 35*Elvl(myHero)+30+.6*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Vayne" then
			if spellname == "Q" then addmg = (.05*Qlvl(myHero)+.25)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then dmg = 10*Wlvl(myHero)+10+((1*Wlvl(myHero)+3)*GetMaxHP(target)/100)
			elseif spellname == "E" then addmg = math.max(35*Elvl(myHero)+10+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(35*Elvl(myHero)+10+.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --x2 If they collide with terrain. stage3: Max damage
			elseif spellname == "R" then Typedmg = dmg + 2
			end
		elseif GetObjectName(myHero) == "Veigar" then
			if spellname == "Q" then apdmg = 45*Qlvl(myHero)+35+.6*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 50*Wlvl(myHero)+70+GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+125+GetBonusAP(myHero)+.8*GetBonusGetBonusAP(myHero)(target)
			end
		elseif GetObjectName(myHero) == "Velkoz" then
			if spellname == "P" then dmg = 10*GetLevel(myHero)+25
			elseif spellname == "Q" then apdmg = 40*Qlvl(myHero)+40+.6*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max(20*Wlvl(myHero)+10+.25*GetBonusAP(myHero),(20*Wlvl(myHero)+10+.25*GetBonusAP(myHero))*1.5*stagedmg2) --stage1-3:Initial. stage2:Detonation.
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+40+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 20*Rlvl(myHero)+30+.6*GetBonusAP(myHero) --every 0.25 sec (2.5 sec), Organic Deconstruction every 0.5 sec
			end
		elseif GetObjectName(myHero) == "Vi" then
			if spellname == "Q" then addmg = math.max(25*Qlvl(myHero)+25+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(25*Qlvl(myHero)+25+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*2*stagedmg3) --x2 If chGetArmor(myHero)ging up to 1.5 seconds. stage3: Max damage
			elseif spellname == "W" then addmg = ((3/2)*Wlvl(myHero)+5/2+(1/35)*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*GetCurrentHP(target)/100
			elseif spellname == "E" then addmg = 15*Elvl(myHero)-10+.15*(GetBonusdmg(myHero)+GetBaseDamage(myHero))+.7*GetBonusAP(myHero) Typedmg = dmg + 2 --(Bonus)
			elseif spellname == "R" then addmg = 150*Rlvl(myHero)+1.4*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --deals 75% damage to enemies in her way
			end
		elseif GetObjectName(myHero) == "Viktor" then
			if spellname == "Q" then apdmg = math.max((20*Qlvl(myHero)+20+.2*GetBonusAP(myHero))*(stagedmg1+stagedmg3),(math.max(5*GetLevel(myHero)+15,10*GetLevel(myHero)-30,20*GetLevel(myHero)-150)+.5*GetBonusAP(myHero)+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg2) --stage1-3:Initial. stage2:basic attack.
			elseif spellname == "E" then apdmg = math.max(45*Elvl(myHero)+25+.7*GetBonusAP(myHero),(45*Elvl(myHero)+25+.7*GetBonusAP(myHero))*1.4*stagedmg3) --Initial or Aftershock. stage3: Max damage
			elseif spellname == "R" then apdmg = math.max((100*Rlvl(myHero)+50+.55*GetBonusAP(myHero))*stagedmg1,(15*Rlvl(myHero)+.1*GetBonusAP(myHero))*stagedmg2,(100*Rlvl(myHero)+50+.55*GetBonusAP(myHero)+(15*Rlvl(myHero)+.1*GetBonusAP(myHero))*7)*stagedmg3) --stage1:initial. stage2: xsec (7 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Vladimir" then
			if spellname == "Q" then apdmg = 35*Qlvl(myHero)+55+.6*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 55*Wlvl(myHero)+25+(GetMaxHP(myHero)-(400+85*GetLevel(myHero)))*.15 --(2 sec)
			elseif spellname == "E" then apdmg = math.max((25*Elvl(myHero)+35+.45*GetBonusAP(myHero))*stagedmg1,((25*Elvl(myHero)+35)*0.25)*stagedmg2,((25*Elvl(myHero)+35)*2+.45*GetBonusAP(myHero))*stagedmg3) --stage1:25% more base damage x stack. stage2:+x stack. stage3: Max damage
			elseif spellname == "R" then apdmg = 100*Rlvl(myHero)+50+.7*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Volibear" then
			if spellname == "Q" then addmg = 30*Qlvl(myHero) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then addmg = ((Wlvl(myHero)-1)*45+80+(GetMaxHP(myHero)-(440+GetLevel(myHero)*86))*.15)*(1+(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target))
			elseif spellname == "E" then apdmg = 45*Elvl(myHero)+15+.6*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 80*Rlvl(myHero)-5+.3*GetBonusAP(myHero) Typedmg = dmg + 2 --xhit
			end
		elseif GetObjectName(myHero) == "Warwick" then
			if spellname == "P" then apdmg = math.max(.5*GetLevel(myHero)+2.5,(.5*GetLevel(myHero)+2.5)*3*stagedmg3) --xstack (3 stacks). stage3: Max damage
			elseif spellname == "Q" then apdmg = 50*Qlvl(myHero)+25+GetBonusAP(myHero)+((2*Qlvl(myHero)+6)*GetMaxHP(target)/100)
			elseif spellname == "R" then apdmg = math.max((100*Rlvl(myHero)+50+2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))/5,(100*Rlvl(myHero)+50+2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg3) --xstrike (5 strikes) , without counting on-hit effects. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "MonkeyKing" then
			if spellname == "Q" then addmg = 30*Qlvl(myHero)+.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then apdmg = 45*Wlvl(myHero)+25+.6*GetBonusAP(myHero)
			elseif spellname == "E" then addmg = 45*Elvl(myHero)+15+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = math.max(90*Rlvl(myHero)-70+1.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)),(90*Rlvl(myHero)-70+1.1*(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*4*stagedmg3) --xsec (4 sec). stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Xerath" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+40+.75*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = math.max((30*Qlvl(myHero)+30+.6*GetBonusAP(myHero))*1.5*(stagedmg1+stagedmg3),(30*Qlvl(myHero)+30+.6*GetBonusAP(myHero))*stagedmg2) --stage1,3: Center. stage2: Border
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+50+.45*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 55*Rlvl(myHero)+135+.43*GetBonusAP(myHero) --xcast (3 cast)
			end
		elseif GetObjectName(myHero) == "XinZhao" then
			if spellname == "Q" then addmg = 15*Qlvl(myHero)+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus x hit)
			elseif spellname == "E" then apdmg = 40*Elvl(myHero)+30+.6*GetBonusAP(myHero)
			elseif spellname == "R" then addmg = 100*Rlvl(myHero)-25+(GetBonusdmg(myHero)+GetBaseDamage(myHero))+15*GetCurrentHP(target)/100
			end
		elseif GetObjectName(myHero) == "Yasuo" then
			if spellname == "Q" then addmg = 20*Qlvl(myHero) Typedmg = dmg + 2 -- can critically strike, dealing X% (GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "E" then apdmg = 20*Elvl(myHero)+50+.6*GetBonusAP(myHero) --Each cast increases the next dash's base damage by 25%, up to 50% bonus damage
			elseif spellname == "R" then addmg = 100*Rlvl(myHero)+100+1.5*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Yorick" then
			if spellname == "P" then addmg = .35*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) --xhit of ghouls
			elseif spellname == "Q" then addmg = 30*Qlvl(myHero)+.2*(GetBonusdmg(myHero)+GetBaseDamage(myHero)) Typedmg = dmg + 2 --(bonus)
			elseif spellname == "W" then apdmg = 35*Wlvl(myHero)+25+GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 30*Elvl(myHero)+25+(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			end
		elseif GetObjectName(myHero) == "Zac" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+30+.5*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 15*Wlvl(myHero)+25+((1*Wlvl(myHero)+3+.02*GetBonusAP(myHero))*GetMaxHP(target)/100)
			elseif spellname == "E" then apdmg = 50*Elvl(myHero)+30+.7*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = math.max(70*Rlvl(myHero)+70+.4*GetBonusAP(myHero),(70*Rlvl(myHero)+70+.4*GetBonusAP(myHero))*2.5*stagedmg3) -- stage1:Enemies hit more than once take half damage. stage3: Max damage
			end
		elseif GetObjectName(myHero) == "Zed" then
			if spellname == "P" then apdmg = (6+2*(math.floor((GetLevel(myHero)-1)/6)))*GetMaxHP(target)/100 Typedmg = dmg + 2
			elseif spellname == "Q" then addmg = math.max((40*Qlvl(myHero)+35+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*stagedmg1,(40*Qlvl(myHero)+35+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*.6*stagedmg2,(40*Qlvl(myHero)+35+(GetBonusdmg(myHero)+GetBaseDamage(myHero)))*1.5*stagedmg3)  --stage1:multiple shurikens deal 50% damage. stage2:SecondGetArmor(myHero)y targets. stage3: Max damage
			elseif spellname == "E" then addmg = 30*Elvl(myHero)+30+.8*(GetBonusdmg(myHero)+GetBaseDamage(myHero))
			elseif spellname == "R" then addmg = (GetBonusdmg(myHero)+GetBaseDamage(myHero))*(stagedmg1+stagedmg3) dmg = dmg + (15*Rlvl(myHero)+5)*stagedmg2 --stage1-3:100% of Zed attack damage. stage2:% of damage dealt.
			end
		elseif GetObjectName(myHero) == "Ziggs" then
			if spellname == "P" then apdmg = math.max(4*GetLevel(myHero)+16,8*GetLevel(myHero)-8,12*GetLevel(myHero)-56)+(.2+.05*math.floor((GetLevel(myHero)+5)/6))*GetBonusAP(myHero) Typedmg = dmg + 2
			elseif spellname == "Q" then apdmg = 45*Qlvl(myHero)+30+.65*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 35*Wlvl(myHero)+35+.35*GetBonusAP(myHero)
			elseif spellname == "E" then apdmg = 25*Elvl(myHero)+15+.3*GetBonusAP(myHero) --xmine , 40% damage from (GetBonusdmg(myHero)+GetBaseDamage(myHero))ditional mines
			elseif spellname == "R" then apdmg = 125*Rlvl(myHero)+125+.9*GetBonusAP(myHero) --enemies away from the primGetArmor(myHero)y blast zone will take 80% damage
			end
		elseif GetObjectName(myHero) == "Zilean" then
			if spellname == "Q" then apdmg = 40*Qlvl(myHero)+35+.9*GetBonusAP(myHero)
			end
		elseif GetObjectName(myHero) == "Zyra" then
			if spellname == "P" then dmg = 80+20*GetLevel(myHero)
			elseif spellname == "Q" then apdmg = 35*Qlvl(myHero)+35+.65*GetBonusAP(myHero)
			elseif spellname == "W" then apdmg = 23+6.5*GetLevel(myHero)+.2*GetBonusAP(myHero) --xstrike Extra plants striking the same target deal 50% less damage
			elseif spellname == "E" then apdmg = 35*Elvl(myHero)+25+.5*GetBonusAP(myHero)
			elseif spellname == "R" then apdmg = 85*Rlvl(myHero)+95+.7*GetBonusAP(myHero)
			end
		end
		if apdmg > 0 then apdmg = CalcDamage(source, target, apdmg) end
		if addmg > 0 then addmg = CalcDamage(source, target, addmg) end
		local dmg = dmg
	end
end

function CalcDamage(source, target, addmg)
    local addmg = addmg or 0
    local GetArmor(myHero)morPen = math.floor(GetGetArmor(myHero)morPenFlat(source))
    local GetArmor(myHero)morPenPercent = math.floor(GetGetArmor(myHero)morPenPercent(source)*100)/100
    local GetArmor(myHero)mor = GetGetArmor(myHero)mor(target)*GetArmor(myHero)morPenPercent-GetArmor(myHero)morPen
    local GetArmor(myHero)morPercent = GetArmor(myHero)mor > 0 and math.floor(GetArmor(myHero)mor*100/(100+GetArmor(myHero)mor))/100 or math.ceil(GetArmor(myHero)mor*100/(100-GetArmor(myHero)mor))/100
    return (GotBuff(source,"exhausted")  > 0 and 0.4 or 1) * math.floor(addmg*(1-GetArmor(myHero)morPercent))
end

function CalcDamage(source, target, apdmg)
    local apdmg = apdmg or 0
    local MagicPen = math.floor(GetMagicPenFlat(source))
    local MagicPenPercent = math.floor(GetMagicPenPercent(source)*100)/100
    local MagicArmor = GetMagicResist(target)*MagicPenPercent-MagicPen
    local MagicArmorPercent = MagicArmor > 0 and math.floor(MagicArmor*100/(100+MagicArmor))/100 or math.ceil(MagicArmor*100/(100-MagicArmor))/100
    return (GotBuff(source,"exhausted")  > 0 and 0.4 or 1) * math.floor(APdmg*(1-MagicArmorPercent))
end
