//
//  Livro.swift
//  Livreiro
//
//  Created by iOS on 31/05/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import Foundation

class Livro {
    
    var titulo : String
    var autor: String
    var editora: String
    var preco: Double
    var urlCapa: String
    var qtdPaginas: Int
    
    init (titulo: String, autor:String, editora: String, preco: Double, urlCapa: String, qtdPaginas:Int){
        self.titulo = titulo
        self.autor = autor
        self.editora = editora
        self.preco = preco
        self.urlCapa = urlCapa
        self.qtdPaginas = qtdPaginas
    }
    
    func getTitulo() -> String {
        return self.titulo
    }

    func getAutor() -> String {
        return self.autor
    }

}
