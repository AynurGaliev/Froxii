//
//  FRScrollbar.swift
//  Froxii
//
//  Created by Aynur Galiev on 16.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

final class FRScrollbar: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.transform = self.transform.rotated(by: CGFloat(0.5 * Float.pi))
        self.tintColor = UIColor.lightGray
        self.setThumbImage(UIImage(named: "thumb"), for: UIControlState.normal)
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.trackRect(forBounds: bounds)
        return CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: 10)
    }
}
