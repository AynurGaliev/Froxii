//
//  FriendAnnotation.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import MapKit

final class FriendAnnotation: NSObject, MKAnnotation {

    private(set) var friend: Friend!
    
    init(friend: Friend) {
        self.friend = friend
    }
    
    var coordinate: CLLocationCoordinate2D {
        return self.friend?.location.coordinate ?? CLLocationCoordinate2D()
    }
    
    var title: String? {
        return self.friend?.name
    }
    
    var subtitle: String? {
        return self.friend?.surname
    }
}
