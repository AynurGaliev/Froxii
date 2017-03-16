//
//  InviteActionsView.swift
//  Froxii
//
//  Created by Aynur Galiev on 16.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import FSHelpers_Swift

protocol IActionDelegate: class {
    func inviteAll(sender: InviteActionsView)
    func cancel(sender: InviteActionsView)
}

final class InviteActionsView: UIView {

    struct Constants {
        static let defaultButtonWidth: CGFloat = 100
        static let defaultCenterXOffset: CGFloat = 40
        static let defaultButtonHeight: CGFloat = 30
    }
    
    @IBOutlet var view: UIView!
    @IBOutlet var inviteAllButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    weak var delegate: IActionDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    private func initialize() {
        Bundle.main.loadNibNamed("InviteActionsView", owner: self, options: nil)
        self.addSubview(self.view)
        self.setNeedsLayout()
    }
    
    @IBAction func inviteAllAction(_ sender: Any) {
        self.delegate?.inviteAll(sender: self)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.cancel(sender: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view.frame = self.bounds
        self.inviteAllButton.frame = CGRect(x: self.fs_width/2 - Constants.defaultCenterXOffset - Constants.defaultButtonWidth, y: (self.fs_height - Constants.defaultButtonHeight)/2, width: Constants.defaultButtonWidth, height: Constants.defaultButtonHeight)
        self.cancelButton.frame = CGRect(x: self.fs_width/2 + Constants.defaultCenterXOffset, y: (self.fs_height - Constants.defaultButtonHeight)/2, width: Constants.defaultButtonWidth, height: Constants.defaultButtonHeight)
        
    }
}
