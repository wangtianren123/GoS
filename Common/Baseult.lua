require('Dlib')

local version = 2
local UP=Updater.new("D3ftsu/GoS/master/Common/Baseult.lua", "Common\\Baseult", version)
if UP.newVersion() then UP.update() end

--------------- Thanks ilovesona for this ------------------------
DelayAction(function ()
        for _, imenu in pairs(menuTable) do
                local submenu = menu.addItem(SubMenu.new(imenu.name))
                for _,subImenu in pairs(imenu) do
                        if subImenu.type == SCRIPT_PARAM_ONOFF then
                                local ggeasy = submenu.addItem(MenuBool.new(subImenu.t, subImenu.value))
                                OnLoop(function(myHero) subImenu.value = ggeasy.getValue() end)
                        elseif subImenu.type == SCRIPT_PARAM_KEYDOWN then
                                local ggeasy = submenu.addItem(MenuKeyBind.new(subImenu.t, subImenu.key))
                                OnLoop(function(myHero) subImenu.key = ggeasy.getValue(true) end)
                        elseif subImenu.type == SCRIPT_PARAM_INFO then
                                submenu.addItem(MenuSeparator.new(subImenu.t))
                        end
                end
        end
        _G.DrawMenu = function ( ... )  end
end, 1000)

local enemyBasePos, delay, missileSpeed, damage, recallPos = nil, 0, 0, nil, nil
local root = menu.addItem(SubMenu.new("Baseult"))
local BaseUlt = root.addItem(MenuBool.new("Enabled",true))
myHero = GetMyHero()
mapID = GetMapID()

if mapID == SUMMONERS_RIFT and GetTeam(myHero) == 100 then
enemyBasePos = Vector(14340, 171, 14390)
elseif mapID == SUMMONERS_RIFT and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(400, 200, 400)
end

if mapID == CRYSTAL_SCAR and GetTeam(myHero) == 100 then
enemyBasePos = Vector(13321, -37, 4163)
elseif mapID == CRYSTAL_SCAR and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(527, -35, 4163)
end

if mapID == TWISTED_TREELINE and GetTeam(myHero) == 100 then
enemyBasePos = Vector(14320, 151, 7235)
elseif mapID == TWISTED_TREELINE and GetTeam(myHero) == 200 then 
enemyBasePos = Vector(1060, 150, 7297)
end

if GetObjectName(myHero) == "Ashe" then
	delay = 250
	missileSpeed = 1600
	damage = function(target) return CalcDamage(myHero, target, 0, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero)) end
elseif GetObjectName(myHero) == "Draven" then
	delay = 400
	missileSpeed = 2000
	damage = function(target) return CalcDamage(myHero, target, 75 + 100*GetCastLevel(myHero,_R) + 1.1*GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Ezreal" then
	delay = 1000
	missileSpeed = 2000
	damage = function(target) return CalcDamage(myHero, target, 0, 200 + 150*GetCastLevel(myHero,_R) + .9*GetBonusAP(myHero)+GetBonusDmg(myHero)) end
elseif GetObjectName(myHero) == "Jinx" then
	delay = 600
    missileSpeed = (GetDistance(enemyBasePos) / (1 + (GetDistance(enemyBasePos)-1500)/2500)) -- thanks Noddy
	damage = function(target) return CalcDamage(myHero, target, (GetMaxHP(target)-GetCurrentHP(target))*(0.2+0.05*GetCastLevel(myHero, _R)) + 150 + 100*GetCastLevel(myHero,_R) + GetBonusDmg(myHero)) end
end

OnProcessRecall(function(Object,recallProc)
	if CanUseSpell(myHero, _R) == READY and BaseUlt.getValue() and GetTeam(Object) ~= GetTeam(myHero) then
		if damage(Object) > GetCurrentHP(Object) then
			local timeToRecall = recallProc.totalTime
			local distance = GetDistance(enemyBasePos)
			local timeToHit = delay + (distance * 1000 / missileSpeed)
			if timeToRecall > timeToHit and not (recallProc.isStart == false and recallProc.isFinish == false) then
				recallPos = Vector(Object)
				PrintChat("BaseUlt on "..GetObjectName(Object), 2, 0xffff0000)
				DelayAction(
					function() 
						if recallPos == Vector(Object) then
							CastSkillShot(_R, enemyBasePos.x, enemyBasePos.y, enemyBasePos.z)
							recallPos = nil
						end
					end, 
					timeToRecall-timeToHit
				)
			end
		end
	end
end)

notification("Baseult Reborn by Deftsu loaded.", 10000)
