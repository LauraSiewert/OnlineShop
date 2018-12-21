//
//  MapViewController.swift
//  OnlineShop
//
//  Created by Laura Siewert on 20.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var locations: [MKPointAnnotation] = []
    var lastUserLocation: MKUserLocation?
    var isUserInteraction: Bool = true
    
    @IBOutlet weak var myMapView: UITableView!
    @IBOutlet weak var storeMapView: MKMapView!
    
    override func viewDidLoad() {
        self.createAnnotations()
        super.viewDidLoad()

        storeMapView.showsUserLocation = true
        
    }
    
    func createAnnotations(){
        let anno1 :  MKPointAnnotation = MKPointAnnotation()
        anno1.coordinate = CLLocationCoordinate2DMake(40.72852712, -74.24629211)
        anno1.title = "Location 1"
        self.locations.append(anno1)
        
        self.storeMapView.addAnnotations(locations)
    }
    
    @IBAction func didPressButton(_ sender: Any) {
        if self.lastUserLocation != nil {
            let region: MKCoordinateRegion = MKCoordinateRegion(center: lastUserLocation!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.storeMapView.setRegion(region, animated: true)
            
            let selectedIndexPath: IndexPath? = self.myMapView.indexPathForSelectedRow
            if selectedIndexPath != nil {
                self.myMapView.deselectRow(at: selectedIndexPath!, animated: true)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinates = userLocation.coordinate
        let region : MKCoordinateRegion =  MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
        storeMapView.setRegion(region, animated: true)
    }
}

extension MapViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        var cell = myMapView.dequeueReusableCell(withIdentifier: "location")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "location")
        }
        cell?.textLabel?.text = location.title
        return cell!
    }
}

extension MapViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annotation: MKPointAnnotation = self.locations[indexPath.row]
        for an in self.storeMapView.annotations {
            let pointAnnotation: MKPointAnnotation? = an as? MKPointAnnotation
            if pointAnnotation != nil {
                if pointAnnotation == annotation {
                    self.isUserInteraction = false
                    let region: MKCoordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                    self.storeMapView.setRegion(region, animated: true)
                    
                }
            }
        }

    }
}

