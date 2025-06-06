//
//  BaseCollectionViewCell.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/5.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblsubtitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnAction: UIButton!
}


class InviteCell: BaseCollectionViewCell {
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    func configure(with friend: Friend) {
        lblTitle.text = friend.name
        lblsubtitle.text = "邀請你成為好友：）"
        imgView.image = UIImage(named: "imgFriendsFemaleDefault")
    }
    
    private func setupShadow() {
        viewContainer.layer.cornerRadius = 6
        viewContainer.layer.masksToBounds = false
        
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.15
        viewContainer.layer.shadowRadius = 8
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        viewContainer.layer.shadowPath = UIBezierPath(
            roundedRect: viewContainer.bounds,
            cornerRadius: viewContainer.layer.cornerRadius
        ).cgPath
    }
}

class SegmentCell: BaseCollectionViewCell {
    func configure(title: String) {
        lblTitle.text = title
    }
}

class SearchCell: BaseCollectionViewCell {
    @IBOutlet weak var searchBar: UISearchBar!
    
    func configure() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "想轉一筆給誰呢？"
    }
}

class FriendCell: BaseCollectionViewCell {
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    
    func configure(with friend: Friend) {
        lblTitle.text = friend.name
        imgView.image = UIImage(named: "imgFriendsFemaleDefault")
        btnInvite.isHidden = StatusType(rawValue: friend.status) != .invited
        btnMore.isHidden = !btnInvite.isHidden
        btnAction.layer.borderColor = btnAction.tintColor.cgColor
        btnAction.layer.borderWidth = 1.0
        btnAction.setTitle("轉帳", for: .normal)
        if btnInvite.isHidden {
            btnInvite.setTitle("", for: .normal)
        } else {
            btnInvite.setTitle("邀請中", for: .normal)
            btnInvite.layer.borderColor = btnInvite.tintColor.cgColor
            btnInvite.layer.borderWidth = 1.0
        }
    }
}

class EmptyCell: BaseCollectionViewCell {
    
    func configure() {
        //TODO: 
    }
}
