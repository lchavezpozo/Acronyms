//
//  AcronymSearchCoordinator.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit
import Moya

class AcronymSearchCoordinator: Coordinator, RootViewCoordinator {

    var childCoordinators: [Coordinator] = []

    var rootViewCoordinator: UIViewController {
        return navigationController
    }

    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        return navigation
    }()

    func start() {
        let moyaProvider = MoyaProvider<AcromineAPI>()
        let provider = AcromineProvider(provider: moyaProvider)
        let repository = AcronymRemoteRespository(provider: provider)
        let searchBarViewModel = SearchBarViewModel(validation: .whitoutSpaces,
                                                    placeholderText: "Search Acronyms",
                                                    indicatorTitleText: "Searching")
        let acronymSearchViewModel =  AcronymSearchViewModel(repository: repository, searchBarViewModel: searchBarViewModel)
        let vc = AcronymSearchViewController(with: acronymSearchViewModel)
        navigationController.viewControllers = [vc]
    }

}
