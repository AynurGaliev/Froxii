//
//  Extensions.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIImage {
    
    class func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage! {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

extension MKMapView {
    
    func reloadAnnotations() {
        let annotations: [MKAnnotation] = self.annotations
        annotations.forEach { (annotation) in
            self.removeAnnotation(annotation)
            self.addAnnotation(annotation)
        }
    }
}

extension UIView {
    
    func makeRound(radius: CGFloat = -1) {
        if radius == -1 {
            self.layer.cornerRadius = floor(self.fs_width/2)
        } else {
            self.layer.cornerRadius = radius
        }
        self.clipsToBounds = true
    }
}

extension CGRect {
    
    func offset(dx: CGFloat, dy: CGFloat) -> CGRect {
        return CGRect(x: self.origin.x + dx, y: self.origin.y + dy, width: self.size.width, height: self.size.height)
    }
}
