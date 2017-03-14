//
//  FriendCell.swift
//  Froxii
//
//  Created by Aynur Galiev on 14.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

var placeholderImage: UIImage = {
    let path = Bundle.main.path(forResource: "jobs", ofType: "jpg")!
    let image = UIImage(contentsOfFile: path)!
    return image
}()

final class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 2
        self.clipsToBounds = true
    }
    
    func prepareCell(friend: Friend) {
        self.nameLabel.text = "\(friend.name) \(friend.surname)"
        self.distanceLabel.text = String(format: "%.2f miles", friend.location.distance(from: NYLocation) * 0.000621371)
        self.avatarImageView.image = placeholderImage
        if friend.gender == .male {
            self.layer.borderColor = UIColor.green.cgColor
        } else {
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func prepareCellAsAddFriend() {
        self.topBackgroundView.isHidden = true
        self.bottomBackgroundView.isHidden = true
        self.avatarImageView.image = UIImage.from(color: UIColor.lightGray, size: self.avatarImageView.frame.size)
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.topBackgroundView.isHidden = false
        self.bottomBackgroundView.isHidden = false
    }
}
