//
//  SearchCell.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

class SearchCell: BaseCollectionViewCell {
    @IBOutlet weak var searchBar: UISearchBar!
    
    func configure(with delegate: UISearchBarDelegate) {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.delegate = delegate
    }
}