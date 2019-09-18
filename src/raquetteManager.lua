local raquetteManager = {}
local spriteManager = require("spriteManager")

raquetteManager.list_raquettes = {}

function raquetteManager:CreateRaquette(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local raquette = spriteManager:CreateSprite("raquette", pName, pTableauImages, pNombreFrames)
 
  raquette.posX = 0
  raquette.posY = 0
  raquette.isBroken = false
  raquette.durability = 0
  
  raquette.images = {}
  raquette.imagesBroken = {}
  raquette.images[1] = "graphiques/Brick/Brick1.png"
  raquette.images[2] = "graphiques/Brick/Brick2.png"
  raquette.images[3] = "graphiques/Brick/Brick3.png"
  raquette.images[4] = "graphiques/Brick/Brick4.png"
  raquette.images[5] = "graphiques/Brick/Brick5.png"
  raquette.images[6] = "graphiques/Brick/Brick6.png"
  raquette.images[7] = "graphiques/Brick/Brick7.png"
  raquette.images[8] = "graphiques/Brick/Brick8.png"
  raquette.images[9] = "graphiques/Brick/Brick9.png"
  raquette.images[10] = "graphiques/Brick/Brick10.png"
  
  raquette.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  raquette.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  raquette.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  raquette.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  raquette.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  raquette.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  raquette.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  raquette.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  raquette.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  raquette.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    raquette.durability = 1

  end
  raquette.largeur = raquette.images[1]:getWidth()
  raquette.hauteur = raquette.images[1]:getHeight()

  table.insert(raquetteManager.list_sprites, raquette)
  
  print("raquette Create")

  return raquette
  
end



function raquetteManager:Update(dt)
  
    if #raquetteManager.list_sprites~=nil then
      
      for i = 1, #raquetteManager.list_sprites do
      
        local s = raquetteManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(raquetteManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function raquetteManager:Draw()
  
  if #raquetteManager.list_sprites~=nil then

    for i = 1, #raquetteManager.list_sprites do
      
      local s = raquetteManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return raquetteManager
