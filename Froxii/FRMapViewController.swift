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
        self.zoomToFitMapAnnotations(mapView: self.mapView)
    }
    
    func zoomToFitMapAnnotations(mapView: MKMapView) {
        guard mapView.annotations.count > 0 else { return }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in mapView.annotations {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude)
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude)
        region = mapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
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
        friendAnnotationView?.fs_size = CGSize(width: 40, height: 40)
        friendAnnotationView?.prepareAnnotation(with: annotation as! FriendAnnotation, searchOption: self.friendSearchOption)
        return friendAnnotationView
    }
    
}
