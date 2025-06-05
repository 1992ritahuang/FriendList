//
//  TabItems.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/4.
//


enum TabItems: Int, CaseIterable {
case money, friend, main, accounting, setting
    
    var iconName: String? {
        switch self {
        case .money:
            return "icTabbarProductsOff"
        case .friend:
            return "icTabbarFriendsOn"
        case .main:
            return nil
        case .accounting:
            return "icTabbarManageOff"
        case .setting:
            return "icTabbarSettingOff"
        }
    }
    
    var storyboardID: String {
        switch self {
        case .money:
            return "moneyVC"
        case .friend:
            return "FriendViewController"
        case .main:
            return "homeVC"
        case .accounting:
            return "accountingVC"
        case .setting:
            return "settingVC"
        }
    }
}