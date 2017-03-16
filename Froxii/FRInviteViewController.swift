//
//  FRInviteViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 16.марта.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

final class FRInviteViewController: UIViewController {

    private var headerView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon", ofType: "tiff")!)!
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = self.headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 37.0/255.0, blue: 93.0/255.0, alpha: 1.0)
    }
    
    @IBAction func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
