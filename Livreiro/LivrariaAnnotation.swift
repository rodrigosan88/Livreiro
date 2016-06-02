//
//  LivrariaAnnotation.swift
//  Livreiro
//
//  Created by iOS on 02/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit
import MapKit

class LivrariaAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title:String, subtitle:String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
}
