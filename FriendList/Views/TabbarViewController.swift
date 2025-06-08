//
//  TabbarViewController.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/4.
//

import UIKit



class TabbarViewController: UITabBarController {
    private let centerButton = UIButton()
    var viewModel: TabbarViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .pinkEC008C
        tabBar.unselectedItemTintColor = .gray
        setupTabs()
        setupCenterButton()
        selectedIndex = TabItems.friend.rawValue
    }
    
    private func setupTabs() {
        viewControllers = viewModel?.makeViewControllers()
    }
    
    private func setupCenterButton() {
        centerButton.frame = CGRect(x: 0, y: 0, width: 85, height: 68)
        centerButton.setImage(UIImage(named: "icTabbarHomeOff"), for: .normal)
        centerButton.setImage(UIImage(named: "icTabbarHomeOff"), for: .highlighted)
        centerButton.backgroundColor = .white
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        view.addSubview(centerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerButton.center = CGPoint(x: tabBar.center.x, y: tabBar.center.y - 34)
    }
    
    @objc private func centerButtonTapped() {
//        selectedIndex = viewModel?.centerTabIndex ?? 0
        self.dismiss(animated: true)
    }
}
