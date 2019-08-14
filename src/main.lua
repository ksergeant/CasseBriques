-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- variable GAME
local myGame = require("game")

-- Fonction LOAD de Love2D
function love.load()

 myGame:Load()
  
  sonPerteBalle = love.audio.newSource("sons/sfx_deathscream_human2.wav","static")
  sonCollisonBrique = love.audio.newSource("sons/sfx_sounds_impact5.wav","static")
  sonCollisonRaquette = love.audio.newSource("sons/DM-CGS-07.wav","static")
  bgm = love.audio.newSource("musiques/through_space.ogg", "stream")
  love.mouse.setVisible(false) -- cache la souris

end

-- Fonction UPDATE de Love2D
function love.update(dt)

  myGame:Update()
  love.audio.play(bgm)

  --[[
  -- si la souris sort de l'écran elle est replacée
  if love.mouse.getX() >= largeur-40 then
      love.mouse.setX(largeur -40)
  end

  if love.mouse.getX() <= 40 then
    love.mouse.setX(40)
  end

  if love.mouse.getY() >= hauteur-40 then
    love.mouse.setY(hauteur -40)
  end

  if love.mouse.getY() <= 40 then
    love.mouse.setY(40)
  end
    ]]--
    
  --[[
  maRaquette.x = love.mouse.getX()
  
  if maRaquette.x < maRaquette.largeur/2 then
     maRaquette.x = maRaquette.largeur/2
  end
  
  if maRaquette.x > largeur - maRaquette.largeur/2 then
     maRaquette.x = largeur - maRaquette.largeur/2
  end
  
  if maBalle.colle == true then
    maBalle.x = maRaquette.x -10
    maBalle.y = maRaquette.y 
  else
    maBalle.x = maBalle.x +(maBalle.vx*dt)
    maBalle.y = maBalle.y +(maBalle.vy*dt)
  end
  
  local c = math.floor(maBalle.x / maBrique.largeur) +1
  local l = math.floor(maBalle.y / maBrique.hauteur) +1
  
  if l >= 1 and l <= #monNiveau and c >= 1 and c <= 15 then
    if monNiveau[l][c] == 1 then
      maBalle.vy = 0 - maBalle.vy
      monNiveau[l][c] = 0
      compteurBriques = compteurBriques - 1
      sonCollisonBrique:play()
    end
  end
  
  if maBalle.x > largeur then
    maBalle.vx =  0 - maBalle.vx
    maBalle.x = largeur
  end
  
  if maBalle.x < 0 then
    maBalle.vx = 0 - maBalle.vx
    maBalle.x = 0
  end
  
  if maBalle.y < 0 then
     maBalle.vy = 0 - maBalle.vy
     maBalle.y = 0
  end
  
  if maBalle.y > hauteur then 
    -- on perd une balle
    sonPerteBalle:play()
    mesVies.valeur = mesVies.valeur - 1
    maBalle.colle = true
  end
  
  if mesVies.valeur  <1 then
    love.event.quit()
  end
  
  -- Tester collision avec la raquette
  local posCollisionRaquette = maRaquette.y - (maRaquette.hauteur/2) - maBalle.rayon
  if maBalle.y > posCollisionRaquette then
    local dist = math.abs(maRaquette.x - maBalle.x)
    if dist < maRaquette.largeur/2 then
      sonCollisonRaquette:play()
      maBalle.vy = 0 - maBalle.vy
      maBalle.y = posCollisionRaquette
    end
  end
    ]]--
end

-- Fonction DRAW de Love2D
function love.draw()

  myGame:Draw()
  
      
end

-- Fonction qui se lance lorsque la souris est préssée
function love.mousepressed(x,y,n)
  --[[
    if maBalle.colle == true then
        maBalle.colle = false
        maBalle.vx = 400
        maBalle.vy = -400
      end
  ]]--
end
  
-- Fonction qui se lance lorsque une touche est préssée
function love.keypressed(key)
  if key == "escape" then 
    love.event.quit()
  end
  
  print(key)
  
end