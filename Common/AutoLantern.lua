local lantern = nil

OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "ThreshLantern" then
	lantern = Object
	end
end)

OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "ThreshLantern" then
	lantern = nil
	end
end)

OnTick(function(myHero)
if lantern and GoS:GetDistance(lantern) then
AttackUnit(lantern)
end
end)
