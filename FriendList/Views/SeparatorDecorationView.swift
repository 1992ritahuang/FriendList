//
//  SeparatorDecorationView.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

class SeparatorDecorationView: UICollectionReusableView {
    static let elementKind = "SegmentSeparatorDecorationView"
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .grayEFEFEF
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(separatorLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let separatorHeight: CGFloat = 0.5
        separatorLine.frame = CGRect(x: 0,
                                     y: bounds.height - separatorHeight,
                                     width: bounds.width,
                                     height: separatorHeight)
    }
}