//
//  InviteCell.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

class InviteCell: BaseCollectionViewCell {
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    func configure(with friend: Friend) {
        lblTitle.text = friend.name
        lblsubtitle.text = "邀請你成為好友：）"
        imgView.image = UIImage(named: "imgFriendsFemaleDefault")
        setupShadow()
    }
    
    private func setupShadow() {
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.1
        viewContainer.layer.shadowRadius = 16
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}