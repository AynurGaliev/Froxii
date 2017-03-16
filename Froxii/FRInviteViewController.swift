//
//  FRInviteViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 16.марта.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

final class FRInviteViewController: UIViewController, UIGestureRecognizerDelegate {

    struct Constants {
        static let actionsContainerHeight: CGFloat = 44.0
        static let scrollbarWidth: CGFloat = 30.0
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollbar: FRScrollbar!
    @IBOutlet weak var actionsContainerView: InviteActionsView!

    fileprivate var friends: [Friend] = Friend.getRandomFriends()
    
    private var headerView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon", ofType: "tiff")!)!
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.frame = CGRect(x: 0, y: Constants.actionsContainerHeight + 64, width: self.view.fs_width - Constants.scrollbarWidth, height: self.view.fs_height - Constants.actionsContainerHeight - 64)
        self.actionsContainerView.frame = CGRect(x: 0, y: 64, width: self.view.fs_width, height: Constants.actionsContainerHeight)
        self.actionsContainerView.setNeedsLayout()
        self.scrollbar.frame = CGRect.init(x: self.tableView.fs_width, y: Constants.actionsContainerHeight + 64 + 10, width: Constants.scrollbarWidth, height: self.tableView.fs_height - 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weak var wself = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = wself
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.fs_width, height: 64))
        navBar.barStyle = .black
        navBar.barTintColor = UIColor.white
        let navigationItem = UINavigationItem()
        navigationItem.titleView = self.headerView
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "settings")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backAction(_:)))
        barButtonItem.tintColor = UIColor.blue
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = 15
        navigationItem.leftBarButtonItems = [spacer, barButtonItem]
        navigationItem.backBarButtonItem = nil
        navBar.setItems([navigationItem], animated: false)
        self.view.addSubview(navBar)
        self.view.setNeedsLayout()
    }
    
    func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func offsetChanged(_ sender: FRScrollbar) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: CGFloat((self.tableView.contentSize.height - self.tableView.fs_height) * CGFloat(sender.value)))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension FRInviteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell")
        cell!.textLabel?.text = "\(self.friends[indexPath.row].name) \(self.friends[indexPath.row].surname)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollbar.value = Float(Double(scrollView.contentOffset.y/(scrollView.contentSize.height - self.tableView.fs_height)))
    }
}
