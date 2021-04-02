//
//  SceneDelegate.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import UIKit
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        let moyaProvider = MoyaProvider<AcromineAPI>()
        let provider = AcromineProvider(provider:moyaProvider)
        let repository = AcronymRemoteRespository(provider: provider)
        let searchBarViewModel = SearchBarViewModel(validation: .whitoutSpaces,  placeholderText: "Search Acronyms", indicatorTitleText: "Searching")
        let acronymSearchViewModel =  AcronymSearchViewModel(repository: repository, searchBarViewModel: searchBarViewModel)
        window?.rootViewController = AcronymSearchViewController(with: acronymSearchViewModel)
        window?.makeKeyAndVisible()
    }

}

