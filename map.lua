

function map_collide()
	if player.x + player.image:getWidth() < 0 then
		player.x = 0
	end
	if player.x + player.image:getWidth() > screen.width then
		player.x =screen.width
	end
	if player.y + player.image:getHeight() < 0 then
		player.y = 0
	end
	if player.y + player.image:getHeight() > screen.heigth then
		player.y = screen.heigth
	end
end