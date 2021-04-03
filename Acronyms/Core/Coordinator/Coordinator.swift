//
//  Coordinator.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
}

extension Coordinator {

    func addChildCoordinator(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }

    func removeChildCoordinator(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }

    func removeAllChildCoordinator() {
        childCoordinators.forEach {
            removeChildCoordinator(childCoordinator: $0)
        }
    }

    func changeWindows(viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate,
            let window = appDelegate.window else { return }

        window?.changeWindows(viewController: viewController)
    }

}
