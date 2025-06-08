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
        setupShadow()
    }
    
    private func setupShadow() {
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.1
        viewContainer.layer.shadowRadius = 16
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

class SegmentCell: BaseCollectionViewCell {
    func configure(title: String) {
        lblTitle.text = title
    }
}

class SearchCell: BaseCollectionViewCell {
    @IBOutlet weak var searchBar: UISearchBar!
    
    func configure(with delegate: UISearchBarDelegate) {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.delegate = delegate
    }
}

class FriendCell: BaseCollectionViewCell {
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    
    func configure(with friend: Friend) {
        lblTitle.text = friend.name
        imgView.isHidden = !friend.isTopFriend()
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
    @IBOutlet weak var textView: UITextView!
    func configure(with delegate: UITextViewDelegate) {
        lblTitle.text = "就從加好友開始吧：）"
        lblsubtitle.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        btnAction.setGradientBackground(startColor: .green56B30B, endColor: .greenA6CC42)
        btnAction.setTitle("加朋友", for: .normal)
        textView.setTextWithLink(fullText: "幫助好友更快找到你？設定 KOKO ID", linkText: "設定 KOKO ID", urlString: "http://example.com")
        textView.textAlignment = .center
        textView.delegate = delegate
    }
}
