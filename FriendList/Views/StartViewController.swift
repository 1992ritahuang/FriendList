//
//  StartViewController.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/7.
//

import UIKit

class StartViewController : UIViewController {
    @IBOutlet weak var btnEmpty: UIButton!
    @IBOutlet weak var btnFriends: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEmpty.tag = FriendListType.empty.rawValue
        btnFriends.tag = FriendListType.friendsOnly.rawValue
        btnInvite.tag = FriendListType.friendsWithInvite.rawValue
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let type = FriendListType(rawValue: sender.tag),
              let tabbarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController else { return }
        tabbarVC.viewModel = TabbarViewModel(type: type)
        tabbarVC.modalPresentationStyle = .fullScreen
        self.present(tabbarVC, animated: true)
    }
}
