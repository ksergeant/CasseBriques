local balleManager = {}
local spriteManager = require("spriteManager")

balleManager.list_balle = {}

function balleManager:CreateBall(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local balle = spriteManager:CreateSprite("balle", pName, pTableauImages, pNombreFrames)
 
  balle.posX = 0
  balle.posY = 0
  balle.isBroken = false
  balle.durability = 0
  
  balle.images = {}
  balle.imagesBroken = {}
  balle.images[1] = "graphiques/Brick/Brick1.png"
  balle.images[2] = "graphiques/Brick/Brick2.png"
  balle.images[3] = "graphiques/Brick/Brick3.png"
  balle.images[4] = "graphiques/Brick/Brick4.png"
  balle.images[5] = "graphiques/Brick/Brick5.png"
  balle.images[6] = "graphiques/Brick/Brick6.png"
  balle.images[7] = "graphiques/Brick/Brick7.png"
  balle.images[8] = "graphiques/Brick/Brick8.png"
  balle.images[9] = "graphiques/Brick/Brick9.png"
  balle.images[10] = "graphiques/Brick/Brick10.png"
  
  balle.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  balle.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  balle.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  balle.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  balle.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  balle.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  balle.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  balle.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  balle.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  balle.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    balle.durability = 1

  end
  balle.largeur = balle.images[1]:getWidth()
  balle.hauteur = balle.images[1]:getHeight()

  table.insert(balleManager.list_sprites, balle)
  
  print("balle Create")

  return balle
  
end



function balleManager:Update(dt)
  
    if #balleManager.list_sprites~=nil then
      
      for i = 1, #balleManager.list_sprites do
      
        local s = balleManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(balleManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function balleManager:Draw()
  
  if #balleManager.list_sprites~=nil then

    for i = 1, #balleManager.list_sprites do
      
      local s = balleManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return balleManager
