local briqueManager = {}

local spriteManager = require("spriteManager")

briqueManager.list_briques = {}

function briqueManager:CreateBrick(pType, pName, pX, pY , pCouleur)
  
  local brique = spriteManager:CreateSprite("Brique", pName, pX, pY)
 
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

    brique.oX = brique.images[1]:getWidth()/2
    brique.oY = brique.images[1]:getHeight()/2
    brique.perimetre = math.floor((brique.largeur * 2) + (brique.hauteur * 2))

    brique.pointColli1 = {}
    brique.pointColli1.posX = brique.posX
    brique.pointColli1.posY = brique.posY

    brique.pointColli2 = {}
    brique.pointColli2.posX = brique.posX + brique.largeur
    brique.pointColli2.posY = brique.posY

    brique.pointColli3 = {}
    brique.pointColli3.posX = brique.posX + brique.largeur
    brique.pointColli3.posY = brique.posY + brique.hauteur
    
    brique.pointColli4 = {}
    brique.pointColli4.posX = brique.posX
    brique.pointColli4.posY = brique.posY + brique.hauteur

    print(brique.perimetre)
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


function briqueManager:Draw()
  
  if #briqueManager.list_briques~=0 then

    for i = 1, #briqueManager.list_briques do
      
      local b = briqueManager.list_briques[i]
      
        --b:draw()
                        
    end

  end

end


return briqueManager
