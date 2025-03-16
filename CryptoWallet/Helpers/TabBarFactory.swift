//
//  TabBarFactory.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 11.03.2025.
//

import UIKit

class TabBarFactory {
    static func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), tag: 0)
        
        let graphVC = UINavigationController(rootViewController: GraphViewController())
        graphVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "graph"), tag: 1)
        
        let walletVC = UINavigationController(rootViewController: WalletViewController())
        walletVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "wallet"), tag: 2)
        
        let noteVC = UINavigationController(rootViewController: NoteViewController())
        noteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "note"), tag: 3)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 4)
        
        tabBarController.viewControllers = [homeVC, graphVC, walletVC, noteVC, profileVC]
        return tabBarController
    }
}
