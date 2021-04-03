//
//  AppCoordinator.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow

    var childCoordinators: [Coordinator] = []

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let acronymSearchCoordinator = AcronymSearchCoordinator()
        acronymSearchCoordinator.start()
        addChildCoordinator(childCoordinator: acronymSearchCoordinator)
        window.changeWindows(viewController: acronymSearchCoordinator.rootViewCoordinator)
        window.makeKeyAndVisible()
    }

}
