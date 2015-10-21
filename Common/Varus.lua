-- Q range : 925/1625 : 700 in 2 seconds = 350 per second = 0.350 per tick, gg much logic such wow

if GetObjectName(myHero) ~= "Varus" then return end

local VarusMenu = Menu("Varus", "Varus")
VarusMenu:SubMenu("Combo", "Combo")
VarusMenu.Combo:Boolean("Q", "Use Q", true)
VarusMenu.Combo:Boolean("E", "Use E", true)
VarusMenu.Combo:Boolean("R", "Use R", true)

VarusMenu:SubMenu("Harass", "Harass")
VarusMenu.Harass:Boolean("Q", "Use Q", true)
VarusMenu.Harass:Boolean("E", "Use E", true)
VarusMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

VarusMenu:SubMenu("Killsteal", "Killsteal")
VarusMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
VarusMenu.Killsteal:Boolean("E", "Killsteal with E", true)

VarusMenu:SubMenu("Misc", "Misc")
VarusMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
VarusMenu.Misc:Boolean("Autolvl", "Auto level", true)
VarusMenu.Misc:List("Autolvltable", "Priority", 1, {"Q-W-E", "Q-E-W"})

VarusMenu:SubMenu("Drawings", "Drawings")
VarusMenu.Drawings:Boolean("Qmin", "Draw Q Min Range", true)
VarusMenu.Drawings:Boolean("Qmax", "Draw Q Max Range", true)
VarusMenu.Drawings:Boolean("E", "Draw E Range", true)
VarusMenu.Drawings:Boolean("R", "Draw R Range", true)

OnDraw(function(myHero)
if VarusMenu.Drawings.Qmin:Value() then DrawCircle(GoS:myHeroPos(),925,1,0,0xff00ff00) end
if VarusMenu.Drawings.Qmax:Value() then DrawCircle(GoS:myHeroPos(),1625,1,0,0xff00ff00) end
if VarusMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos(),925,1,0,0xff00ff00) end
if VarusMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos(),1075,1,0,0xff00ff00) end
end)

OnTick(function(myHero)

  if IOW:Mode() == "Combo" then
	
    local target = GetCurrentTarget()
    local mousePos = GetMousePos()

    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1625) and VarusMenu.Combo.Q:Value() then
      CastSkillShot(_Q, mousePos.x, mousePos.y, mousePos.z)
      Qon = true
      GoS:DelayAction(function() Qon = false end, 4000)
    elseif Qon then
      GoS:DelayAction(function()
      local Qrange = 925 + 0.35*GetTickCount()
      local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1900,250,Qrange,70,false,true)
        if QPred.HitChance == 1 then
        CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
        Qon = false
        end
      end, 10)
    end 
  end
end)
