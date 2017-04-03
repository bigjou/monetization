-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- main.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------

local composer = require("composer")
--[[--vungle ads video
local ads = require "ads"
appID = "58990a397b08cdf1120001ef";
-- реклама начнет кэшироваться на шаге init
ads.init( "vungle", appID );--]]

--appodeal ads
local appodeal = require( "plugin.appodeal" )
local function adListener( event )

    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.isError )
    end
end

-- Initialize the Appodeal plugin
appodeal.init( adListener, { appKey="0f71dc4a7ef91da7ddb777ba1f75c25c43c8271542888646", testMode = true } )


--random
math.randomseed(os.time())
display.setDefault( "anchorX", 0)
gMoney=0
gSpecial = 0
gLiveLevel = 5
gDay = 1

--reserve a channel for backmusic
--audio.reserveChannels(1)
--audio.setVolume(0.3, {channel = 1})

--go to menu
composer.gotoScene("Gacha")