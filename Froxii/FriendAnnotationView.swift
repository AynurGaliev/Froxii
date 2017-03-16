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

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.addSubview(self.imageView)
    }
    
    func prepareAnnotation(with annotation: FriendAnnotation, searchOption: FriendsSearchOption) {
        self.imageView.image = annotation.friend?.gender.annotationImage
        if annotation.friend.gender == .female {
            self.imageView.tintColor = UIColor.red
        } else {
            self.imageView.tintColor = UIColor.blue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }
}
