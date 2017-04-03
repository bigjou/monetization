-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- Modul monety_Monetization.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------
 --local ads = require "ads"
 local ads = require( "plugin.appodeal" )
 ads.show( "banner", { yAlign="bottom" } )
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
--local params
local leve0 = require("Level0")
local menu = require("menu")
local gameOver = require("GameOver")
local pause = require("pauseoverlay")
local livesLevelText 
local moneyText
local specialMoneyText
local PauseTitle
-- local forward references should go here --

local function gotoHome()
  composer.removeScene("menu")
  composer.gotoScene( "menu",{time=800, effect = "crossFade"} )
  
end

local function  gotoGacha()
  composer.gotoScene("Gacha")
  end
--
 local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	--composer.gotoScene (  event.target.destination, { params ={levelNum = params.levelNum}, time=800, effect = "fade"} )
	composer.gotoScene(  event.target.destination, { params = { levelNum = params.levelNum}, time=800, effect = "fade"} )
  return true
end
 
 --ads
 local function vungleVideo()
   ads.show( "rewardedVideo" );
   gMoney = gMoney + 100
   print("test Vungle")
   print(gLiveLevel)
   composer.hideOverlay("monety_Monetization")
   composer.showOverlay("monety_Monetization")
 end
 --
 
 function catchBackgroundOverlay(event)
	return true 
end
--

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
 

 
local backgroundOverlay = display.newRect (group, display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
        backgroundOverlay.anchorX = 0.5
				backgroundOverlay:setFillColor( 0,0,0 )
				backgroundOverlay.alpha = 0.7
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
	
 
local overlay = display.newImage ("sprites/gui/glassPanelPause_Height.png",1,1)
        overlay.anchorX = 0.5
				overlay.x = display.contentCenterX
				overlay.y = display.contentCenterY
				group:insert (overlay)
        
  livesLevelText = display.newText(group,":" .. gLiveLevel, display.contentCenterX/2 +60,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)
  
  moneyText = display.newText(group,":" .. gMoney, display.contentCenterX +30,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)
  
  specialMoneyText = display.newText(group,":" .. gSpecial, display.contentCenterX+155 +30,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)
  
  PauseTitle = display.newText(group,"Need some\n    coins?", display.contentCenterX-150,display.contentCenterY/3-30,"kenvector_future_thin.ttf", 48)
  
local storeBtn = display.newImageRect ("sprites/gui/shoppingCart.png", 100,100)
        storeBtn.anchorX = 0.5
				storeBtn.x = display.contentCenterX - overlay.width / 3
				storeBtn.y = display.contentCenterY +overlay.height/2 -100
				storeBtn.destination = "Store" 
				storeBtn:addEventListener("tap", btnTap)
				group:insert(storeBtn)	
 
local prizeBtn = display.newImageRect ("sprites/gui/Metal Case_01.png" ,100,100)
        prizeBtn.anchorX = 0.5
        prizeBtn.x = display.contentCenterX - overlay.width / 3 + 100 
				prizeBtn.y = display.contentCenterY + overlay.height/2 -100
				prizeBtn.destination = "Gacha" 
				prizeBtn:addEventListener("tap", gotoGacha)
				group:insert(prizeBtn)	
				
  
  local homeBtn = display.newImageRect ("sprites/gui/home.png" ,100,100)
        homeBtn.anchorX = 0.5
        homeBtn.x = overlay.width+50 
				homeBtn.y = display.contentCenterY - (overlay.width - 200)
				homeBtn.destination = "menu"
				homeBtn:addEventListener("tap", gotoHome)
      	group:insert(homeBtn)
        
        local backBtn = display.newImageRect ("sprites/gui/return (4).png" ,100,100)
        backBtn.anchorX = 0.5
        backBtn.x = display.contentCenterX - overlay.width /3
				backBtn.y = display.contentCenterY - (overlay.width - 200)
				--homeBtn.destination = "menu" 
        local function hideOverlay()
          composer.hideOverlay("monety_Monetization", {effect = "ZoomOutIn", time = 400})
          composer.gotoScene("lvl_Energy", {effect = "flipFadeOutIn", time = 400})
          end
				backBtn:addEventListener("tap", hideOverlay)
				group:insert(backBtn)	
        
        local reklamaBtn = display.newImageRect ("sprites/gui/metalPanel.png" ,400,70)
        reklamaBtn.anchorX = 0.5
        reklamaBtn.x = display.contentCenterX
        reklamaBtn.y = display.contentCenterY
        reklamaBtn:addEventListener("tap", vungleVideo)
        local reklamaText = display.newText("Wath the video\n   and get 100 coins!",display.contentCenterX,display.contentCenterY, "kenvector_future_thin.ttf", 24)
        reklamaText.anchorX = 0.5
        reklamaText.anchorY = 0.5
        reklamaText:setFillColor(0,0.9,0.3)
        group:insert(reklamaBtn)
        group:insert(reklamaText)
        
        local moneyStore = display.newImageRect ("sprites/gui/metalPanel.png" ,400,70)
        moneyStore.anchorX = 0.5
        moneyStore.x = display.contentCenterX
        moneyStore.y = display.contentCenterY+100
        
        local oneHurtText = display.newText("BUY MORE COINS!\n ",display.contentCenterX,display.contentCenterY+100, "kenvector_future_thin.ttf", 30)
        oneHurtText.anchorX = 0.5
        oneHurtText.anchorY = 0.5
        oneHurtText:setFillColor(0,0.9,0.3)
        local oneCoin = display.newImageRect("sprites/gui/Coin_03.png",48,48)
oneCoin.x = display.contentCenterX+150
oneCoin.y = display.contentCenterY+100
        group:insert(moneyStore)
            group:insert(oneHurtText)
            group:insert(oneCoin)	

        local liveLevel = display.newImageRect ("sprites/gui/bolt_gold.png" ,19,30)
        liveLevel.anchorX = 0.5
        liveLevel.x = display.contentCenterX /3 + 100
				liveLevel.y = display.contentCenterY /2+20
        livesLevelText.text = ": " .. gLiveLevel
        group:insert(liveLevel)	
        
        
        local monety = display.newImageRect("sprites/gui/Coin_03.png",48,48)
        monety.anchorX = 0.5
monety.x = display.contentCenterX
monety.y = display.contentCenterY /2+20
moneyText.text = ": " .. gMoney
group:insert(monety)	

local specialMoney = display.newImageRect("sprites/gui/genericItem_color_158.png",48,48)
        specialMoney.anchorX = 0.5
specialMoney.x = display.contentCenterX+150
specialMoney.y = display.contentCenterY /2+20
specialMoneyText.text = ": " .. gSpecial
group:insert(specialMoney)	

system.setIdleTimer(true) -- sleep mode
end
 --
 
 
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
 
    if ( phase == "will" ) then
      ads.hide("banner")
        -- Call the "resumeGame()" function in the parent scene
        --parent:resumeGame()
    end
    system.setIdleTimer(false) -- sleep mode OFF
end

function scene:show (event)
  local sceneGroup = self.view
  local phase = event.phase
  
  if (phase == "did") then
  end
  --
  end
--


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
 
scene:addEventListener( "hide", scene )
 
 
---------------------------------------------------------------------------------
 
return scene