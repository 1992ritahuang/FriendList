//
//  EmptyCell.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

class EmptyCell: BaseCollectionViewCell {
    @IBOutlet weak var textView: UITextView!
    func configure(with delegate: UITextViewDelegate) {
        lblTitle.text = "就從加好友開始吧：）"
        lblsubtitle.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        btnAction.setGradientBackground(startColor: .green56B30B, endColor: .greenA6CC42)
        btnAction.setTitle("加好友", for: .normal)
        textView.setTextWithLink(fullText: "幫助好友更快找到你？設定 KOKO ID", linkText: "設定 KOKO ID", urlString: "http://example.com")
        textView.textAlignment = .center
        textView.delegate = delegate
    }
}
