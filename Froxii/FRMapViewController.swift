//
//  ViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import MapKit

final class FRMapViewController: UIViewController {

    struct Constants {
        static let friendAnnotationViewIdentifier: String = String(describing: FriendAnnotationView.self)
    }
    
    private var friends: [Friend] = Friend.getRandomFriends()
    fileprivate var friendSearchOption: FriendsSearchOption = .Near
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.centerCoordinate = NYLocation.coordinate
        self.mapView.addAnnotations(self.friends.map { FriendAnnotation(friend: $0) })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let region = MKCoordinateRegion(center: NYLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func friendsSearchOptionChanged(_ sender: UISegmentedControl) {
        self.friendSearchOption = FriendsSearchOption(rawValue: sender.selectedSegmentIndex)!
        self.mapView.reloadAnnotations()
    }
}

extension FRMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var friendAnnotationView: FriendAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.friendAnnotationViewIdentifier) as? FriendAnnotationView
        if friendAnnotationView == nil {
            friendAnnotationView = FriendAnnotationView(annotation: annotation, reuseIdentifier: Constants.friendAnnotationViewIdentifier)
        } 
        friendAnnotationView?.prepareAnnotation(with: annotation as! FriendAnnotation, searchOption: self.friendSearchOption)
        return friendAnnotationView
    }
    
}
