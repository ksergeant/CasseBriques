local menuManager = {}
local gameState = require("gameState")

-- Ecran titre
function menuManager:EcranTitreUpdate(dt)
    self.backgroundMenuTitre = love.graphics.newImage("graphiques/Background/BackgroundMenu.png")
    self.myButton1 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton2 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton3 = love.graphics.newImage("graphiques/Gui/grey_button00.png")

end

function menuManager:EcranTitreDraw()
    love.graphics.draw(self.backgroundMenuTitre, 0, 0)
    love.graphics.setNewFont(40)  
    love.graphics.print("SPACE BRICK", 365, 85)
    love.graphics.draw(self.myButton1, 400, 200)
    love.graphics.draw(self.myButton2, 400, 300)
    love.graphics.draw(self.myButton3, 400, 400)



end

-- Ecran Jeu
function menuManager:EcranJeuUpdate(dt)
       
end

function menuManager:EcranJeuDraw()
    
end

-- Ecran GameOver
function menuManager:EcranGameoverUpdate(dt)
       
end

function menuManager:EcranGameoverDraw()
    
end


return menuManager
