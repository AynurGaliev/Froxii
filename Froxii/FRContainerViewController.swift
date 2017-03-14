//
//  FRContainerViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import FSHelpers_Swift

final class FRContainerViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    fileprivate var controllers: [UIViewController] = []
    fileprivate var currentPage: Int = 0
    fileprivate var nextController: UIViewController?
    
    override func addChildViewController(_ childController: UIViewController) {
        childController.view.frame = self.view.bounds
        super.addChildViewController(childController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    private func initialize() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let friendsViewController = storyboard.instantiateViewController(withIdentifier: "FRFriendsViewController") as! FRFriendsViewController
        let mapViewController = storyboard.instantiateViewController(withIdentifier: "FRMapViewController") as! FRMapViewController
        
        self.controllers = [friendsViewController, mapViewController]
        self.controllers.forEach { let _ = $0.view.frame }

        self.delegate   = self
    }
    
    func setActiveSegment(to: Int, from: Int) {
        let animated: Bool = (to == 0) || (from == 0)
        let direction: UIPageViewControllerNavigationDirection = (to > from) ? .forward : .reverse
        var viewControllers: [UIViewController] = []
        if to == 0 { viewControllers = [self.controllers[0]] }
        else { viewControllers = [self.controllers[1]] }
        self.setViewControllers(viewControllers,
                                direction: direction,
                                animated: animated,
                                completion: nil)
    }
}
