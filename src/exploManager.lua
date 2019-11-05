local exploManager = {}
local spriteManager = require("spriteManager")

exploManager.list_explo = {}

function exploManager:CreateExplo(pType, pName, pX, pY)
  
  local explo = spriteManager:CreateSprite("Explo", pName, pX, pY)
 
  explo.posX = pX
  explo.posY = pY
  explo.scaleX = 0.4
  explo.scaleY = 0.4
  explo.isAnimed = true
  explo.images = {}

  explo.images[1] = love.graphics.newImage("graphiques/Explo/Explo1.png")
  explo.images[2] = love.graphics.newImage("graphiques/Explo/Explo2.png")
  explo.images[3] = love.graphics.newImage("graphiques/Explo/Explo3.png")
  explo.images[4] = love.graphics.newImage("graphiques/Explo/Explo4.png")
  explo.images[5] = love.graphics.newImage("graphiques/Explo/Explo5.png")
  explo.images[6] = love.graphics.newImage("graphiques/Explo/Explo6.png")
  explo.images[7] = love.graphics.newImage("graphiques/Explo/Explo7.png")
  explo.images[8] = love.graphics.newImage("graphiques/Explo/Explo8.png")
  explo.images[9] = love.graphics.newImage("graphiques/Explo/Explo9.png")

  explo.oX = explo.images[1]:getWidth()/2
  explo.oY = explo.images[1]:getHeight()/2
  
  explo.largeur = explo.images[1]:getWidth() * explo.scaleX
  explo.hauteur = explo.images[1]:getHeight() * explo.scaleY

  table.insert(exploManager.list_explo, explo)
  
  print("explo Create")

  return explo
  
end



function exploManager:Update(dt)
  
    if #exploManager.list_explo~=nil then
      
      for i =  #exploManager.list_explo, 1, -1 do
      
        local e = exploManager.list_explo[i]
        
        if e.delete == true then

          table.remove(exploManager.list_explo, i)

        end 

        if e.isAnimed == true then
            e:anime()
        end

          
      end
      
    end
        
end

function exploManager:Draw()
  
  if #exploManager.list_explo~=nil then

    for i = 1, #exploManager.list_explo do
      
      local e = exploManager.list_explo[i]
      
      love.graphics.draw(e.images[math.floor(e.currentImage)], 
        e.posX, e.posY, 0, e.scaleX, e.scaleY, e.oX, e.oY)

        e:draw()
                        
    end

  end

end

return exploManager
