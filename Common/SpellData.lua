return {
  ["Aatrox"] = {
		[_Q]  = { Name = "AatroxQ", ProjectileName = "AatroxQ.troy", Range = 650, Speed = 2000, Delay = 600, Width = 250, collision = false, type = "circular", IsDangerous = true}
		[_E]  = { Name = "AatroxE", ProjectileName = "AatroxBladeofTorment_mis.troy" , Range = 1075, Speed = 1250, Delay = 250, Width = 35, collision = false, type = "linear", IsDangerous = false}
	        [_R]  = { Name = "AatroxR", Range = 300} -- TODO : recheck radius
	}
  ["Ahri"] = {
		[_Q]  = { Name = "AhriOrbofDeception", ProjectileName = "Ahri_Orb_mis.troy", Range = 1000, Speed = 2500, Delay = 250, Width = 100, collision = false, type = "linear", IsDangerous = false}
 	        [_Q2] = { Name = "AhriOrbofDeceptionherpityderp", ProjectileName = "Ahri_Orb_mis_02.troy", Range = 1000, Speed = 900, Delay = 250, Width = 100, collision = false, type = "linear", IsDangerous = false}
		[_W]  = { Name = "AhriFoxFire", Range = 700},
		[_E]  = { Name = "AhriSeduce", ProjectileName = "Ahri_Charm_mis.troy", Range = 1000, Speed = 1550, Delay = 250,  Width = 60, collision = true, type = "linear", IsDangerous = true},
		[_R]  = { Name = "AhriTumble", Range = 550}
	}
}

Spellbook = [GetObjectName(GetMyHero())]

function Cast(spell, target, speed, delay, range, width, coll)
      speed = speed or Spellbook.Speed
      delay = delay or Spellbook.Delay
      range = range or Spellbook.Range
      width = width or Spellbook.Width
      coll = coll or Spellbook.collision
      local Predicted = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), speed, delay, range, width, coll, true)
      if Predicted.HitChance > 0 then
        CastSkillShot(spell, Predicted.PredPos.x, Predicted.PredPos.y, Predicted.PredPos.z)
      end
end

-- Damage Lib soon(tm)
