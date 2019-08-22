local briqueManager = {}

local spriteManager = require("spriteManager")

briqueManager.list_briques = {}

function briqueManager:CreateBrick(pType, pName, pX, pY , pCouleur)
  
  local brique = spriteManager:CreateSprite("brique", pName, pX, pY)
 
  brique.isBroken = false
  brique.durability = 2
  
  brique.scaleX = 0.2
  brique.scaleY = 0.2
  brique.currentImage = pCouleur

    brique.images[1] = love.graphics.newImage("graphiques/Brick/Brick1.png")
    brique.images[2] = love.graphics.newImage("graphiques/Brick/Brick2.png")
    brique.images[3] = love.graphics.newImage("graphiques/Brick/Brick3.png")
    brique.images[4] = love.graphics.newImage("graphiques/Brick/Brick4.png")
    brique.images[5] = love.graphics.newImage("graphiques/Brick/Brick5.png")
    brique.images[6] = love.graphics.newImage("graphiques/Brick/Brick6.png")
    brique.images[7] = love.graphics.newImage("graphiques/Brick/Brick7.png")
    brique.images[8] = love.graphics.newImage("graphiques/Brick/Brick8.png")
    brique.images[9] = love.graphics.newImage("graphiques/Brick/Brick9.png")
    brique.images[10] = love.graphics.newImage("graphiques/Brick/Brick10.png")

    brique.imagesBroken = {}
    brique.imagesBroken[1] = love.graphics.newImage("graphiques/Brick/Brick1Broken.png")
    brique.imagesBroken[2] = love.graphics.newImage("graphiques/Brick/Brick2Broken.png")
    brique.imagesBroken[3] = love.graphics.newImage("graphiques/Brick/Brick3Broken.png")
    brique.imagesBroken[4] = love.graphics.newImage("graphiques/Brick/Brick4Broken.png")
    brique.imagesBroken[5] = love.graphics.newImage("graphiques/Brick/Brick5Broken.png")
    brique.imagesBroken[6] = love.graphics.newImage("graphiques/Brick/Brick6Broken.png")
    brique.imagesBroken[7] = love.graphics.newImage("graphiques/Brick/Brick7Broken.png")
    brique.imagesBroken[8] = love.graphics.newImage("graphiques/Brick/Brick8Broken.png")
    brique.imagesBroken[9] = love.graphics.newImage("graphiques/Brick/Brick9Broken.png")
    brique.imagesBroken[10] = love.graphics.newImage("graphiques/Brick/Brick10Broken.png")

    brique.largeur = brique.images[1]:getWidth() * brique.scaleX 
    brique.hauteur = brique.images[1]:getHeight() * brique.scaleY 

    brique.oX = 0
    brique.oY = 0
 

  if (pType == "Classique") then
    brique.durability = 1

  end

table.insert(briqueManager.list_briques, brique)
  
return brique
  
end

function briqueManager:Update(dt)

    if #briqueManager.list_briques~=0 then
      
      for i = #briqueManager.list_briques, 1, -1 do
      
        local b = briqueManager.list_briques[i]
        
        if b.delete == true then

          table.remove(briqueManager.list_briques, i)

        end 

      end
      
    end
        
end

--[[
function briqueManager:Draw()
  
  if #briqueManager.list_briques~=nil then

    for i = 1, #briqueManager.list_briques do
      
      local b = briqueManager.list_briques[i]
      
      love.graphics.draw(b.images[math.floor(b.currentImage)], 
        b.posX, b.posY, 0, b.scaleX, b.scaleY, b.oX, b.oY)

        b:draw()
                        
    end

  end

end
]]--

return briqueManager
