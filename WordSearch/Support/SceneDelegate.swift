//
//  SceneDelegate.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }

        let navVC = UINavigationController(rootViewController: SearchViewController())
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

