local wallManager = {}
local spriteManager = require("spriteManager")

wallManager.list_walls = {}

function wallManager:CreateWall(pType, pName, pX, pY, pCouleur)
  
  local wall = spriteManager:CreateSprite("Wall", pName, pX, pY)
 
  wall.isBroken = false
  wall.durability = 0
  wall.images = {}
    wall.scaleX = 0.3
    wall.scaleY = 0.3
    wall.currentImage = pCouleur
    wall.images[1] = love.graphics.newImage("graphiques/Wall/Wall1.png")
    wall.images[2] = love.graphics.newImage("graphiques/Wall/Wall2.png")
    wall.images[3] = love.graphics.newImage("graphiques/Wall/Wall3.png")
    wall.images[4] = love.graphics.newImage("graphiques/Wall/Wall4.png")
    wall.images[5] = love.graphics.newImage("graphiques/Wall/Wall5.png")
    wall.images[6] = love.graphics.newImage("graphiques/Wall/Wall6.png")
    wall.images[7] = love.graphics.newImage("graphiques/Wall/Wall7.png")
    wall.images[8] = love.graphics.newImage("graphiques/Wall/Wall8.png")
    wall.images[9] = love.graphics.newImage("graphiques/Wall/Wall9.png")
    wall.images[10] = love.graphics.newImage("graphiques/Wall/Wall10.png")

    wall.largeur = wall.images[1]:getWidth() * wall.scaleX 
    wall.hauteur = wall.images[1]:getHeight() * wall.scaleY 

    wall.oX = wall.images[1]:getWidth()/2
    wall.oY = wall.images[1]:getHeight()/2

  table.insert(wallManager.list_walls, wall)
  
  print("wall Create")

  return wall
  
end


function wallManager:Update(dt)
  
  if #wallManager.list_walls~=0 then
      
    for i = #wallManager.list_walls, 1, -1 do
    
      local w = wallManager.list_walls[i]
      
      if w.delete == true then

        table.remove(wallManager.list_walls, i)

      end 

    end
    
  end
    
        
end

function wallManager:Draw()
  
  if #wallManager.list_walls~=nil then

    for i = 1, #wallManager.list_walls do
      
                         
    end

  end

end

return wallManager
