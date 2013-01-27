

player = {}
player.x = 10
player.y = 10
player.speed = 150

player.image = love.graphics.newImage("player.gif")

function playerDraw()
	love.graphics.draw(player.image, player.x, player.y)
end	

function playerMove(v)
	if love.love.keyboard.isDown("right")
		player.x = player.x + player.speed * v
	end
	if love.love.keyboard.isDown("left")
		player.x = player.x - player.speed * v
	end
	if love.love.keyboard.isDown("up")
		player.y = player.y - player.speed * v
	end
	if love.love.keyboard.isDown("down")
		player.y = player.y + player.speed * v
	end
end