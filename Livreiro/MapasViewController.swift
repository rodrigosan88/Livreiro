//
//  MapasViewController.swift
//  Livreiro
//
//  Created by iOS on 02/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapasViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate{

    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 500.0
        
        // Heading - 11/12
        locationManager.headingFilter = 5.0
        
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let textoBusca = searchBar.text!
        
        let locationRequest:MKLocalSearchRequest = MKLocalSearchRequest()
        
        locationRequest.naturalLanguageQuery = textoBusca
        
        if let ul = self.locationManager.location{
            locationRequest.region = MKCoordinateRegionMakeWithDistance(ul.coordinate, 3_000, 3_000)
        }
        
        let locationSearch:MKLocalSearch = MKLocalSearch(request: locationRequest)
        
        locationSearch.startWithCompletionHandler({
            response, error in
            
            if let res = response{
                var locais:[LivrariaAnnotation] = []
                
                for item in res.mapItems{
                    
                    let livraria = LivrariaAnnotation(coordinate: item.placemark.coordinate, title: item.placemark.title ?? "Vazio", subtitle: "B")
                    
                    locais.append(livraria)
                }
                
                self.mapa.removeAnnotations(self.mapa.annotations)
                self.mapa.showAnnotations(locais, animated: true)
                
                searchBar.resignFirstResponder()
            }
            else{
                let alerta:UIAlertController = UIAlertController(title: "Erro", message: "Não foi possível encontrar o endereço", preferredStyle: UIAlertControllerStyle.Alert)
                
                alerta.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { action in print("Cancelou") }))
                
                alerta.addAction(UIAlertAction(title: "Permitir", style: UIAlertActionStyle.Default, handler: { action in print("Permitiu") }))
                
                self.presentViewController(alerta, animated: true, completion: nil)
            }
        })
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // GESTOS
    
    @IBAction func marcarPino(sender: AnyObject) {
        
        let gesto : UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
        
        if(gesto.state == .Began){
            let tappedPoint : CGPoint = gesto.locationInView(self.mapa)
            let coordenada: CLLocationCoordinate2D = self.mapa.convertPoint(tappedPoint, toCoordinateFromView: self.mapa)
            let pin: LivrariaAnnotation = LivrariaAnnotation(coordinate: coordenada, title: "Pino", subtitle: "Meu mapa")
            self.mapa.addAnnotation(pin)
        }
        
    }
    
    // FUNCOES AUXILIARES DO MAPA
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locationManager.location{
            self.mapa.setRegion(MKCoordinateRegionMakeWithDistance(loc.coordinate, 600,600), animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("callout")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView: MKAnnotationView?
        
        if(!annotation.isKindOfClass(MKUserLocation.classForCoder())){
            let livrariaAnnotation: LivrariaAnnotation = annotation as! LivrariaAnnotation
            
            if let pin = mapa.dequeueReusableAnnotationViewWithIdentifier("pinLivraria"){
                
                pinView = pin
            }
            else{
                // Para pinos customizados ou genericos
                //pinView = MKAnnotationView(annotation: livrariaAnnotation, reuseIdentifier: "pinLivraria")
                pinView = MKPinAnnotationView(annotation: livrariaAnnotation, reuseIdentifier: "pinLivraria")
                pinView!.tintColor = UIColor.greenColor()
                pinView!.canShowCallout = true
                
                
                
                //pinView!.image = UIImage(named: "newIcon_40.png")
                
                //pinView!.centerOffset = CGPointMake(0, (-1) * (pinView!.image!.size.height / 2))
                
                let btnPin: UIButton = UIButton(type: .DetailDisclosure)
                pinView!.rightCalloutAccessoryView = btnPin
                
            }
        }
        
        return pinView
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
