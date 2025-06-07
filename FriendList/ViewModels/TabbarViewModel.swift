//
//  TabbarViewModel.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/4.
//

import UIKit

class TabbarViewModel {
    var type: FriendListType = .friendsOnly
    
    func makeViewControllers() -> [UIViewController] {
        return TabItems.allCases.compactMap { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc: UIViewController
            if item == .friend {
                vc = generateFriendListVC(type: type)
            } else {
                vc = storyboard.instantiateViewController(identifier: item.storyboardID)
            }
            if let icon = item.iconName {
                vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: icon), tag: item.rawValue)
            }
            return UINavigationController(rootViewController: vc)
        }
    }
    
    func generateFriendListVC(type: FriendListType) -> FriendViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
            vc.viewModel = FriendViewModel(type: type)
            return vc
        }

    var centerTabIndex: Int {
        return TabItems.main.rawValue
    }
}
