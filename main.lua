
-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- variable VIES
local vies = {}

-- variable RAQUETTE
local raquette = {}
raquette.x = 0
raquette.y = 0
raquette.largeur = 100
raquette.hauteur = 23

-- variable BALLE
local balle = {}
balle.x = 0
balle.y = 0
balle.rayon = 10
balle.colle = false
balle.vx = 0
balle.vy = 0

-- variable BRIQUE
local brique = {}

-- variable NIVEAU
local niveau = {}

-- Fonction qui initialise le programme
function Demarre()
  balle.colle = true
  vies = 3
  
  local l,c
  
  for l=1,6 do
    niveau[l] = {}
    for c=1,15 do
      niveau[l][c] = 1
    end
  end
  
end

-- Fonction LOAD de Love2D
function love.load()
  love.window.setMode(1000,600,fullscreentype)
  love.window.setTitle("Magic Brick 1.0")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  brique.hauteur = 25
  brique.largeur = largeur / 15
  
  print("Largeur : ",largeur)
  print("Hauteur : ",hauteur)
  
  raquette.y = hauteur - (raquette.hauteur/2)
  Demarre()
  
end

-- Fonction UPDATE de Love2D
function love.update(dt)
  
  raquette.x = love.mouse.getX()
  
  if raquette.x < raquette.largeur/2 then
     raquette.x = raquette.largeur/2
  end
  
  if raquette.x > largeur - raquette.largeur/2 then
     raquette.x = largeur - raquette.largeur/2
  end
  
  if balle.colle == true then
    balle.x = raquette.x
    balle.y = raquette.y - raquette.hauteur/2 - balle.rayon
  else
    balle.x = balle.x +(balle.vx*dt)
    balle.y = balle.y +(balle.vy*dt)
  end
  
  local c = math.floor(balle.x / brique.largeur) +1
  local l = math.floor(balle.y / brique.hauteur) +1
  
  if l >= 1 and l <= #niveau and c >= 1 and c <= 15 then
    if niveau[l][c] == 1 then
      balle.vy = 0 - balle.vy
      niveau[l][c] = 0
    end
  end
  
  if balle.x > largeur then
    balle.vx =  0 - balle.vx
    balle.x = largeur
  end
  
  if balle.x < 0 then
    balle.vx = 0 - balle.vx
    balle.x = 0
  end
  
  if balle.y < 0 then
     balle.vy = 0 - balle.vy
     balle.y = 0
  end
  
  if balle.y > hauteur then 
    -- on perd une balle
    vies = vies - 1
    balle.colle = true
  end
  
  if vies  <1 then
    love.event.quit()
  end
  
  -- Tester collision avec la raquette
  local posCollisionRaquette = raquette.y - (raquette.hauteur/2) - balle.rayon
  if balle.y > posCollisionRaquette then
    local dist = math.abs(raquette.x - balle.x)
    if dist < raquette.largeur/2 then
      balle.vy = 0 - balle.vy
      balle.y = posCollisionRaquette
      end
    end
  
end

-- Fonction DRAW de Love2D
function love.draw()
    local r,g,b
    local l,c
    local bx, by = 0,0
      for l=1,6 do
        bx = 0
        for c=1,15 do
          if niveau[l][c] == 1 then
            -- Dessine une brique
            love.graphics.rectangle("fill", bx +1 , by +1, brique.largeur -2 , brique.hauteur -2)
          end
          bx = bx + brique.largeur
        end
        by = by + brique.hauteur
      end
      
    -- Dessine la raquette
    love.graphics.setColor(0, 0, 228,100)
    love.graphics.rectangle("fill",raquette.x - (raquette.largeur/2), raquette.y - (raquette.hauteur/2) -10, raquette.largeur,     raquette.hauteur)
    
    -- Dessine la balle
    love.graphics.setColor(255, 0, 0, 100)
    love.graphics.circle("fill", balle.x, balle.y -10, balle.rayon)
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.print("Briques : "..#niveau, 0, hauteur/2)
    love.graphics.print("Vies : "..tostring(vies), 0, hauteur/2+30)


end


-- Fonction qui se lance lorsque la souris est préssée
function love.mousepressed(x,y,n)
    if balle.colle == true then
        balle.colle = false
        balle.vx = 400
        balle.vy = -400
      end
end
  
-- Fonction qui se lance lorsque une touche est préssée
function love.keypressed(key)
  if key == "escape" then 
    love.event.quit()
  end
  
  print(key)
  
end