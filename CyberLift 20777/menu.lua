-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- menu.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()


---------------------------------
--        LOCAL
---------------------------------
local function gotoGame()
  if (gLiveLevel<=0) then
    gLiveLevel = 0
    --composer.removeScene("lvl_Energy")
    composer.gotoScene( "lvl_Energy", { isModal = true, effect = "zoomOutIn", time = 400, params = {
levelNum = "menu"} } )
  else
  composer.removeScene("Level0")
    composer.gotoScene( "Level0",{time=800, effect = "crossFade"} )
    end
end

local function gotoGacha ()
 -- composer.removeScene("Gacha")
    composer.gotoScene( "Gacha", {timer=800,effect="crossFade"} )
end
 --
--[[local function gotoHighScores()
  composer.removeScene("HighScore")
    composer.gotoScene( "HighScore", {timer=800,effect="crossFade"} )
end
--
local function gotoAbout()
  composer.removeScene("About")
    composer.gotoScene( "About", {timer=800,effect="crossFade"} )
end
--
local function gotoLevelSelect()
  composer.removeScene("selectLevel")
    composer.gotoScene( "selectLevel", {timer=800,effect="crossFade"} )
end
--
local function gotoStore()
  composer.removeScene("Store")
    composer.gotoScene( "Store", {timer=800,effect="crossFade"} )
end
--
local function gotoGacha ()
  composer.removeScene("Gacha")
    composer.gotoScene( "Gacha", {timer=800,effect="crossFade"} )
end--]]
--

--------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:resumeGame()
    
end


-- create()
function scene:create( event )

	local sceneGroup = self.view

local background = display.newImageRect( sceneGroup, "back1.jpg", 800, 1600 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.anchorX = 0.5

local title = display.newText( sceneGroup, "Cyber lift\n      20777",500, 80, "kenvector_future.ttf", 72)
--title.size = 72
title.x = display.contentCenterX+30
title.y = 200
title:setFillColor(0.9,0.9,0)
title.anchorX = 0.5

local playButton = display.newImageRect( sceneGroup, "sprites/gui/shadedDark42.png", 220,80 )
playButton.x = display.contentCenterX
playButton.y = 550
playButton.anchorX = 0.5
playButton:addEventListener( "tap", gotoGame )
 
local highScoresButton = display.newImageRect( sceneGroup, "sprites/gui/leaderboardsComplex (4).png", 200,200 )
highScoresButton.x = display.contentCenterX
highScoresButton.y = 700
highScoresButton.anchorX = 0.5
--highScoresButton:addEventListener( "tap", gotoHighScores )


local aboutButton = display.newImageRect( sceneGroup, "sprites/gui/information (4).png", 100,100 )
aboutButton.x = 150
aboutButton.y = display.contentHeight - 100
aboutButton.anchorX = 0.5
--aboutButton:addEventListener( "tap", gotoAbout )


local storeButton = display.newImageRect( sceneGroup, "sprites/gui/shoppingCart.png", 100,100 )
storeButton.x = display.contentWidth-150
storeButton.y = display.contentHeight - 100
storeButton.anchorX = 0.5
--storeButton:addEventListener( "tap", gotoStore )


local prizeButton = display.newImageRect( sceneGroup, "sprites/gui/Metal Case_01.png", 100,100 )
prizeButton.x = display.contentWidth-250
prizeButton.y = display.contentHeight - 90
prizeButton.anchorX = 0.5
prizeButton:addEventListener( "tap", gotoGacha )


system.setIdleTimer(true) -- sleep mode
end


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
