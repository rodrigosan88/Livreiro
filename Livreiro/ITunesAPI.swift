//
//  ITunesAPI.swift
//  Livreiro
//
//  Created by iOS on 31/05/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import Foundation

protocol APIProtocol{
    func dadosRecebidos(dados: NSDictionary)
}

class ITunesAPI: NSObject{
    var data:NSMutableData = NSMutableData()
    var delegate: APIProtocol?
    
    // Busca no iTunes
    func searchItunesFor(searchTerm: String) {
        
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+",
            options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
        
        let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=ebook&limit=200"
        
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        
        connection.start()
    }
    
    // Falha ao conectar - não conectado
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        print("Falhou com o seguinte erro:\(error.localizedDescription)")
    }
    
    // Estabelece conexão
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    // Recebimento de dados
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    // Fim do download de dados
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        do{
            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(self.data,
                options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            delegate?.dadosRecebidos(jsonResult)
        }
        catch{
            print("Deu zebra")
        }
    }
}