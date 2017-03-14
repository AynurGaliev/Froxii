//
//  FriendAnnotationView.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import MapKit

final class FriendAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func prepareAnnotation(with annotation: FriendAnnotation, searchOption: FriendsSearchOption) {
        self.image = annotation.friend?.gender.annotationImage
    }
}
