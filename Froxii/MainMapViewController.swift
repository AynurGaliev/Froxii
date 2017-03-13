//
//  ViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import MapKit

final class MainMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.centerCoordinate = NYLocation.coordinate
        
        self.mapView.addAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let region = MKCoordinateRegion(center: NYLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
    }
}

extension MainMapViewController: MKMapViewDelegate {
    
}
