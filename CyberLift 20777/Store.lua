-----------------------------------------------------------------------------------------
--Projekt dyplomowy
-- main.lua
--Stanislav Mishchenko
-----------------------------------------------------------------------------------------

local composer = require("composer")

--random
math.randomseed(os.time())

--reserve a channel for backmusic
--audio.reserveChannels(1)
--audio.setVolume(0.3, {channel = 1})

--go to menu
composer.gotoScene("menu")