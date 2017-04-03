-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- Modul lvl_Energy.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------
 --vungle
 --local ads = require "ads"
--APPODEAL
local ads = require ( "plugin.appodeal" )
ads.show( "banner", { yAlign="bottom" } )
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
--local params
local reklamaBtn
local reklamaText
local oneHurt
local oneHurtText
local oneCoin
local allHurts
local allHurtsText
local allCoin
local leve0 = require("Level0")
local menu = require("menu")
local gameOver = require("GameOver")
local pause = require("pauseoverlay")
local restartModule = require("restart")
local livesLevelText 
local moneyText
local specialMoneyText
local PauseTitle
local scoreText
local nextLevelEnergy=0
local levelEnergyTable = {}
-- Keep track of time in seconds
local secondsLeft = 3600*5 -- 60 minutes * 60 seconds *5
local clockText
local countDownTimer
-- local forward references should go here --

local function gotoHome()
  composer.removeScene("menu")
  composer.gotoScene( "menu",{time=800, effect = "crossFade"} )
  
end
--

local function gotoGacha()
  composer.gotoScene("Gacha")
  end
 
local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	--composer.gotoScene (  event.target.destination, { params ={levelNum = params.levelNum}, time=800, effect = "fade"} )
	composer.gotoScene(  event.target.destination, { params = { levelNum = params.levelNum}, time=800, effect = "fade"} )
  return true
end
 --
 
 -------------------------ads------------------
 local function vungleVideo()
   ads.show( "rewardedVideo" );
   gLiveLevel = gLiveLevel + 1
    secondsLeft = 3600*5
   print("test Vungle")
   --composer.hideOverlay("lvl_Energy")
   --composer.showOverlay("lvl_Energy")
   composer.gotoScene("lvl_Energy")
   
 end
 --
 local function buyHurt1()
   if (gMoney<1000) then
     composer.showOverlay("monety_Monetization", {isModal = true, effect ="zoomInOutFade", time = 400})
   else
     gMoney = gMoney - 1000
     gLiveLevel = gLiveLevel+1
     secondsLeft = 3600*5
     --composer.hideOverlay("lvl_Energy")
     --composer.showOverlay("lvl_Energy
     composer.gotoScene("lvl_Energy")
     end
 end
 --
 local function buyHurt2()
   if (gMoney<4000) then
     composer.showOverlay("monety_Monetization", {isModal = true, effect ="zoomInOutFade", time = 400})
   else
     gMoney = gMoney - 4000
     gLiveLevel = 5
     --composer.hideOverlay("lvl_Energy")
     --composer.showOverlay("lvl_Energy")
      composer.gotoScene("lvl_Energy")
     end
 end
------------------------------------------------
 
 function catchBackgroundOverlay(event)
	return true 
end
--

local function updateTime()
  print(secondsLeft)
  if (gLiveLevel==5) then
    --clockText.text = "00:00:00"
    --timer.cancel(countDownTimer)
    reklamaBtn.isVisible = false
    reklamaText.isVisible = false
    oneHurt.isVisible = false
    oneHurtText.isVisible = false
    oneCoin.isVisible = false
    allHurts.isVisible = false
    allHurtsText.isVisible = false
    allCoin.isVisible = false
  elseif (gLiveLevel<=5) then
   -- clockText.text = "05:00:00"
    reklamaBtn.isVisible = true
    reklamaText.isVisible = true
    oneHurt.isVisible = true
    oneHurtText.isVisible = true
    oneCoin.isVisible = true
    allHurts.isVisible = true
    allHurtsText.isVisible = true
    allCoin.isVisible = true
    	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1
	
	-- time is tracked in seconds.  We need to convert it to hours,  minutes and seconds
  local hours = math.floor (secondsLeft/3600)
	local minutes = math.floor( (secondsLeft / 60)%60 )
	local seconds = secondsLeft % 60
	
	-- make it a string using string format.  
	local timeDisplay = string.format( "%02d:%02d:%02d", hours, minutes, seconds )
	clockText.text = timeDisplay
  if (secondsLeft == 0) then
    gLiveLevel = gLiveLevel + 1
    --composer.hideOverlay("lvl_Energy")
    --composer.showOverlay("lvl_Energy")
    secondsLeft = 3600*5
    countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
     composer.gotoScene("lvl_Energy")
    end
  end
end
 --
-- Called when the scene's view does not exist:
function scene:create( event )
 -- parent:pauseGame()
   countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
   print("Scene was created")
	local group = self.view
 

 local background = display.newImageRect(group, "back1.jpg", 800, 1600)
background.x = display.contentCenterX
background.y = display.contentCenterY
background.anchorX = 0.5
 
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
        

  
  PauseTitle = display.newText(group,"Low energy!", display.contentCenterX-150,display.contentCenterY/3-30,"kenvector_future_thin.ttf", 48)
  
 clockText = display.newText(group,"05:00:00", display.contentCenterX, display.contentCenterY-80, "kenvector_future_thin.ttf", 48)
 clockText.anchorX = 0.5
clockText:setFillColor(0.9,0.9,0)

    livesLevelText = display.newText(group,":" .. gLiveLevel, display.contentCenterX/2 +60,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)
  
  moneyText = display.newText(group,":" .. gMoney, display.contentCenterX +30,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)
  
  specialMoneyText = display.newText(group,":" .. gSpecial, display.contentCenterX+155 +30,display.contentCenterY/2+20,"kenvector_future_thin.ttf", 36)

 
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
        
        local liveLevel = display.newImageRect ("sprites/gui/bolt_gold.png" ,19,30)
        liveLevel.anchorX = 0.5
        liveLevel.x = display.contentCenterX /3 + 100
				liveLevel.y = display.contentCenterY /2+20
        group:insert(liveLevel)	
        
        local monety = display.newImageRect("sprites/gui/Coin_03.png",48,48)
        monety.anchorX = 0.5
monety.x = display.contentCenterX
monety.y = display.contentCenterY /2+20
group:insert(monety)	

local specialMoney = display.newImageRect("sprites/gui/genericItem_color_158.png",48,48)
        specialMoney.anchorX = 0.5
specialMoney.x = display.contentCenterX+150
specialMoney.y = display.contentCenterY /2+20
group:insert(specialMoney)

        
       --[[
       local backBtn = display.newImageRect ("sprites/gui/return (4).png" ,100,100)
        backBtn.anchorX = 0.5
        backBtn.x = display.contentCenterX - overlay.width /3
				backBtn.y = display.contentCenterY - (overlay.width - 200)
				--homeBtn.destination = "menu"
        local function  HideOverlay()
          composer.hideOverlay("lvl_Energy", {effect = "ZoomOutIn", time = 400})
          composer.gotoScene("Level0", {effect = "flipFadeOutIn", time = 400})
          end
				backBtn:addEventListener("tap", HideOverlay)
				group:insert(backBtn)	
        --]]
        reklamaBtn = display.newImageRect ("sprites/gui/metalPanel.png" ,400,70)
        reklamaBtn.anchorX = 0.5
        reklamaBtn.x = display.contentCenterX
        reklamaBtn.y = display.contentCenterY
        reklamaBtn:addEventListener("tap", vungleVideo)
        reklamaText = display.newText("Wath the video\n   and unlock 1 energy!",display.contentCenterX,display.contentCenterY, "kenvector_future_thin.ttf", 24)
        reklamaText.anchorX = 0.5
        reklamaText.anchorY = 0.5
        reklamaText:setFillColor(0,0.9,0.3)
        group:insert(reklamaBtn)
        group:insert(reklamaText)
        
        oneHurt = display.newImageRect ("sprites/gui/metalPanel.png" ,400,70)
        oneHurt.anchorX = 0.5
        oneHurt.x = display.contentCenterX
        oneHurt.y = display.contentCenterY+100
        oneHurt:addEventListener("tap", buyHurt1)
        
        oneHurtText = display.newText("BUY 1 ENERGY!\n      (1000)",display.contentCenterX,display.contentCenterY+100, "kenvector_future_thin.ttf", 30)
        oneHurtText.anchorX = 0.5
        oneHurtText.anchorY = 0.5
        oneHurtText:setFillColor(0,0.9,0.3)
        oneCoin = display.newImageRect("sprites/gui/Coin_03.png",48,48)
oneCoin.x = display.contentCenterX+150
oneCoin.y = display.contentCenterY+100
        group:insert(oneHurt)
            group:insert(oneHurtText)
            group:insert(oneCoin)	
        
        allHurts = display.newImageRect ("sprites/gui/metalPanel.png" ,400,70)
        allHurts.anchorX = 0.5
        allHurts.x = display.contentCenterX
        allHurts.y = display.contentCenterY+200
        allHurts:addEventListener("tap",buyHurt2)
            allHurtsText = display.newText("BUY all ENERGY!\n      (4000)",display.contentCenterX,display.contentCenterY+200, "kenvector_future_thin.ttf", 30)
        allHurtsText.anchorX = 0.5
        allHurtsText.anchorY = 0.5
        allHurtsText:setFillColor(0,0.9,0.3)
        allCoin = display.newImageRect("sprites/gui/Coin_03.png",48,48)
allCoin.x = display.contentCenterX+150
allCoin.y = display.contentCenterY+200
        group:insert(allHurts)
        group:insert(allHurtsText)
        group:insert(allCoin)
        
        
        


for  i = 1,5 do
    local liveEnergy =  display.newImageRect("sprites/gui/bold_silver.png",60,90)
    liveEnergy.anchorX = 0.5
    liveEnergy.x = display.contentCenterX-150 + nextLevelEnergy
    liveEnergy.y = display.contentCenterY /2+100
    group:insert(liveEnergy)
    nextLevelEnergy = nextLevelEnergy + 80
  end
  nextLevelEnergy = 0
  for  i = 1,5 do
    local liveEnergy2 =  display.newImageRect("sprites/gui/bolt_gold.png",60,90)
    table.insert(levelEnergyTable,liveEnergy2)
    liveEnergy2.anchorX = 0.5
    liveEnergy2.x = display.contentCenterX-150 + nextLevelEnergy
    liveEnergy2.y = display.contentCenterY /2+100
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
      ads.hide("banner")
        -- Call the "resumeGame()" function in the parent scene
        --parent:resumeGame()
    end
    system.setIdleTimer(false) -- sleep  OFF
end

function scene:show (event)
  local group = self.view
  local phase = event.phase
  
  if ( phase == "will" ) then
    

  
  
        livesLevelText.text = ": " .. gLiveLevel
        moneyText.text = ": " .. gMoney
        specialMoneyText.text = ": " .. gSpecial	

  elseif (phase == "did") then
    
    
    
    --[[nextLevelEnergy = 0
    for  i = 1,5 do
    local liveEnergy2 =  display.newImageRect("sprites/gui/bolt_gold.png",60,90)
    table.insert(levelEnergyTable,liveEnergy2)
    liveEnergy2.anchorX = 0.5
    liveEnergy2.x = display.contentCenterX-150 + nextLevelEnergy
    liveEnergy2.y = display.contentCenterY /2+100
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
    end--]]
  end
  --
  end
--

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
 
---------------------------------------------------------------------------------
 
return scene