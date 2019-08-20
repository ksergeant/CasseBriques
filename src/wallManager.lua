local wallManager = {}
local spriteManager = require("spriteManager")

wallManager.list_walls = {}

function wallManager:CreateWall(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local wall = spriteManager:CreateSprite("wall", pName, pTableauImages, pNombreFrames)
 
  wall.posX = 0
  wall.posY = 0
  wall.isBroken = false
  wall.durability = 0
  
  wall.images = {}
  wall.imagesBroken = {}
  wall.images[1] = "graphiques/Brick/Brick1.png"
  wall.images[2] = "graphiques/Brick/Brick2.png"
  wall.images[3] = "graphiques/Brick/Brick3.png"
  wall.images[4] = "graphiques/Brick/Brick4.png"
  wall.images[5] = "graphiques/Brick/Brick5.png"
  wall.images[6] = "graphiques/Brick/Brick6.png"
  wall.images[7] = "graphiques/Brick/Brick7.png"
  wall.images[8] = "graphiques/Brick/Brick8.png"
  wall.images[9] = "graphiques/Brick/Brick9.png"
  wall.images[10] = "graphiques/Brick/Brick10.png"
  
  wall.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  wall.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  wall.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  wall.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  wall.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  wall.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  wall.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  wall.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  wall.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  wall.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    wall.durability = 1

  end
  wall.largeur = wall.images[1]:getWidth()
  wall.hauteur = wall.images[1]:getHeight()

  table.insert(wallManager.list_sprites, wall)
  
  print("wall Create")

  return wall
  
end



function wallManager:Update(dt)
  
    if #wallManager.list_sprites~=nil then
      
      for i = 1, #wallManager.list_sprites do
      
        local s = wallManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(wallManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function wallManager:Draw()
  
  if #wallManager.list_sprites~=nil then

    for i = 1, #wallManager.list_sprites do
      
      local s = wallManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return wallManager
