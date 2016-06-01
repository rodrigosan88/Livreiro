//
//  FavoritosTableViewController.swift
//  Livreiro
//
//  Created by iOS on 01/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController {

    var livros: [Livro] = []
    var livrosFavoritos : [LivroFavorito]?
    let livroFavoritosDAO : LivroFavoritoDAO = LivroFavoritoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.livros = []
        
        livrosFavoritos = livroFavoritosDAO.obterLivros()
        
        for livroFavorito in livrosFavoritos!{
            let livro : Livro = Livro(titulo: livroFavorito.titulo!, autor: livroFavorito.autor!)
            livro.preco = livroFavorito.preco
            livro.descricao = livroFavorito.descricao
            livro.urlCapa = livroFavorito.urlCapa
            
            self.livros.append(livro)
            
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.livros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("minhaCelula", forIndexPath: indexPath) as! CelulaLivros
        
        // Configure the cell...
        let livro = livros[indexPath.row]
        
        cell.lbTitulo?.text = livro.titulo
        cell.lbAutor?.text = livro.autor
        cell.lbPreco?.text = livro.preco
        cell.imgLivro?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: livro.getUrlCapa())!)!)
        
        return cell
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let livroFavoritoExcluir : LivroFavorito = self.livrosFavoritos![indexPath.row]
            do{
                try livroFavoritosDAO.apagar(livroFavoritoExcluir)
                
                self.livrosFavoritos!.removeAtIndex(indexPath.row)
                self.livros.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                let alerta = UIAlertController(title: "Informação", message: "O registro foi apagado com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
                
                alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil ))
                
                self.presentViewController(alerta, animated: true, completion: nil)
                
            } catch(ExcecoesDados.Delete) {
                print("TESTE")
            } catch {}
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let detalhes: DetalheViewController = segue.destinationViewController as! DetalheViewController

        detalhes.livroAtual = self.livros[self.tableView.indexPathForCell(sender! as! (CelulaLivros))!.row]
    }
    
    


}
