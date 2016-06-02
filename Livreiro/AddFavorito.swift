//
//  AddFavorito.swift
//  Livreiro
//
//  Created by iOS on 01/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit

class AddFavorito: UIActivity {
    
    let livrosDAO: LivroFavoritoDAO?
    
    init(livrosDAO: LivroFavoritoDAO){
        self.livrosDAO = livrosDAO
    }
    
    override func activityType()->String?{
        return "AddFavorito"
    }
    
    override func activityTitle()->String?{
        return "Add Favorito"
    }
    
    override func performActivity(){
        livrosDAO!.salvar()
    }
}
