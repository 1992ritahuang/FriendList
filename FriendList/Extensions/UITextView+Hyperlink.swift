//
//  UITextView+Hyperlink.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

extension UITextView {
    
    func setTextWithLink(fullText: String, linkText: String, urlString: String) {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: linkText),
           let url = URL(string: urlString)  {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.link, value: url, range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.pinkEC008C, range: nsRange)
        }
        
        self.attributedText = attributedString
        self.isEditable = false
        self.isSelectable = true
        self.isUserInteractionEnabled = true
        self.dataDetectorTypes = []
        self.linkTextAttributes = [
            .foregroundColor: UIColor.pinkEC008C,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}
