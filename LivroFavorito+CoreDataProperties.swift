//
//  LivroFavorito+CoreDataProperties.swift
//  Livreiro
//
//  Created by iOS on 01/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LivroFavorito {

    @NSManaged var titulo: String?
    @NSManaged var autor: String?
    @NSManaged var preco: String?
    @NSManaged var urlCapa: String?
    @NSManaged var descricao: String?

}
