local menuManager = {}
local gameState = require("gameState")

-- Ecran titre
function menuManager:EcranTitreLoad()
    self.backgroundMenuTitre = love.graphics.newImage("graphiques/Background/BackgroundMenu.png")
    self.myButton1 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton2 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton3 = love.graphics.newImage("graphiques/Gui/grey_button00.png")

    self.myCursor = {}
    self.myCursor.image = love.graphics.newImage("graphiques/Star/Etoile.png")
    self.myCursor.x = 330
    self.myCursor.y = 200
    self.myCursor.scaleX = 0.3
    self.myCursor.scaleY = 0.3
    self.myCursor.pos = 1
    
    fontClassique = love.graphics.getFont()
    fontMenuTitre = love.graphics.setNewFont(40) 
    fontLabelMenu  = love.graphics.setNewFont(20)
     
 end

function menuManager:EcranTitreUpdate(dt)

    if self.myCursor.pos < 1 then
        self.myCursor.pos = 1
    end

    if self.myCursor.pos > 3 then
        self.myCursor.pos = 3
    end

    if self.myCursor.pos == 1 then
            self.myCursor.y = 200
    elseif self.myCursor.pos == 2 then   
            self.myCursor.y = 300
    elseif self.myCursor.pos == 3 then     
            self.myCursor.y = 400
    end

end

function menuManager:EcranTitreDraw()

    local r,g,b = love.graphics.getColor() 
    local c = self.myCursor
    love.graphics.draw(self.backgroundMenuTitre, 0, 0)

    love.graphics.draw(self.myButton1, 400, 200)
    love.graphics.draw(self.myButton2, 400, 300)
    love.graphics.draw(self.myButton3, 400, 400)

    love.graphics.draw(c.image, c.x, c.y, 0, c.scaleX, c.scaleY)

    love.graphics.setFont(fontMenuTitre)
    love.graphics.print("SPACE BRICK", 365, 85)
    
    love.graphics.setColor(0.8, 0, 0) -- Rouge
    love.graphics.setFont(fontLabelMenu)
    love.graphics.print("Nouvelle Partie", 420, 210)
    love.graphics.print("Charger Partie", 422, 310)
    love.graphics.print("Quitter", 460, 410)

    love.graphics.setColor(0, 0, 0) 
    love.graphics.print("Appuyez sur Espace pour continuer", 320, 500)

    love.graphics.setFont(fontMenuTitre)
    love.graphics.setColor(0.8, 0, 0) -- Rouge
    love.graphics.print("by Moks", 810, 550)
    
    love.graphics.setFont(fontClassique)
    love.graphics.setColor(r,g,b)
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
