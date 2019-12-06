local partieManager = {}
partieManager.list_parties = {}

function partieManager:CreatePartie(pName)

    local partie = {}
    partie.name = pName

    local nombrePartie = #self.list_parties
    if nombrePartie == nil then
        nombrePartie = 1
    end 
    table.insert(self.list_parties, nombrePartie, partie)

    print("Partie Create")
end

function partieManager:NouvelleUpdate(dt)


end

function partieManager:NouvelleDraw()
    love.graphics.print("Veuillez choisir un nom de partie ...")
   
end

function partieManager:ChargerUpdate(dt)

    if #partieManager.list_parties~=nil then
      
        for i = #partieManager.list_parties, 1, -1 do
        
          local p = partieManager.list_parties[i]
          
  
        end
        
      end

end

function partieManager:ChargerDraw()

    local decal = 0
    love.graphics.print("Liste de parties ", 450 , 10)
    if #partieManager.list_parties~=nil then
      
        for i = #partieManager.list_parties, 1, -1 do
        
          local p = partieManager.list_parties[i]
          
            love.graphics.print(p.name,475,100 + decal)
            decal = decal + 50
        end
        
      end

end

return partieManager