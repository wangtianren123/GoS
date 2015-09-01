require('Dlib')

local root = menu.addItem(SubMenu.new("Lag Exploit"))
local lag = root.addItem(MenuBool.new("Enabled",true))

local wards = {3340, 3350, 3361, 3154, 2045, 2049, 2050, 2044, 2043}

OnLoop(function(myHero)
  for _, ward in pairs(wards) do
      if GetItemSlot(myHero, ward) > 0 and lag.get.Value() then
		CastSkillShot(GetItemSlot(myHero,ward), 409.8733, 182.8395, 419.0513)
		CastSkillShot(GetItemSlot(myHero,ward), 1638.32, 52.83813, 13022.88)
		CastSkillShot(GetItemSlot(myHero,ward), 14292.57, 171.9777, 14376.82)
		CastSkillShot(GetItemSlot(myHero,ward), 13019.75, 51.94983, 1913.098)
	  end
  end
end)
	
