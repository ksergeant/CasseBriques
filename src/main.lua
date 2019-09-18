-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- variable GAME
local myGame = require("gameManager") 
myGameState = require("gameState")
-- Fonction LOAD de Love2D
function love.load()

 myGame:Load()
  bgm = love.audio.newSource("musiques/through_space.ogg", "stream")
  love.mouse.setVisible(false) -- cache la souris
  love.mouse.setPosition(myGameState.largeur/2, myGameState.hauteur/2)
 
end

-- Fonction UPDATE de Love2D
function love.update(dt)

  myGame:Update(dt)
  love.audio.play(bgm)
 
end

-- Fonction DRAW de Love2D
function love.draw(dt)

  myGame:Draw(dt)
  
end

-- Fonction qui se lance lorsque la souris est préssée
function love.mousepressed(x,y,n)
  
    if myGameState.myBalle.colle == true then
      myGameState.myBalle.colle = false
      myGameState.myBalle.vx = 300
      myGameState.myBalle.vy = -300
      myGameState.myBalle.destinationX = math.random(0, myGameState.largeur)
      myGameState.myBalle.destinationY = 0
    end
  
end
  
-- Fonction qui se lance lorsque une touche est préssée
function love.keypressed(key)

  if key == "escape" then 
    love.event.quit()
  end
  
  if key == "d" and myGameState.Debug == false then
    myGameState.Debug = true
    
  elseif key == "d" and myGameState.Debug == true then
    myGameState.Debug = false
    
  end
 
end