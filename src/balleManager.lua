local balleManager = {}
local spriteManager = require("spriteManager")

balleManager.list_balls = {}

function balleManager:CreateBall(pType, pName, pX, pY)
  
  local balle = spriteManager:CreateSprite("Balle", pName, pX, pY)
 
  balle.images = {}
 
  balle.colle = false
  balle.scaleX = 0.2
  balle.scaleY = 0.2
  balle.rayon = 4
  balle.vx = 0
  balle.vy = 0
  balle.destinationX = 0
  balle.destinationY = 0
  balle.destinationAngle = 0
  balle.vitesse = 1
  balle.images[1] = love.graphics.newImage("graphiques/Star/Balle.png")
  balle.largeur = balle.images[1]:getWidth() * balle.scaleX
  balle.hauteur = balle.images[1]:getHeight() * balle.scaleY
  balle.oX = balle.images[1]:getWidth()/2
  balle.oY = balle.images[1]:getHeight()/2

  table.insert(balleManager.list_balls, balle)
  
  print("balle Create")

  return balle
  
end

function balleManager:Update(dt)
  
    if #balleManager.list_balls~=0 then
      
      for i = #balleManager.list_balls, 1, -1 do
      
        local ball = balleManager.list_balls[i]
        
        if ball.delete == true then

          table.remove(balleManager.list_balls, i)

        end 

        
      end
      
    end

        
end

function balleManager:Draw()
  
  if #balleManager.list_balls~=nil then

    for i = 1, #balleManager.list_balls do
      
      local ball = balleManager.list_balls[i]
      
      love.graphics.draw(ball.images[math.floor(ball.currentImage)], 
        ball.posX, ball.posY, 0, ball.scaleX, ball.scaleY, ball.oX, ball.oY)

       -- ball:draw()
                        
    end

  end

end

return balleManager
