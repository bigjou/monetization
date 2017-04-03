-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- Modul GameOver.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------
 
local composer = require( "composer" )
local scene = composer.newScene()
local appodeal = require( "plugin.appodeal" )
appodeal.show( "banner", { yAlign="bottom" } )
local physics = require("physics")
--local params
local leve0 = require("Level0")
local menu = require("menu")
local restartModule = require("restart")
local livesLevelText 
local moneyText
local specialMoneyText
local PauseTitle
local scoreText
local nextLevelEnergy=0
local levelEnergyTable = {}
--local restartscene = require("restart")
 --[[ options = {
    --isModal = true,
    effect = "fade",
    time = 400,
    params = {
        levelNum = params.levelNum
    }
}--]]
-- local forward references should go here --


local function gotoHome()
  composer.removeScene("menu")
  composer.gotoScene( "menu",{time=800, effect = "crossFade"} )
end
--
 local function restartLevel()
   if (gLiveLevel<=0) then
  composer.showOverlay( "lvl_Energy", { isModal = true, effect = "zoomOutIn", time = 400, params = {
levelNum = "GameOver"} } )
else
  composer.removeScene("restart")
  composer.gotoScene("restart" ,{time=800, effect = "crossFade"} )
  end
end
 --
 
local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	--composer.gotoScene (  event.target.destination, { params ={levelNum = params.levelNum}, time=800, effect = "fade"} )
	composer.gotoScene(  event.target.destination, { params = { levelNum = params.levelNum}, time=800, effect = "fade"} )
  return true
end
 
 function catchBackgroundOverlay(event)
	return true 
end
 
-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
 

--
appodeal.show( "interstitial" )
 
local backgroundOverlay = display.newRect (group, display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
        backgroundOverlay.anchorX = 0.5
				backgroundOverlay:setFillColor( 0,0,0 )
				backgroundOverlay.alpha = 0.6
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
	
 
local overlay = display.newImage ("sprites/gui/glassPanelPause_Height.png",1,1)
        overlay.anchorX = 0.5
				overlay.x = display.contentCenterX
				overlay.y = display.contentCenterY
				group:insert (overlay)
        
  livesLevelText = display.newText(group,":" .. gLiveLevel, display.contentCenterX/2 +60,display.contentCenterY+300,"kenvector_future_thin.ttf", 36)
  
  moneyText = display.newText(group,":" .. gMoney, display.contentCenterX +30,display.contentCenterY+300,"kenvector_future_thin.ttf", 36)
  
  specialMoneyText = display.newText(group,":" .. gSpecial, display.contentCenterX+155 +30,display.contentCenterY+300,"kenvector_future_thin.ttf", 36)
  
  PauseTitle = display.newText(group,"Game Over", display.contentCenterX-100,display.contentCenterY/3-30,"kenvector_future_thin.ttf", 48)
  
  scoreText = display.newText(group, "Score: " .. composer.getVariable( "finalScore" ), display.contentCenterX, display.contentCenterY/2+30,"kenvector_future_thin.ttf", 64)
  scoreText.anchorX = 0.5
  composer.setVariable( "finalScore", 0 )
 
local playBtn = display.newImageRect ("sprites/gui/shadedDark16.png", 100,100 )
        playBtn.anchorX = 0.5
        playBtn.x = display.contentCenterX 
				playBtn.y = display.contentCenterY 
				local function hideOverlay(event)
					composer.hideOverlay("fade", 800)
				end 
				playBtn:addEventListener ("tap", restartLevel)
				group:insert(playBtn)
 
local storeBtn = display.newImageRect ("sprites/gui/shoppingCart.png", 100,100)
        storeBtn.anchorX = 0.5
				storeBtn.x = display.contentCenterX - overlay.width / 3
				storeBtn.y = display.contentCenterY 
				storeBtn.destination = "Store" 
				storeBtn:addEventListener("tap", btnTap)
				group:insert(storeBtn)	
 
local prizeBtn = display.newImageRect ("sprites/gui/Metal Case_01.png" ,100,100)
        prizeBtn.anchorX = 0.5
        prizeBtn.x = display.contentCenterX + overlay.width / 3 
				prizeBtn.y = display.contentCenterY
				prizeBtn.destination = "Gacha" 
				prizeBtn:addEventListener("tap", btnTap)
				group:insert(prizeBtn)	
				--reloadBtn.x = centerX + overlay.width / 3 
				--reloadBtn.y = centerY + overlay.height/2.2
				--params = event.params
				--reloadBtn.destination = "reloading"
				--reloadBtn:addEventListener ("tap", btnTap)
				--group:insert (reloadBtn)
        
        local highScoreBtn = display.newImageRect ("sprites/gui/leaderboardsComplex (4).png" ,100,100)
        highScoreBtn.anchorX = 0.5
        highScoreBtn.x = display.contentCenterX 
				highScoreBtn.y = display.contentCenterY + (overlay.width - 150)
				highScoreBtn.destination = "HighScore" 
				highScoreBtn:addEventListener("tap", btnTap)
				group:insert(highScoreBtn)	
  
  local homeBtn = display.newImageRect ("sprites/gui/home.png" ,100,100)
        homeBtn.anchorX = 0.5
        homeBtn.x = display.contentCenterX - overlay.width / 3 
				homeBtn.y = display.contentCenterY - (overlay.width - 150)
				--homeBtn.destination = "menu" 
				homeBtn:addEventListener("tap", gotoHome)
				group:insert(homeBtn)	
        
        
        local liveLevel = display.newImageRect ("sprites/gui/bolt_gold.png" ,19,30)
        liveLevel.anchorX = 0.5
        liveLevel.x = display.contentCenterX /3 + 100
				liveLevel.y = display.contentCenterY +300
        livesLevelText.text = ": " .. gLiveLevel
        group:insert(liveLevel)	
        
        
        local monety = display.newImageRect("sprites/gui/Coin_03.png",48,48)
        monety.anchorX = 0.5
monety.x = display.contentCenterX
monety.y = display.contentCenterY +300 
moneyText.text = ": " .. gMoney
group:insert(monety)	

local specialMoney = display.newImageRect("sprites/gui/genericItem_color_158.png",48,48)
        specialMoney.anchorX = 0.5
specialMoney.x = display.contentCenterX+150
specialMoney.y = display.contentCenterY +300
specialMoneyText.text = ": " .. gSpecial
group:insert(specialMoney)	


for  i = 1,5 do
    local liveEnergy =  display.newImageRect("sprites/gui/bold_silver.png",60,90)
    liveEnergy.anchorX = 0.5
    liveEnergy.x = display.contentCenterX-150 + nextLevelEnergy
    liveEnergy.y = display.contentCenterY +150
    group:insert(liveEnergy)
    nextLevelEnergy = nextLevelEnergy + 80
  end
  nextLevelEnergy = 0
  for  i = 1,5 do
    local liveEnergy2 =  display.newImageRect("sprites/gui/bolt_gold.png",60,90)
    table.insert(levelEnergyTable,liveEnergy2)
    liveEnergy2.anchorX = 0.5
    liveEnergy2.x = display.contentCenterX-150 + nextLevelEnergy
    liveEnergy2.y = display.contentCenterY +150
    group:insert(liveEnergy2)
    nextLevelEnergy = nextLevelEnergy + 80
  end
  for i = #levelEnergyTable, 1, -1 do
    local thisLevelEnergy = levelEnergyTable[i]
    if (gLiveLevel == 4) then
      display.remove(thisLevelEnergy)
      table.remove(levelEnergyTable,i-1)
    elseif (gLiveLevel == 3) then
      display.remove(thisLevelEnergy)
      table.remove(levelEnergyTable,i-2)
    elseif (gLiveLevel == 2) then
      display.remove(thisLevelEnergy)
      table.remove(levelEnergyTable,i-3)
      elseif (gLiveLevel == 1) then
      display.remove(thisLevelEnergy)
      table.remove(levelEnergyTable,i-4)
      elseif (gLiveLevel == 0) then
      display.remove(thisLevelEnergy)
      table.remove(levelEnergyTable,i-5)
      end
  end
  --

system.setIdleTimer(true) -- sleep mode

end
 --
 
 
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
 
    if ( phase == "will" ) then
      appodeal.hide("banner")
        -- Call the "resumeGame()" function in the parent scene
        --parent:resumeGame()
    end
    system.setIdleTimer(false) -- sleep mode OFF
end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )
 
scene:addEventListener( "hide", scene )
 
 
---------------------------------------------------------------------------------
 
return scene