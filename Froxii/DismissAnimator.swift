//
//  DismissAnimator.swift
//  Froxii
//
//  Created by Aynur Galiev on 15.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

final class DismissAnimator: UIPercentDrivenInteractiveTransition {

    override var duration: CGFloat {
        return 1
    }
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(self.duration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as UIViewController
        let destinationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as UIViewController
        destinationVC.view.frame = CGRect(x: 0,
                                          y: transitionContext.containerView.fs_height,
                                          width: transitionContext.containerView.fs_width,
                                          height: transitionContext.containerView.fs_height)
        transitionContext.containerView.insertSubview(destinationVC.view, aboveSubview: sourceVC.view)
         
        UIView.animate(withDuration: TimeInterval(self.duration), animations: { () -> Void in
            destinationVC.view.frame = transitionContext.containerView.frame.offset(dx: 0, dy: 20)
            destinationVC.view.setNeedsLayout()
            destinationVC.view.layoutIfNeeded()
        }) { (success: Bool) -> Void in
            destinationVC.view.frame = transitionContext.containerView.frame
            destinationVC.view.setNeedsLayout()
            destinationVC.view.layoutIfNeeded()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension DismissAnimator: UIViewControllerTransitioningDelegate {
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
