require ("particles")
require ("world")
require ("car")
require ("globals")

function love.load()
	loadParticles()
	loadWorld()
	loadCar()
end

function love.update(dt)
	-- Updates the world
	world:update(dt)
	--Update the particles
	systems[current]:update(dt)
	--updates the car
	carUpdate(dt)
end

function love.draw()
	-- Draws the ground.
	love.graphics.polygon("line", groundShape:getPoints())
	love.graphics.polygon("line", floorShape:getPoints())
	-- Draw the car.
	love.graphics.draw(car,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)

	-- Draw text.
	love.graphics.print(text, 5, 25)
	love.graphics.print(grav, 5, 40)

	--Particle Draw
	love.graphics.setColorMode("modulate")
	love.graphics.setBlendMode("additive")
	love.graphics.draw(systems[current], 0, 0)
end

function love.keypressed(k)
	carKeysPressed(k)
end
