//
//  FRMainViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

enum FriendsSearchOption: Int {
    case Near = 0
    case Gender
    case All
}

final class FRMainViewController: UIViewController {

    struct Constants {
        static let profileSegueIdentifier: String = "ShowProfile"
    }
    
    @IBOutlet weak var friendSearchSegmentControl: UISegmentedControl!
    private var currentSegment: Int = 0
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var infoTextField: UITextField!
    
    
    private var containerViewController: FRContainerViewController {
        return self.childViewControllers.first as! FRContainerViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarImageView.layer.cornerRadius = ceil(self.avatarImageView.fs_width/2)
        self.avatarImageView.clipsToBounds = true
        self.infoTextField.layer.cornerRadius = 5
        self.infoTextField.layer.borderColor = UIColor.blue.cgColor
        self.infoTextField.layer.borderWidth = 1
        self.containerViewController.setActiveSegment(to: FriendsSearchOption.Near.rawValue, from: self.currentSegment)
        self.currentSegment = FriendsSearchOption.Near.rawValue
        
        self.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showProfile(sender:))))
    }
    
    func showProfile(sender: Any?) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FRProfileNavigationController")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        self.containerViewController.setActiveSegment(to: sender.selectedSegmentIndex, from: self.currentSegment)
        self.currentSegment = sender.selectedSegmentIndex
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
