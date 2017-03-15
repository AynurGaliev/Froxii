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
    
    func dismissByPanning(sender: UIPanGestureRecognizer) {
        
        let point: CGPoint = sender.translation(in: self.view)
        let location: CGPoint = sender.location(in: self.view)
        
        switch sender.state {
            
        case UIGestureRecognizerState.began:
            
            guard location.y > self.view.fs_height - self.bottomHeightForPan else { return }
            print("began")
            self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.custom
            self.navigationController!.transitioningDelegate = self.dismissAnimator
            self.navigationController!.dismiss(animated: true, completion: nil)
            
        case UIGestureRecognizerState.changed:
            //print("changed - \(fabs(point.y)/UIScreen.main.bounds.size.height)")
            self.dismissAnimator.update(fabs(point.y)/UIScreen.main.bounds.size.height)
            
        case UIGestureRecognizerState.cancelled:
            print("cancelled")
            let centerY: CGFloat = sender.view!.frame.midY
            if 200 < point.y {
                self.dismissAnimator.finish()
            } else {
                self.dismissAnimator.cancel()
            }
            
        case UIGestureRecognizerState.ended:
            print("ended")
            let centerY: CGFloat = sender.view!.frame.midY
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
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
