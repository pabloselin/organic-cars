require ("player")

function love.load()

	smallFont = love.graphics.newFont(30)
	mediumFont = love.graphics.newFont(45)
	bigFont = love.graphics.newFont(70)
end

function love.update(dt)
	playerMove(dt)
end

function love.draw()
	playerDraw()
end
