//
//  SceneDelegate.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import UIKit
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

}

