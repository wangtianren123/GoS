if GetObjectName(myHero) ~= "Kalista" then return end

require('Deftlib')

local Epics = {"SRU_Baron", "SRU_Dragon", "TT_Spiderboss"}
local Mobs = {"SRU_Baron", "SRU_Dragon", "SRU_Red", "SRU_Blue", "SRU_Krug", "SRU_Murkwolf", "SRU_Razorbeak", "SRU_Gromp", "Sru_Crab", "TT_Spiderboss"}

local KalistaMenu = Menu("Kalista", "Kalista")
KalistaMenu:SubMenu("Combo", "Combo")
KalistaMenu.Combo:Boolean("Q", "Use Q", true)
KalistaMenu.Combo:Boolean("E", "E if reset + slow target", true)
KalistaMenu.Combo:Boolean("Items", "Use Items", true)
KalistaMenu.Combo:Slider("myHP", "if HP % <", 50, 0, 100, 1)
KalistaMenu.Combo:Slider("targetHP", "if Target HP % >", 20, 0, 100, 1)
KalistaMenu.Combo:Boolean("QSS", "Use QSS", true)
KalistaMenu.Combo:Slider("QSSHP", "if My Health % <", 75, 0, 100, 1)
KalistaMenu.Combo:Key("WallJump", "WallJump", string.byte("G"))
KalistaMenu.Combo:Key("SentinelBug", "Cast Sentinel Bug", string.byte("T"))

KalistaMenu:SubMenu("Harass", "Harass")
KalistaMenu.Harass:Boolean("Q", "Use Q", true)
KalistaMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

KalistaMenu:SubMenu("Ult", "Ult")
KalistaMenu.Ult:Boolean("AutoR", "Save Ally with R", true)
KalistaMenu.Ult:Slider("AutoRHP", "min Ally HP %", 5, 1, 100, 1)

KalistaMenu:SubMenu("Killsteal", "Killsteal")
KalistaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
KalistaMenu.Killsteal:Boolean("E", "Killsteal with E", true)

KalistaMenu:SubMenu("Misc", "Misc")
KalistaMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
KalistaMenu.Misc:Boolean("Autolvl", "Auto level", true)
KalistaMenu.Misc:List("Autolvltable", "Priority", 1, {"E-Q-W", "Q-E-W", "W-Q-E", "W-E-Q"})
KalistaMenu.Misc:Boolean("Edie", "Cast E before die", true)
KalistaMenu.Misc:Boolean("E", "E if Target Leave Range", true)
KalistaMenu.Misc:Slider("Elvl", "E if my level <", 12, 1, 18, 1)
KalistaMenu.Misc:Slider("minE", "min E Stacks", 7, 1, 20, 1)
KalistaMenu.Misc:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

KalistaMenu:SubMenu("Drawings", "Drawings")
KalistaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
KalistaMenu.Drawings:Boolean("E", "Draw E Range", true)
KalistaMenu.Drawings:Boolean("R", "Draw R Range", true)
KalistaMenu.Drawings:Boolean("Edmg", "Draw E% Dmg", true)

KalistaMenu:SubMenu("Farm", "Farm")
KalistaMenu.Farm:Boolean("ECanon", "Always E Big Minions", true)
KalistaMenu.Farm:Slider("Mana", "if Mana % >", 30, 0, 80, 1)
KalistaMenu.Farm:SubMenu("LaneClear", "LaneClear")
KalistaMenu.Farm.LaneClear:Slider("Farmkills", "E if X Can Be Killed", 2, 0, 10, 1)
KalistaMenu.Farm.LaneClear:Boolean("E", "E if reset + slow", true)
KalistaMenu.Farm:SubMenu("Jungle", "Jungle Clear")
KalistaMenu.Farm.Jungle:Boolean("firstmins", "Don't E jungle first 2 minutes", true)
KalistaMenu.Farm.Jungle:List("je", "Jungle Execute:", 3, {"OFF", "Epic Only", "Large & Epic Only", "Everything"})

GoS:DelayAction(function()
  for _,k in pairs(GoS:GetAllyHeroes()) do
    if GetObjectName(k) == "Blitzcrank" then
    KalistaMenu.Ult:Boolean("Balista", "Balista Combo", true)
    end
    if GetObjectName(k) == "Skarner" then
    KalistaMenu.Ult:Boolean("Skarlista", "Skarlista Combo", true)
    end
    if GetObjectName(k) == "TahmKench" then
    KalistaMenu.Ult:Boolean("Tahmlista", "Tahmlista Combo", true)
    end
  end
end, 1)



OnLoop(function(myHero)
 if IsDead(myHero) then return end
 
 local mousePos = GetMousePos()
    if IOW:Mode() == "Combo" then
	        
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1700,250,1150,50,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1150) and KalistaMenu.Combo.Q:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end

        for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
        
          local MinionPos = GetOrigin(minion)
          local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), MinionPos)
          if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1150) and KalistaMenu.Combo.Q:Value() and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) and isOnSegment and GoS:GetDistance(pointSegment,minion) < 50 then
          CastSkillShot(_Q, MinionPos.x, MinionPos.y, MinionPos.z)
          end
           
          if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and KalistaMenu.Combo.E:Value() and GoS:GetDistance(target) > GetRange(myHero)+GetHitBox(myHero)+(target and GetHitBox(target) or GetHitBox(myHero)) and GotBuff(target, "kalistaexpungemarker") > 0 and GetCurrentHP(minion) < Edmg(minion) then
          CastSpell(_E)
          end
  
        end
	
	if GetItemSlot(myHero,3140) > 0 and KalistaMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and KalistaMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
   end
	
   if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= KalistaMenu.Harass.Mana:Value() then
	
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1700,250,1150,50,true,true)
		
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 1150) and KalistaMenu.Harass.Q:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
		
        for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
           local MinionPos = GetOrigin(minion)
           local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), MinionPos)
           if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1150) and KalistaMenu.Harass.Q:Value() and GetCurrentHP(minion) < GoS:CalcDamage(myHero, minion, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) and isOnSegment and GoS:GetDistance(pointSegment,minion) < 50 then
           CastSkillShot(_Q, MinionPos.x, MinionPos.y, MinionPos.z)
           end
        end

    end
    
	if KalistaMenu.Misc.E:Value() then
	   for i,enemy in pairs(GoS:GetEnemyHeroes()) do
                if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Misc.Mana:Value() and GetLevel(myHero) <= KalistaMenu.Misc.Elvl:Value() then
		   if GotBuff(enemy, "kalistaexpungemarker") >= KalistaMenu.Misc.minE:Value() and GoS:ValidTarget(target, 1100) and GoS:GetDistance(enemy) >= 1000 then
		   CastSpell(_E)
		   end
		end
	   end
	end
	
	if KalistaMenu.Misc.Edie:Value() then 
	  if CanUseSpell(myHero, _E) and GetLevel(myHero) < 6 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 3 then
	  CastSpell(_E)
	  elseif CanUseSpell(myHero, _E) and GetLevel(myHero) > 5 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 5 then
	  CastSpell(_E)
	  end
	end
		
	if CanUseSpell(myHero,_W) == READY and KalistaMenu.Combo.SentinelBug:Value() then
	  if GoS:GetDistance(Vector(9882.892, -71.24, 4438.446)) < GoS:GetDistance(Vector(5087.77, -71.24, 10471.3808)) and GoS:GetDistance(Vector(9882.892, -71.24, 4438.446)) < 5200 then
          CastSkillShot(_W,9882.892, -71.24, 4438.446)	
          elseif GoS:GetDistance(Vector(5087.77, -71.24, 10471.3808)) < 5200 then
          CastSkillShot(_W,5087.77, -71.24, 10471.3808)
          end
	end
			
	if KalistaMenu.Ult.AutoR:Value() then 
	  for _, ally in pairs(GoS:GetAllyHeroes()) do
	  local soulboundhero = GotBuff(ally, "kalistacoopstrikeally") > 0
            for i,enemy in pairs(GoS:GetEnemyHeroes()) do 
	      if CanUseSpell(myHero,_R) == READY and soulboundhero and 100*GetCurrentHP(ally)/GetMaxHP(ally) <= KalistaMenu.Ult.AutoRHP:Value() and GoS:ValidTarget(ally, 1450) and GoS:GetDistance(ally, enemy) <= 1000 then
              CastSpell(_R)
	      PrintChat("Rescuing low health "..GetObjectName(ally).."")
	      end
	    end
	  end
	end
	
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	
           local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1700,250,1150,50,true,true)
	
	if IOW:Mode() == "Combo" then
	   if GetItemSlot(myHero,3153) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > KalistaMenu.Combo.targetHP:Value() then
           CastTargetSpell(enemy, GetItemSlot(myHero,3153))
           end

           if GetItemSlot(myHero,3144) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < KalistaMenu.Combo.myHP:Value() and 100*GetCurrentHP(enemy)/GetMaxHP(enemy) > KalistaMenu.Combo.targetHP:Value() then
           CastTargetSpell(enemy, GetItemSlot(myHero,3144))
           end

           if GetItemSlot(myHero,3142) > 0 and KalistaMenu.Combo.Items:Value() and GoS:ValidTarget(enemy, 600) then
           CastTargetSpell(myHero, GetItemSlot(myHero,3142))
           end
		   
        end
        
	   if Ignite and KalistaMenu.Misc.AutoIgnite:Value() then
             if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
             CastTargetSpell(enemy, Ignite)
             end
	   end
	   
           if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(enemy, 1000) and KalistaMenu.Killsteal.E:Value() and GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)/8 < Edmg(enemy) then
	   CastSpell(_E)
	   elseif CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(enemy, 1150) and KalistaMenu.Killsteal.Q:Value() and QPred.HitChance == 1 and GetCurrentHP(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then  
           CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
           elseif CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1150) and KalistaMenu.Killsteal.Q:Value() and GetCurrentHP(enemy) < GoS:CalcDamage(myHero, enemy, 60*GetCastLevel(myHero,_Q) - 50 + GetBaseDamage(myHero)) then
             for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
               local MinionPos = GetOrigin(minion)
               local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(enemy), MinionPos)
               if isOnSegment and GoS:GetDistance(pointSegment,minion) < 50 then
               CastSkillShot(_Q, MinionPos.x, MinionPos.y, MinionPos.z)
               end
             end
           end
	   
	   if KalistaMenu.Drawings.Edmg:Value() then
	     local targetPos = GetOrigin(enemy)
             local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
	     if Edmg(enemy) > GetCurrentHP(enemy) then
	     DrawText("100%",20,drawPos.x,drawPos.y,0xffffffff)
	     elseif Edmg(enemy) > 0 then
             DrawText(math.floor(Edmg(enemy)/GetCurrentHP(enemy)*100).."%",20,drawPos.x,drawPos.y,0xffffffff)
             end
	   end
	   
    end
	
	for _,k in pairs(GoS:GetAllyHeroes()) do
           if GetObjectName(k) == "Blitzcrank" then
		for i,enemy in pairs(GoS:GetEnemyHeroes()) do
  	          if GotBuff(k, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 2450) and KalistaMenu.Ult.Balista:Value() and GetCurrentHP(enemy) > 300 and GetCurrentHP(myHero) > 400 and GoS:GetDistance(k, enemy) > 400 and GoS:GetDistance(enemy) > 400 and GoS:GetDistance(enemy) > GoS:GetDistance(k, enemy)+100 and GotBuff(enemy, "rocketgrab2") > 0 then
                  CastSpell(_R)
                  end
                end
	    end
	
            if GetObjectName(k) == "Skarner" then
	        for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		  if GotBuff(k, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 1750) and KalistaMenu.Ult.Skarlista:Value() and GoS:GetDistance(enemy) > 400 and GetCurrentHP(enemy) > 300 and GetCurrentHP(myHero) > 400 and GotBuff(enemy, "skarnerimpale") > 0 then
                  CastSpell(_R)
                  end
                end
            end
			
	    if GetObjectName(k) == "TahmKench" then
		for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	          if GotBuff(k, "kalistacoopstrikeally") > 0 and GoS:ValidTarget(enemy, 1400) and KalistaMenu.Ult.Tahmlista:Value() and GoS:GetDistance(enemy) > 400 and GetCurrentHP(enemy) > 300 and GetCurrentHP(myHero) > 400 and GotBuff(enemy, "tahmkenchwdevoured") > 0 then
                  CastSpell(_R)
                  end
                end
            end
	end	
	
    local killableminions = 0
    for _,unit in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
   
      if Edmg(unit) > 0 and Edmg(unit) > GetCurrentHP(unit) and (GetObjectName(unit) == "Siege" or GetObjectName(unit) == "super") and GoS:ValidTarget(unit, 1000) and KalistaMenu.Farm.ECanon:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Farm.Mana:Value() then 
      CastSpell(_E)
      end

      if Edmg(unit) > 0 and Edmg(unit) > GetCurrentHP(unit) and GoS:ValidTarget(unit, 1000) then 
      killableminions = killableminions + 1
      end

      if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > KalistaMenu.Farm.Mana:Value() then
      	 local target = GetCurrentTarget()
      	 
         if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and KalistaMenu.Farm.LaneClear.E:Value() and GotBuff(target, "kalistaexpungemarker") > 0 and GetCurrentHP(unit) < Edmg(unit) then
         CastSpell(_E)
         end
 
         if killableminions > KalistaMenu.Farm.LaneClear.Farmkills:Value() then
         CastSpell(_E)
	 end
      end
	
    end
    
for _,spot in pairs(WallSpots) do
  if KalistaMenu.Combo.WallJump:Value() then 
  
    if GoS:GetDistance(spot) <= 7000 and GoS:GetDistance(spot, mousePos) > 125 then                
    DrawCircle(spot.x,spot.y,spot.z,80,2,100,ARGB(255, 255, 255, 0))
    end
    
    if GoS:GetDistance(spot) <= 7000 and GoS:GetDistance(spot, mousePos) <= 125 then 
    DrawCircle(spot.x,spot.y,spot.z,80,2,100,ARGB(255, 0, 255, 0))
    end
    
    if GoS:GetDistance(spot, mousePos) <= 125 and GoS:GetDistance(spot) > 22 then
    MoveToXYZ(spot.x, spot.y, spot.z)
    end
    
    if GoS:GetDistance(spot) <= 22 then
    CastSkillShot(_Q, (Vector(spot)+(Vector((Vector(spot.x2, spot.y2, spot.z2)))-Vector(spot)):normalized()*100).x+110, (Vector(spot)+(Vector((Vector(spot.x2, spot.y2, spot.z2)))- Vector(spot)):normalized()* 100).y+110, (Vector(spot)+ (Vector((Vector(spot.x2, spot.y2, spot.z2)))-Vector(spot)):normalized()*100).z+110)
    GoS:DelayAction(function() MoveToXYZ(Vector(Vector(spot.x2, spot.y2, spot.z2)).x, Vector(Vector(spot.x2, spot.y2, spot.z2)).y, Vector(Vector(spot.x2, spot.y2, spot.z2)).z) end, 5)
    end
  end
end
	
for _,unit in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
   
    if GoS:ValidTarget(unit, 1000) and CanUseSpell(myHero, _E) == READY and KalistaMenu.Farm.Jungle.je:Value() ~= 1 then
      if KalistaMenu.Farm.Jungle.je:Value() == 2 then
        for i,Epic in pairs(Epics) do
          if GetObjectName(unit) == Epic and GetCurrentHP(unit) < Edmg(unit) then  
          CastSpell(_E)
          end
        end
      end 
      
      if KalistaMenu.Farm.Jungle.je:Value() == 3 then
        for i,Mob in pairs(Mobs) do
          if GetObjectName(unit) == Mob and GetCurrentHP(unit) < Edmg(unit) then  
          CastSpell(_E)
          end
        end
      end 
      
      if KalistaMenu.Farm.Jungle.je:Value() == 4 then
        if GetCurrentHP(unit) < Edmg(unit) then  
        CastSpell(_E)
        end
      end
      
    end
   
        if Gos:ValidTarget(unit, 2000) and KalistaMenu.Drawings.Edmg:Value() then
	local mobPos = GetOrigin(unit)
        local drawPos = WorldToScreen(1,mobPos.x,mobPos.y,mobPos.z)
          if Edmg(unit) > GetCurrentHP(unit) then
	  DrawText("100%",20,drawPos.x,drawPos.y,0xffffffff)
	  elseif Edmg(unit) > 0 then
          DrawText(math.floor(Edmg(unit)/GetCurrentHP(unit)*100).."%",20,drawPos.x,drawPos.y,0xffffffff)
          end
        end
end

if KalistaMenu.Misc.Autolvl:Value() then  
      if KalistaMenu.Misc.Autolvltable:Value() == 1 then leveltable = {_E, _W, _Q, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
      elseif KalistaMenu.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
      elseif KalistaMenu.Misc.Autolvltable:Value() == 3 then leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
      elseif KalistaMenu.Misc.Autolvltable:Value() == 4 then leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
      end
LevelSpell(leveltable[GetLevel(myHero)]) 
end

if KalistaMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1150,1,128,0xff00ff00) end
if KalistaMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1000,1,128,0xff00ff00) end
if KalistaMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1450,1,128,0xff00ff00) end
end)

OnProcessSpell(function(unit, spell)
if unit and unit == myHero and spell then
  if spell.name:lower():find("kalistapspellcast") then
  PrintChat("You are now pledged to "..GetObjectName(spell.target).."")
  end
end
end)

function CalcDamage(source, target, addmg)
    local ADDmg = addmg or 0
    local ArmorPen = GetObjectType(source) == Obj_AI_Minion and 0 or math.floor(GetArmorPenFlat(source))
    local ArmorPenPercent = GetObjectType(source) == Obj_AI_Minion and 1 or math.floor(GetArmorPenPercent(source)*100)/100
    local Armor = GetArmor(target)*ArmorPenPercent-ArmorPen
    local ArmorPercent = (GetObjectType(source) == Obj_AI_Minion and Armor < 0) and 0 or Armor > 0 and math.floor(Armor*100/(100+Armor))/100 or math.ceil(Armor*100/(100-Armor))/100
    return (GotBuff(target, "ferocioushowl") > 0 and 0.3 or GotBuff(target, "meditate") > 0 and 0.55-0.05*GetCastLevel(target,_W) or GotBuff(target, "galioidolofdurand") > 0 and 0.5 or GotBuff(source,"exhausted")  > 0 and 0.6 or GotBuff(target, "garenw") > 0 and 0.7 or GotBuff(target, "braumshieldbuff") > 0 and 0.725-0.025*GetCastLevel(target, _E) or GotBuff(target, "maokaidrain3defense") > 0 and 0.8 or GotBuff(target, "katarinaereduction") > 0 and 0.85 or GotBuff(target, "gragaswself") > 0 and 0.92-0.02*GetCastLevel(target, _W) or GotBuff(target, "vladimirhemoplaguedebuff") > 0 and 1.12 or 1) * math.floor(ADDmg*(1-ArmorPercent))
end

function Edmg(unit)
  dmg = {10,14,19,25,32}
  scaling = {0.2,0.225,0.25,0.275,0.3}
  
  local Stacks = GetBuffData(unit, "kalistaexpungemarker")
  local dmg = CalcDamage(myHero, unit, Stacks.Count > 0 and (10 + 10 * GetCastLevel(myHero,_E) + 0.6 * (GetBaseDamage(myHero) + GetBonusDmg(myHero)) + (Stacks.Count - 1) * (dmg[GetCastLevel(myHero,_E)] + scaling[GetCastLevel(myHero,_E)] * (GetBaseDamage(myHero) + GetBonusDmg(myHero))) or 0))

  return dmg
end
