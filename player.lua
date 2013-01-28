

player = {}
player.x = 10
player.y = 10
player.speed = 150

player.image = love.graphics.newImage("player.gif")

function playerDraw()
	love.graphics.draw(player.image, player.x, player.y)
end	

function playerMove(v)
	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed * v
	end
	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed * v
	end
	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed * v
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed * v
	end
end