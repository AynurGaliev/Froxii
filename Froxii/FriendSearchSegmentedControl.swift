//
//  FriendSearchSegmentedControl.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import FSHelpers_Swift

protocol FriendsSearchOptionListener: class {
    func segmentChanged(segmentControl: FriendSearchSegmentedControl, index: Int)
}

final class FriendSearchSegmentedControl: UIView {

    @IBOutlet var view: UIView!
    private var segments: [UIView] {
        return self.view.subviews
    }

    private var selectedColor: UIColor = UIColor.blue
    private var normalColor: UIColor = UIColor.lightGray
    private var selectedIndex: Int = 0 {
        didSet {
            self.delegate?.segmentChanged(segmentControl: self, index: self.selectedIndex)
        }
    }
    weak var delegate: FriendsSearchOptionListener?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed("FriendSearchSegmentedControl", owner: self, options: nil)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.view)
        
        for i in 0..<self.segments.count {
            if i == self.selectedIndex {
                self.segments[i].backgroundColor = self.selectedColor
            } else {
                self.segments[i].backgroundColor = self.normalColor
            }
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.segmentChanged(sender:)))
            self.segments[i].addGestureRecognizer(gesture)
        }
        
        let constraints = FSConstraint.Edges(self.view)
        self.addConstraints(constraints)
        self.setNeedsLayout()
    }
    
    func segmentChanged(sender: UITapGestureRecognizer) {
        guard let lView = sender.view, let index = self.segments.index(of: lView) else { return }
        self.selectedIndex = index
        for i in 0..<self.segments.count {
            if i == self.selectedIndex {
                self.segments[i].backgroundColor = self.selectedColor
            } else {
                self.segments[i].backgroundColor = self.normalColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        for subview in self.segments {
            var maskLayer = subview.layer.mask as? CAShapeLayer
            if maskLayer == nil {
                maskLayer = CAShapeLayer()
            }
            let path = UIBezierPath(roundedRect: subview.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 7, height: 7)).cgPath
            maskLayer?.path = path
            subview.layer.mask = maskLayer
            subview.layer.setNeedsDisplay()
            subview.layer.displayIfNeeded()
            subview.clipsToBounds = true
        }
    }
}
