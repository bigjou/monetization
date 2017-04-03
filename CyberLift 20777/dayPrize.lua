-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- Gacha.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

local day1 = 100
local day2 = 100
local day3 = 300
local day4 = 500
local day5 = 10
local thisDay=0

---------------------------------
--        LOCAL
---------------------------------
local function goToGame()
  composer.removeScene("menu")
composer.gotoScene("menu")
end

function catchBackgroundOverlay(event)
	return true 
end


 --

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
        
        if (gDay==1) then
  thisDay = thisDay +day1
  gMoney = gMoney + day1
  local coin = display.newImageRect(sceneGroup,"sprites/gui/Coin_03.png",100,100)
  coin.x = display.contentCenterX-100
  coin.y = display.contentCenterY+200
elseif (gDay==2) then
  gMoney = gMoney + day2
    thisDay = thisDay + day2
      local coin = display.newImageRect(sceneGroup,"sprites/gui/Coin_03.png",100,100)
  coin.x = display.contentCenterX-100
  coin.y = display.contentCenterY+200
   elseif (gDay==3) then
     gMoney = gMoney + day3
    thisDay = thisDay +day3
      local coin = display.newImageRect(sceneGroup,"sprites/gui/Coin_03.png",100,100)
  coin.x = display.contentCenterX-100
  coin.y = display.contentCenterY+200
   elseif (gDay==4) then
     gMoney = gMoney + day4
    thisDay = thisDay +day4
      local coin = display.newImageRect(sceneGroup,"sprites/gui/Coin_03.png",100,100)
  coin.x = display.contentCenterX-100
  coin.y = display.contentCenterY+200
  elseif (gDay==5) then
    gSpecial = gSpecial + day5
    thisDay = thisDay +day5
      local money = display.newImageRect(sceneGroup,"sprites/gui/genericItem_color_158.png",100,100)
  money.x = display.contentCenterX-100
  money.y = display.contentCenterY+200
  end
  print("day1"..day1)
  print("gDay"..gDay)
  print ("thisDay"..thisDay)
        
        local text = display.newText(sceneGroup,"Congratulation!",display.contentCenterX,display.contentCenterY,"kenvector_future_thin.ttf", 58)
        local text2 = display.newText(sceneGroup,"You've got\n" .. thisDay,display.contentCenterX,display.contentCenterY+150,"kenvector_future_thin.ttf", 64)
        text.anchorX = 0.5
        text2.anchorX = 0.5
        
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
timer.performWithDelay(4000,goToGame)
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
