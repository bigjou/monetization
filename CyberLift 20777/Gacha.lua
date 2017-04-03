-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- Gacha.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

local title
 local gachaBtn
 local btnText 
local secondsLeft = 3600*24 -- 60 minutes * 60 seconds *5
local clockText
local countDownTimer

---------------------------------
--        LOCAL
---------------------------------
local function gotoHome()
  composer.removeScene("menu")
  composer.gotoScene( "menu",{time=800, effect = "crossFade"} )
  
end

local function updateTime()
if (secondsLeft == 1) then
   if (gDay == 5 ) then
    gDay = 1
    else
  gDay = gDay + 1
  end
  timer.cancel(countDownTimer)
  title.isVisible = false
  clockText.isVisible = false
  gachaBtn.isVisible = true
    btnText.isVisible = true
    return
  end

    	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1
	
	-- time is tracked in seconds.  We need to convert it to hours,  minutes and seconds
  local hours = math.floor (secondsLeft/3600)
	local minutes = math.floor( (secondsLeft / 60)%60 )
	local seconds = secondsLeft % 60
	
	-- make it a string using string format.  
	local timeDisplay = string.format( "%02d:%02d:%02d", hours, minutes, seconds )
	clockText.text = timeDisplay
end

function catchBackgroundOverlay(event)
	return true 
end

local function gotoGame()
  composer.removeScene("menu")
    composer.gotoScene( "menu",{time=800, effect = "crossFade"} )
    end

 --

local function getPrize()
  secondsLeft = 3600*24
   title.isVisible = true
  clockText.isVisible = true
    countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
    gachaBtn.isVisible = false
    btnText.isVisible = false
    composer.removeScene("dayPrize")
    composer.showOverlay("dayPrize", {isModular = true, effect = "zoomFadeInOut", time=400})
    
  
  end

--------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- create()
function scene:create( event )

	local sceneGroup = self.view
  
  
  local background = display.newImageRect( sceneGroup, "back1.jpg", 800, 1600 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  background.anchorX = 0.5

  local backgroundOverlay = display.newRect (sceneGroup, display.contentCenterX, display.contentCenterY  ,display.contentWidth,display.contentHeight)
        backgroundOverlay.anchorX = 0.5
				backgroundOverlay:setFillColor( 0,0,0 )
				backgroundOverlay.alpha = 0.6
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
        

local homeBtn = display.newImageRect (sceneGroup, "sprites/gui/home.png" ,100,100)
        homeBtn.anchorX = 0.5
        homeBtn.x = display.contentCenterX +200
				homeBtn.y = display.contentCenterY - 400
				homeBtn.destination = "menu"
				homeBtn:addEventListener("tap", gotoHome)
      	sceneGroup:insert(homeBtn)


  local prize = display.newImageRect( sceneGroup, "sprites/gui/Metal Case_01.png", 100,100 )
  prize.x = 600
  prize.y = display.contentCenterY+100
  prize.anchorX = 0.5


 local x = 0
  local day = 1
  for i = 1,5 do
 
    local table = display.newRect(sceneGroup, x,display.contentCenterY,100,100)
    table.anchorX = 0.5
    --table.anchorY = 0.5
    table.strokeWidth = 5;
    table.x = x+200
    table:setStrokeColor(0,0.8,1)
    table:setFillColor (0,0,0)
    table.alpha = 0.3
      local tableText = display.newText(sceneGroup, day .. " \nday",x,display.contentCenterY, "kenvector_future_thin.ttf", 34)
    tableText.anchorX = 0.5
    tableText.x = x+200
    sceneGroup:insert(table)
    sceneGroup:insert(tableText)
    
    
    local table2 = display.newRect(sceneGroup, x,display.contentCenterY+100,100,100)
    table2.anchorX = 0.5
    --table.anchorY = 0.5
    table2.strokeWidth = 5;
    table2.x = x+200
    table2:setStrokeColor(0,0.8,1)
    table2:setFillColor (0,0,0)
    table2.alpha = 0.3
      local tableText2 = display.newText(sceneGroup, day .. " \nday",x,display.contentCenterY, "kenvector_future_thin.ttf", 34)
    tableText2.anchorX = 0.5
    tableText2.x = x+200
    sceneGroup:insert(table2)
    sceneGroup:insert(tableText2)
    day = day + 1
    x = x + 100
  end
  x = 0
  for i = 1,4 do
       local money = display.newImageRect(sceneGroup,"sprites/gui/Coin_03.png",100,100)
    money.anchorX = 0.5
    money.x = x+200
    money.y = display.contentCenterY+100
    sceneGroup:insert(money)
    x = x + 100
      end
  

    gachaBtn = display.newImageRect (sceneGroup,"sprites/gui/metalPanel.png" ,400,70)
  gachaBtn.anchorX = 0.5
  gachaBtn.x = display.contentCenterX
  gachaBtn.y = display.contentCenterY+300
  gachaBtn:addEventListener("tap", getPrize)
  
  
  btnText = display.newText(sceneGroup,"GET YOUR PRIZE!",display.contentCenterX,display.contentCenterY+300,"kenvector_future_thin.ttf",36 )
  btnText.anchorX = 0.5
  btnText:setFillColor(0,0.9,0.3)
  
  --
  
  title = display.newText(sceneGroup,"Next daily prize in:", display.contentCenterX,display.contentCenterY/3+100,"kenvector_future_thin.ttf", 48)
  title.anchorX = 0.5
  title.isVisible = false
  
  clockText = display.newText(sceneGroup,"24:00:00", display.contentCenterX, display.contentCenterY/3+200, "kenvector_future_thin.ttf", 48)
 clockText.anchorX = 0.5
clockText:setFillColor(0.9,0.9,0)
clockText.isVisible = false
  
  
  
  
    --[[local tableText = display.newText(sceneGroup, day .. " day",x,display.contentCenterY, "kenvector_future_thin.ttf", 34)
    tableText.anchorX = 0.5
    sceneGroup:insert(table)
    sceneGroup:insert(tableText)
    --day = day + 1--]]
    
    system.setIdleTimer(true) -- sleep mode
   

end
--


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)


	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
