-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- main.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()
----------------------LOCAL VARIABLES--------------------------------------
--physic engine
local fizyka = require("physics")
fizyka.start()
fizyka.setGravity(0,0)

--layers

local backGroup
local mainGroup
local uiGroup

--PowerUp Values
local currentPowerUp
local powerUpType
local timerPowerUp

--Player Values
local dot
local bulletsTable = {}
local bulletTimer

--boolean variables
local died = false
local isShield = false

--GameManager elements
--local czestosc = 2000
local szybkosc1 = 300
local szybkosc2 = 400
local gameLoopTimer
--local clockLoop

----------HUD elements------------
--live
local lives = 100
local livesText

--timer
local timerText
local startTime = 0
local timerOn

--money
local money =0
local moneyText
local specialCoin = 0
local specialCoinText

--pause
local pauseButton
------------------
-------------------------------------------------

---------------------------------------------------------------------------

--------------------LOCAL FUNCTIONS---------------------------------------

--------------Player---------------
local function createPlayer() 
  --ustawienie allign
display.setDefault( "anchorX", 0 )
dot = display.newImageRect(mainGroup,"/sprites/player.png",100,100)
dot.x = display.contentCenterX
dot.y = display.contentCenterY + 365
--dot = display.newCircle( mainGroup, display.contentCenterX, display.contentCenterY + 400, 20 )
--dot:setFillColor( 0, 0, 1 )
--dot.color = "blue"
dot.anchorX = 0.5
fizyka.addBody(dot,{radius = 20, isSensor = true})
dot.myName = "player"
end
-- 

local function MovePlayer( event )
  dot.x = dot.x + (event.xGravity*50)
  
  --screen bounds
  if dot.x > display.contentWidth - dot.contentWidth then
        dot.x = display.contentWidth - dot.contentWidth
    end
    if dot.x < dot.contentWidth then
        dot.x = dot.contentWidth
    end
  return true
end
--
local function playerColided()
  
  dot.isBodyActive = false
  dot.alpha = 1
  --dot:setFill
            dot.isBodyActive = true
            died = false
end
--
local function playerShoot( event )
  if (died == true) then
    if event.isShake then
    return false
    end
    elseif (died == false) then
  
  if event.isShake then
    print("SHOOT!")
    display.setDefault( "anchorX", 0 )
  --local playerBullet = display.newImageRect(mainGroup, display.contentCenterX, display.contentCenterY + 400, 15)
  local playerBullet = display.newImageRect(mainGroup,"/sprites/laserGreen05.png",9,37)
  fizyka.addBody(playerBullet,"dynamic", {isSensor = true})
  playerBullet.isBullet = true
  playerBullet.myName = "playerBullet"
  --playerBullet:setFillColor(0.7,0.3,1)
  playerBullet.x = dot.x
  playerBullet.y = dot.y
  playerBullet:toBack()
  
  transition.to(playerBullet, {y=0, time = 500,
    onComplete = function() display.remove(playerBullet); end
  })

    return true
  end
  end
  
end
  
--
-----------------------------------

--------------Bullets---------------
local function createBullets()
--local bullet = display.newCircle(mainGroup, math.random(display.contentWidth), -60, 10 )
local bullet = display.newImageRect(mainGroup,"/sprites/Saw.png",50,50)
--bullet:setFillColor( 1, 0, 0 )
--bullet.color = "red"
bullet.anchorX = 0.5
fizyka.addBody(bullet, "dynamic", {radius = 30})
bullet.myName = "bullet"
 bullet.x = math.random((bullet.contentWidth*5), (display.contentWidth - bullet.contentWidth*5))
  bullet.y = -60
  bullet:applyTorque( math.random( -6,6 ) )
  --setLinearVelocity: 
  --x = 0 - obiekt leci bez konta; y - szybkość
bullet:setLinearVelocity(0, math.random(szybkosc1,szybkosc2))
table.insert(bulletsTable, bullet)

end
--
local function createLaser()
  -- Draw a series of overlapping lines to represent the beam
	local beam1 = display.newLine(display.contentCenterX, 400, display.contentCenterX, display.contentCenterY )
	beam1.strokeWidth = 2 ; beam1:setStrokeColor( 1, 0.312, 0.157, 1 ) ; beam1.blendMode = "add" ; beam1:toBack(); fizyka.addBody(beam1, "dynamic",{isSensor=true})
	local beam2 = display.newLine(  display.contentCenterX, 400, display.contentCenterX, display.contentCenterY)
	beam2.strokeWidth = 4 ; beam2:setStrokeColor( 1, 0.312, 0.157, 0.706 ) ; beam2.blendMode = "add" ; beam2:toBack();fizyka.addBody(beam2, "dynamic",{isSensor=true})
	local beam3 = display.newLine(  display.contentCenterX, 400, display.contentCenterX, display.contentCenterY )
	beam3.strokeWidth = 6 ; beam3:setStrokeColor( 1, 0.196, 0.157, 0.392 ) ; beam3.blendMode = "add" ; beam3:toBack();fizyka.addBody(beam3, "dynamic",{isSensor=true})
  --transition.to({beam1,beam2,beam3},{})
  beam1:applyTorque(6)
end
--

-----------------------------------

--------------PowerUp---------------
--create health powerUp
local function createPowerUp(powerUp)
  local Power1 = { type="image", filename="sprites/gui/pill_red.png" }
local Power2= { type="image", filename="sprites/gui/Coin_03.png" }
local Power3= { type="image", filename="sprites/gui/powerupBlue_shield.png" }
  currentPowerUp = display.newRect(mainGroup,0,0 ,40,40)
    currentPowerUp.anchorX = 0.5
    fizyka.addBody(currentPowerUp,"static",{isSensor = true})
    currentPowerUp.x = math.random((currentPowerUp.width*5),(display.contentWidth-currentPowerUp.width*5))
  currentPowerUp.y = display.contentCenterY+400
    
  if (powerUp == 1) then
    currentPowerUp.fill = Power1
  --currentPowerUp:setFillColor(1,0.2,0)
  currentPowerUp.color = "lightRed"
  currentPowerUp.myName = "PowerH"
  print("created"..currentPowerUp.myName)

elseif (powerUp == 2) then
currentPowerUp.fill = Power2
  --currentPowerUp:setFillColor(0.6,0.9,0.2)
  currentPowerUp.color = "green"
  currentPowerUp.myName = "PowerM"
  print("created"..currentPowerUp.myName)
  
elseif (powerUp == 3) then
  currentPowerUp.fill = Power3
  --currentPowerUp:setFillColor(1,1,0)
  currentPowerUp.color = "yellow"
  currentPowerUp.myName = "PowerS"
  print("created"..currentPowerUp.myName)
end
 return currentPowerUp;

end
--
function updatePowerUpType()
	powerUpType = math.random(1,3)
  print("New power up type"..powerUpType)
end
--
local function removePowerUp()
  print("removePowerUp")
 display.remove(currentPowerUp)
end
--
local function delayRemovePowerUp()
  timer.performWithDelay(3000,removePowerUp)  
  print("removed"..currentPowerUp.myName)
  end
--
-----------------------------------

--------------GAME MANAGER---------------
--FPS 60
local function onFrame()
  frameUpdate = true
  
end
--
local function updateTime()
  startTime = startTime + 1
  local minutes = math.floor(startTime/60)
  local seconds = startTime%60
  local timeDisplay = string.format("%02d:%02d", minutes, seconds)
  timerText.text = timeDisplay
end
--
local function PowerUpFlow()
  updatePowerUpType()
  currentPowerUp = createPowerUp(powerUpType)
  delayRemovePowerUp()
  end
--
local function gameloop()

  createBullets()
  
  --create PowerH
  
  
  
  for i = #bulletsTable, 1, -1 do
        local thisBullet = bulletsTable[i]
 
        if ( thisBullet.x < -100 or
             thisBullet.x > display.contentWidth + 100 or
             thisBullet.y < -100 or
             thisBullet.y > display.contentHeight + 100 )
        then
            display.remove( thisBullet )
            table.remove( bulletsTable, i )
        end
    end
  end
--
--change difficult of bullet hell
local function stopLoop(loopTimer)
  timer.cancel(loopTimer)
  
end
--
local function BullethellAI()
  if ( startTime >= 10 ) then
stopLoop(gameLoopTimer)
gameLoopTimer = timer.performWithDelay(500,gameloop,0)
end
end
--
--BullethellAI()
--

--
--------COLLISION----
local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		--[[if ( ( obj1.myName == "" and obj2.myName == "asteroid" ) or
			 ( obj1.myName == "asteroid" and obj2.myName == "laser" ) )
		then
			-- Remove both the laser and asteroid
			display.remove( obj1 )
            display.remove( obj2 )

			for i = #asteroidsTable, 1, -1 do
				if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
					table.remove( asteroidsTable, i )
					break
				end
			end

			-- Increase score
			score = score + 100
			scoreText.text = "Score: " .. score--]]
      
      --bullet and playerBullet collision
      if ( ( obj1.myName == "bullet" and obj2.myName == "playerBullet" ) or
				 ( obj1.myName == "playerBullet" and obj2.myName == "bullet" ) )
		then
     display.remove(obj1)
     display.remove(obj2)
    
      for i = #bulletsTable, 1, -1 do
				if ( bulletsTable[i] == obj1 or bulletsTable[i] == obj2 ) then
					table.remove( bulletsTable, i )
					break
				end
			end
    end
      
      --PowerUp Health
      if ( ( obj1.myName == "player" and obj2.myName == "PowerH" ) or
				 ( obj1.myName == "PowerH" and obj2.myName == "player" ) )
		then
     removePowerUp()
    
      if (lives<=90) then
        lives = lives + 10
        livesText.text = "Lives: " .. lives
      else
        lives = 100
        livesText.text = "Lives: " .. lives
        end
      end
      
      --PowerUp Money
       if ( ( obj1.myName == "player" and obj2.myName == "PowerM" ) or
				 ( obj1.myName == "PowerM" and obj2.myName == "player" ) )
		then
     removePowerUp()
    
    money = money+10
    moneyText.text = "$"..money
    end
    
    --PowerUp Shield
       if ( ( obj1.myName == "player" and obj2.myName == "PowerS" ) or
				 ( obj1.myName == "PowerS" and obj2.myName == "player" ) )
		then
     removePowerUp()
     isShield = true
     dot:setFillColor(1,1,0)
     transition.to( dot, { time = 4000,
          onComplete = function()
            dot:setFillColor(0,0,1)
            isShield = false
            end
      } )
     
     
    end
    --colliding player with bullet
		if ( ( obj1.myName == "player" and obj2.myName == "bullet" ) or
				 ( obj1.myName == "bullet" and obj2.myName == "player" ) )
		then
      if (isShield == true) then
        
        elseif (isShield == false) then
			if ( died == false ) then
				died = true

				-- Update lives
        
				lives = lives - 20
				livesText.text = "Lives: " .. lives
				if ( lives <= 0 ) then
					display.remove( dot )
          died = true
				else
					--dot:setFillColor( 1, 0.6, 0.6 )
          dot.alpha = 0.7
					timer.performWithDelay( 2000, playerColided )
				end
			end
		end
    end
	end
  --
  
  
  
end
--
-----------------------------------
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
fizyka.pause()

-- Set up display groups
backGroup = display.newGroup()  -- Display group for the background image
sceneGroup:insert( backGroup )  -- Insert into the scene's view group
 
mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
sceneGroup:insert( mainGroup )  -- Insert into the scene's view group
 
uiGroup = display.newGroup()    -- Display group for UI objects like the score
sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

--add objects

local background = display.newImageRect(backGroup, "back1.jpg", 800, 1600)
background.x = display.contentCenterX
background.y = display.contentCenterY

createPlayer()

--create floor

local floor = display.newImageRect(mainGroup, "/sprites/floor.png", display.contentWidth, 90)
floor.x = 100
floor.y = display.contentHeight-90
floor.anchorY = 0
print(display.contentWidth)

--UI
--tworzenie timera
timerText = display.newText(uiGroup,"0:00 ", display.contentCenterX-70,100,native.systemFont, 72)
timerText:setFillColor(1,1,0)

--ui lives
livesText = display.newText(uiGroup,"Lives: " .. lives, 100,180,native.systemFont, 36)

--ui money
local monety = display.newImageRect(uiGroup,"/sprites/gui/Coin_03.png",48,48)
monety.x = display.actualContentWidth-40
monety.y = 50
specialCoinText = display.newText(uiGroup,":" .. specialCoin, display.actualContentWidth+10,50,native.systemFont, 36)
specialCoinText:setFillColor(0,0,0)

--ui special money
local specialMoney = display.newImageRect(uiGroup,"/sprites/gui/genericItem_color_158.png",48,48)
specialMoney.x = display.actualContentWidth-40
specialMoney.y = 100
specialCoinText = display.newText(uiGroup,":" .. money, display.actualContentWidth+10,100,native.systemFont, 36)
specialCoinText:setFillColor(0,0,0)

--pause button
pauseButton = display.newImageRect(uiGroup, "/sprites/gui/pause.png", 100,100)
pauseButton.x = 100
pauseButton.y = 100


--listeners
system.setAccelerometerInterval( 60 )
Runtime:addEventListener( "accelerometer", MovePlayer)
Runtime:addEventListener( "accelerometer", playerShoot )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
    fizyka.start()
    Runtime:addEventListener ("enterFrame", onFrame);
    Runtime:addEventListener( "collision", onCollision )
    ------------GAME TIMER UPDATE CALL---------------
timerOn = timer.performWithDelay(1000,updateTime,0)
timerPowerUp = timer.performWithDelay(math.random(10000,15000),PowerUpFlow,0)
gameLoopTimer= timer.performWithDelay(2000,gameloop,0)
bulletTimer = timer.performWithDelay(2000,BullethellAI,0) 
--------------------------------------------------
    --music
    --

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
    timer.cancel(gameLoopTimer)
    timer.cancel(timerOn)
    timer.cancel(timerPowerUp)
    timer.cancel(bulletTimer)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
    Runtime:removeEventListener("collision", onCollision)
    Runtime:removeEventListener("enterFrame", onFrame)
    Runtime:removeEventListener("accelerometer", MovePlayer)
    Runtime:removeEventListener("accelerometer", playerShoot)
    fizyka.pause()
    --audio.stop( 1 )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
  --audio.dispose(explosionSound)
  --audio.dispose(fireSound)
  --audio.dispose(backMusic)

end
--



-----------API-----------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
-------------------------------------------------------