local gameState = {}

gameState.Debug = false
gameState.vies = 3
gameState.viesMax = 9
gameState.niveauActuel = 1
gameState.score = 0
gameState.meilleurScore = 1000
gameState.largeur = love.graphics.getWidth()
gameState.hauteur = love.graphics.getHeight()
gameState.myBalle = {}
gameState.ecranCourant = "Titre"

return gameState