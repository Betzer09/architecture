//
//  SceneDelegate.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setupTabBarAppearance()
        setupNav()
    }

    private func setupNav() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.black, .font: UIFont(name: "LapsusPro-Bold", size: 30) ?? .systemFont(ofSize: 17)]
        UINavigationBar.appearance().tintColor = .white
    }

    private func setupTabBarAppearance() {
        let themeGreen = UIColor(red: 102/255, green: 224/255, blue: 185/255, alpha: 1)
        
        let normalAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font: UIFont(name: "LapsusPro-Bold", size: 14) ?? .systemFont(ofSize: 14),
        ]
        
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : themeGreen,
            .font: UIFont(name: "LapsusPro-Bold", size: 14) ?? .systemFont(ofSize: 14),
        ]
    
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        UITabBar.appearance().tintColor = themeGreen
        UITabBar.appearance().unselectedItemTintColor = .white
    }

}

