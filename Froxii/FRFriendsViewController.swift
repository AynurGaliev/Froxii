//
//  FriendsViewController.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

final class FRFriendsViewController: UIViewController {

    struct Constants {
        static let friendCellIdentifier: String = String(describing: FriendCell.self)
        static let itemSize: CGSize = CGSize(width: 150, height: 150)
    }
    
    fileprivate var interItemSpacing: CGFloat = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var friends: [Friend] = Friend.getRandomFriends()
    
    func setFriends(friends: [Friend]) {
        self.friends = friends
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interItemSpacing = floor((self.view.fs_width - 2 * Constants.itemSize.width)/3)
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = UIEdgeInsets(top: 20, left: self.interItemSpacing, bottom: 20, right: self.interItemSpacing)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension FRFriendsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.friendCellIdentifier, for: indexPath) as! FriendCell
        if indexPath.row == 0 {
            cell.prepareCellAsAddFriend()
        } else {
            cell.prepareCell(friend: self.friends[indexPath.row - 1])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.interItemSpacing
    }
}
