if GetObjectName(myHero) ~= "Singed" then return end

SingedMenu = Menu("Singed", "Singed")
SingedMenu:Key("Q", "Q Exploit", string.byte("T"))

OnLoop(function(myHero)
local mousePos = GetMousePos()
if SingedMenu.Q:Value() then
CastSpell(_Q)
MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
end
end)
