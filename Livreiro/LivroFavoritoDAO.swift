import UIKit
import CoreData

enum ExcecoesDados: ErrorType{
    case Delete, Insert, Query
}

class LivroFavoritoDAO{
    let moc: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func novo()->LivroFavorito{
        let livroFavorito: LivroFavorito = NSEntityDescription.insertNewObjectForEntityForName("LivroFavorito", inManagedObjectContext: moc) as! LivroFavorito
        
        return livroFavorito
    }
    
    func salvar(){
        do{
            try moc.save()
            
            print("Salvo com sucesso")
        }
        catch {
            print("Deu zebra")
        }
    }
    
    func obterLivros()->[LivroFavorito]{
        var saida: [LivroFavorito] = [LivroFavorito]()
        
        let req: NSFetchRequest = NSFetchRequest()
        
        req.entity = NSEntityDescription.entityForName("LivroFavorito", inManagedObjectContext: moc)
        
        do {
            saida = try (moc.executeFetchRequest(req) as! [LivroFavorito])
        }
        catch{
            print("Deu zebra")
        }
        
        print("Saida \(saida.count)")
        
        return saida
    }
    
    func apagar(livro: LivroFavorito) throws{
        moc.deleteObject(livro)
        
        do{
            try moc.save()
        }
        catch{
            throw ExcecoesDados.Delete
        }
    }
}
