require ("camera")
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
	camera.x =  body:getX() - love.graphics.getWidth()/2 
	--camera.y =  body:getY() - love.graphics.getHeight()/2
	-- Updates the world
	world:update(dt)
	--Update the particles
	systems[current]:update(dt)
	--updates the car
	carUpdate(dt)	
end

function love.draw()
	camera:set()
	love.graphics.setColorMode('replace')
	love.graphics.draw(bg, -3000, 0)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(255,1,1)
	love.graphics.polygon("fill", groundShape:getPoints())
	love.graphics.polygon("fill", floorShape:getPoints())
	love.graphics.polygon("fill", platShape:getPoints())
	love.graphics.polygon("fill", wallLeftShape:getPoints())
	love.graphics.polygon("fill", wallRightShape:getPoints())

	love.graphics.setColor(0, 0, 0)
	-- Draw the car.
	if direction then
		if not invertG then
			love.graphics.draw(car,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)
			text = " IZQUIERDA" 
		else
			love.graphics.draw(car2,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)
			text = " IZQUIERDA"
		end 
	else
		if not invertG then
			love.graphics.draw(car2,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)
			text = " IZQUIERDA" 
		else
			love.graphics.draw(car,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)
			text = " IZQUIERDA"
		end 
	end

	-- Draw text.
	love.graphics.print(text, 5, 25)
	love.graphics.print(grav, 5, 40)

	--Particle Draw
	--love.graphics.setColorMode("modulate")
	--love.graphics.setBlendMode("additive")
	love.graphics.draw(systems[current], 0, 0)

	camera:unset()
end

function love.keypressed(k)
	carKeysPressed(k)
end
