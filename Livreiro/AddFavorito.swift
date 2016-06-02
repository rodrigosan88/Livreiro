//
//  AddFavorito.swift
//  Livreiro
//
//  Created by iOS on 01/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit

class AddFavorito: UIActivity {
    
    let livro: Livro?
    
    init(livro: Livro){
        self.livro = livro
    }
    
    override func activityType()->String?{
        return "br.com.begyn.AddLivro"
    }
    
    override func activityTitle()->String?{
        return "Add Favorito"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        salvarLivro()
    }
    
    func salvarLivro(){
        let livrosDAO: LivroFavoritoDAO = LivroFavoritoDAO()
        let livroFavorito: LivroFavorito = livrosDAO.novo()
        
        livroFavorito.autor = livro!.getAutor()
        livroFavorito.titulo = livro!.getTitulo()
        livroFavorito.preco = livro!.getPreco()
        livroFavorito.descricao = livro!.getDescricao()
        livroFavorito.urlCapa = livro!.getUrlCapa()
        
        livrosDAO.salvar()
    }
}
