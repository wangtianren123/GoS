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
