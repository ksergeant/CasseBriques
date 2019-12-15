local partieManager = {}
partieManager.list_parties = {}

function partieManager:CreatePartie(pName)

    local partie = {}
    partie.name = pName

    
    
    table.insert(self.list_parties, partie)

    print("Partie Create")
end

function partieManager:NouvelleUpdate(dt)


end

function partieManager:NouvelleDraw()
    love.graphics.print("Veuillez choisir un nom de partie ...")
   
end

function partieManager:ChargerUpdate(dt)

    

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