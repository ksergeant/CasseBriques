-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- variables
local myGame = require("gameManager") 
myGameState = require("gameState")
myMenuManager = require("menuManager")
myParticuleManager = require("particuleManager")

-- Fonction LOAD de Love2D
function love.load()

  love.mouse.setVisible(false) -- cache la souris
  myGame:Load()
  bgm = love.audio.newSource("musiques/through_space.ogg", "stream")
  musiqueMenu = love.audio.newSource("musiques/CyberpunkMoonlightSonata.mp3", "stream")
  love.mouse.setPosition(myGameState.largeur/2, myGameState.hauteur/2)
  myMenuManager:EcranTitreLoad()
   
end

-- Fonction UPDATE de Love2D
function love.update(dt)

  if myGameState.ecranCourant == "Titre" then
    myMenuManager:EcranTitreUpdate(dt)
    myParticuleManager:Update(dt)
    love.audio.stop(bgm)
    love.audio.play(musiqueMenu)
  elseif myGameState.ecranCourant == "Jeu" then
    myGame:Update(dt)
    love.audio.stop(musiqueMenu)
    love.audio.play(bgm)

  elseif myGameState.ecranCourant == "Gameover" then
    myMenuManager:EcranGameoverUpdate(dt)
  end
  
 
end

-- Fonction DRAW de Love2D
function love.draw(dt)
  
  if myGameState.ecranCourant == "Titre" then
    myMenuManager:EcranTitreDraw()
    myParticuleManager:Draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 900, 0)
  elseif myGameState.ecranCourant == "Jeu" then
    myGame:Draw(dt)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 900, 0)


  elseif myGameState.ecranCourant == "Gameover" then
    myMenuManager:EcranGameoverDraw()
  end
end

-- Fonction qui se lance lorsque la souris est préssée
function love.mousepressed(x,y,n)

  if myGameState.ecranCourant == "Titre"  then
   -- myGameState.ecranCourant = "Jeu"
  elseif myGameState.ecranCourant == "Jeu" then
    
    if myGameState.myBalle.colle == true then
      myGameState.myBalle.colle = false
      myGameState.myBalle.vx = 300
      myGameState.myBalle.vy = -300
      myGameState.myBalle.destinationX = math.random(0, myGameState.largeur)
      myGameState.myBalle.destinationY = 0
    end

  elseif myGameState.ecranCourant == "Gameover" then

  end
  
end
  
-- Fonction qui se lance lorsque une touche est préssée
function love.keypressed(key)
  
  if myGameState.ecranCourant == "Titre" then

    if key == "space" and myMenuManager.myCursor.pos == 1 then
       myGameState.ecranCourant = "Jeu"
    elseif key == "space" and myMenuManager.myCursor.pos == 2 then

    elseif key == "space" and myMenuManager.myCursor.pos == 3  then 
      love.event.quit()
    end 

    if key == "up" then
      myMenuManager.myCursor.pos = myMenuManager.myCursor.pos -1
    elseif key == "down" then
      myMenuManager.myCursor.pos = myMenuManager.myCursor.pos +1
    end

    if key == "escape" then 
      love.event.quit()
    end

  elseif myGameState.ecranCourant == "Jeu" then
    if key == "escape" then 
      myGameState.ecranCourant = "Titre"
    end

    if key == "d" and myGameState.Debug == false then
      myGameState.Debug = true
      
    elseif key == "d" and myGameState.Debug == true then
      myGameState.Debug = false
      
    end

  elseif myGameState.ecranCourant == "Gameover" then

  end

end