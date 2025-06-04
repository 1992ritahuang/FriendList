//
//  TabbarViewModel.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/4.
//

import UIKit

class TabbarViewModel {
    func makeViewControllers() -> [UIViewController] {
        return TabItems.allCases.compactMap { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: item.storyboardID)
            if let icon = item.iconName {
                vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: icon), tag: item.rawValue)
            }
            return vc
        }
    }

    var centerTabIndex: Int {
        return TabItems.main.rawValue
    }
}
