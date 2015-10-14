OnLoop(function

		x = mousePos.x
                y = mousePos.y
		z = mousePos.z
		dx = x - player.x
		dz = z - player.z
		rad1 = math.atan2(dz, dx)
		dx1 = range*math.cos(rad1)
		dz1 = range*math.sin(rad1)
		x1 = x - dx1
		z1 = z - dz1
		if math.sqrt(dx*dx + dz*dz) < 510 then
	        Cast(SumonnerFlash, x, y, z)
		else
	        MoveToXYZ(x, y, z)
		end

end)
