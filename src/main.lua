
-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local imgBackground = love.graphics.newImage("graphiques/game_background_1.png")

-- variable GAME
local monJeu = require("jeu")

-- variable VIES
local mesVies = require("vies")

-- variable RAQUETTE
local maRaquette = require("raquette")

-- variable BALLE
local maBalle = require("balle")

-- variable BRIQUE
local maBrique = require("brique")

-- variable NIVEAU
local monNiveau = require("niveau")

local compteurBriques = 0

-- Fonction qui initialise le programme
function Demarre()
 maBalle.colle = true

 mesVies.initialisation()
  
  local l,c
  
  for l=1,6 do
    monNiveau[l] = {}
    for c=1,15 do
      monNiveau[l][c] = 1
      compteurBriques = compteurBriques + 1
    end
  end
  
end

-- Fonction LOAD de Love2D
function love.load()
 -- love.window.setMode(1000,600,fullscreentype)
 -- love.window.setTitle("Magic Brick 1.0")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  maBrique.hauteur = 25
  maBrique.largeur = largeur / 15
  
  print("Largeur : ",largeur)
  print("Hauteur : ",hauteur)
  
  maRaquette.y = hauteur - (maRaquette.hauteur/2)
  Demarre()

  sonPerteBalle = love.audio.newSource("sons/sfx_deathscream_human2.wav","static")
  sonCollisonBrique = love.audio.newSource("sons/sfx_sounds_impact5.wav","static")
  sonCollisonRaquette = love.audio.newSource("sons/DM-CGS-07.wav","static")
  bgm = love.audio.newSource("musiques/through_space.ogg", "stream")
  love.mouse.setVisible(false) -- cache la souris

end

-- Fonction UPDATE de Love2D
function love.update(dt)
  love.audio.play(bgm)

  
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


  maRaquette.x = love.mouse.getX()
  
  if maRaquette.x < maRaquette.largeur/2 then
     maRaquette.x = maRaquette.largeur/2
  end
  
  if maRaquette.x > largeur - maRaquette.largeur/2 then
     maRaquette.x = largeur - maRaquette.largeur/2
  end
  
  if maBalle.colle == true then
    maBalle.x = maRaquette.x
    maBalle.y = maRaquette.y - maRaquette.hauteur/2 - maBalle.rayon
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
    
  
  
  
end

-- Fonction DRAW de Love2D
function love.draw()

  love.graphics.draw(imgBackground,0,0)
    local r,g,b
    local l,c
    local bx, by = 0,0
      for l=1,6 do
        bx = 0
        for c=1,15 do
          if monNiveau[l][c] == 1 then
            -- Dessine une brique
            love.graphics.rectangle("fill", bx +1 , by +1, maBrique.largeur -2 , maBrique.hauteur -2)
            
          end
          bx = bx + maBrique.largeur
        end
        by = by + maBrique.hauteur
      end
      
    -- Dessine la raquette
    love.graphics.setColor(0, 0, 228,100)
    love.graphics.rectangle("fill",maRaquette.x - (maRaquette.largeur/2), maRaquette.y - (maRaquette.hauteur/2) -10, maRaquette.largeur,     maRaquette.hauteur)
    
    -- Dessine la balle
    love.graphics.setColor(255, 0, 0, 100)
    love.graphics.circle("fill", maBalle.x, maBalle.y -10, maBalle.rayon)
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.print("Briques : "..compteurBriques, 0, hauteur/2)
    love.graphics.print("Vies : "..tostring(mesVies.valeur), 0, hauteur/2+30)

  if compteurBriques == 0 then
    
    love.graphics.print("Vous avez Gagné !!")
  end

end


-- Fonction qui se lance lorsque la souris est préssée
function love.mousepressed(x,y,n)
    if maBalle.colle == true then
        maBalle.colle = false
        maBalle.vx = 400
        maBalle.vy = -400
      end
end
  
-- Fonction qui se lance lorsque une touche est préssée
function love.keypressed(key)
  if key == "escape" then 
    love.event.quit()
  end
  
  print(key)
  
end