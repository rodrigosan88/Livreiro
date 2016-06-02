//
//  DetalheViewController.swift
//  Livreiro
//
//  Created by iOS on 01/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {
    
    var livroAtual: Livro?
    
    var livroFavoritoDAO : LivroFavoritoDAO = LivroFavoritoDAO()

    @IBOutlet weak var imgCapa: UIImageView!
    
    @IBOutlet weak var lbTitulo: UILabel!
    
    @IBOutlet weak var lbAutor: UILabel!
    
    @IBOutlet weak var txDescricao: UITextView!
    
    @IBOutlet weak var lbPreco: UILabel!
    
    @IBAction func compartilhar(sender: AnyObject) {
        let shareItems = [livroAtual!.autor, livroAtual!.titulo]
        let addFavorito: AddFavorito = AddFavorito(livrosDAO: self.livroFavoritoDAO)
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        
        
        //activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarLivro(self.livroAtual!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carregarLivro(livro:Livro){
        self.lbTitulo.text = livro.getTitulo()
        self.lbAutor.text = livro.getAutor()
        self.lbPreco.text = livro.getPreco()
        self.imgCapa.image = UIImage(data: NSData(contentsOfURL: NSURL(string: livro.getUrlCapa())!)!)
        //self.txDescricao.text = livro.getDescricao()
        
        var str: NSAttributedString?
        
        do{
            str = try NSAttributedString(data: livro.getDescricao().dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        }
        catch{
            str = NSAttributedString(string: "")
        }
        
        self.txDescricao.attributedText = str
        
    }

    @IBAction func salvarLivroFavorito(sender: AnyObject) {
        let livroFavorito: LivroFavorito = livroFravoritoDAO.novo()
        
        livroFavorito.autor = livroAtual?.getAutor()
        livroFavorito.titulo = livroAtual?.getTitulo()
        livroFavorito.urlCapa = livroAtual?.getUrlCapa()
        livroFavorito.preco = livroAtual?.getPreco()
        livroFavorito.descricao = livroAtual?.getDescricao()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
