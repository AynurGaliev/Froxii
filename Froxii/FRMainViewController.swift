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

final class FRMainViewController: UIViewController, FriendsSearchOptionListener {

    struct Constants {
        static let profileSegueIdentifier: String = "ShowProfile"
    }
    
    @IBOutlet weak var friendSearchSegmentControl: FriendSearchSegmentedControl!
    private var currentSegment: Int = 0
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var infoTextField: UITextField!
    private var headerView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon", ofType: "tiff")!)!
        return imageView
    }()
    
    private var containerViewController: FRContainerViewController {
        return self.childViewControllers.first as! FRContainerViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = self.headerView
        self.avatarImageView.layer.cornerRadius = ceil(self.avatarImageView.fs_width/2)
        self.avatarImageView.clipsToBounds = true
        self.infoTextField.layer.cornerRadius = 10
        self.infoTextField.layer.borderColor = UIColor.blue.cgColor
        self.infoTextField.layer.borderWidth = 1
        self.friendSearchSegmentControl.delegate = self
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.fs_width, height: 44))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePressed(sender:)))]
        numberToolbar.sizeToFit()
        self.infoTextField.inputAccessoryView = numberToolbar
        
        self.containerViewController.setActiveSegment(to: FriendsSearchOption.Near.rawValue, from: self.currentSegment)
        self.currentSegment = FriendsSearchOption.Near.rawValue
        
        self.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showProfile(sender:))))
    }
    
    func donePressed(sender: Any) {
        self.infoTextField.endEditing(false)
    }
    
    func showProfile(sender: Any?) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FRProfileNavigationController")
        self.present(controller, animated: true, completion: nil)
    }
    
    func segmentChanged(segmentControl: FriendSearchSegmentedControl, index: Int) {
        self.containerViewController.setActiveSegment(to: index, from: self.currentSegment)
        self.currentSegment = index
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
