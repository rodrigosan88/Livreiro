//
//  CelulaLivros.swift
//  Livreiro
//
//  Created by iOS on 31/05/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit

class CelulaLivros: UITableViewCell {

    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var imgLivro: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
