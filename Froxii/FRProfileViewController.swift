//
//  FRProfileViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 15.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

class FRProfileViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    private var dismissAnimator: DismissAnimator = DismissAnimator()
    private var bottomHeightForPan: CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarImageView.makeRound()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissByPanning(sender:)))
        gesture.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.fs_width, height: 64))
        navBar.barStyle = .black
        navBar.barTintColor = UIColor(red: 0, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
        let navigationItem = UINavigationItem()
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "humburger_icon")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backAction(_:)))
        leftBarButtonItem.tintColor = UIColor.white
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = 15
        navigationItem.leftBarButtonItems = [spacer, leftBarButtonItem]
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.showInvitation(sender:)))
        rightBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [rightBarButtonItem, spacer]
        
        navBar.setItems([navigationItem], animated: false)
        self.view.addSubview(navBar)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func dismissByPanning(sender: UIPanGestureRecognizer) {
        
        let point: CGPoint = sender.translation(in: self.view)
        let location: CGPoint = sender.location(in: self.view)
        
        switch sender.state {
            
        case UIGestureRecognizerState.began:
            
            guard location.y > self.view.fs_height - self.bottomHeightForPan else { return }
            self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.custom
            self.navigationController!.transitioningDelegate = self.dismissAnimator
            self.navigationController!.dismiss(animated: true, completion: nil)
            
        case UIGestureRecognizerState.changed:
            self.dismissAnimator.update(fabs(point.y)/UIScreen.main.bounds.size.height)
            
        case UIGestureRecognizerState.cancelled:
            if 200 < point.y {
                self.dismissAnimator.finish()
            } else {
                self.dismissAnimator.cancel()
            }
            
        case UIGestureRecognizerState.ended:
            if 200 < fabs(point.y) {
                self.dismissAnimator.finish()
            } else {
                self.dismissAnimator.cancel()
            }
        default:
            print("Not implemented!")
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        print("Not implemented")
    }
    
    func showInvitation(sender: Any) {
        self.performSegue(withIdentifier: "ShowInvititation", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
