//
//  Created by Maksym Vechirko on 08/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator<UINavigationController> {

    typealias Dependencies = Any

    private let dependencies: Dependencies

    // MARK: - Lifecycle

    init(rootViewController: UINavigationController? = nil, dependencies: Dependencies = [Any]()) {
        let rootViewController = rootViewController ?? UINavigationController()
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController)
    }

    func start(launchOptions: LaunchOptions?) {
        showAuthModule(animated: true)
    }
    
    // MARK: -  Private

    private func showAuthModule(animated: Bool) {
        let module = AuthModule()
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: animated)
    }
    
    private func startMainCoordinator(animated: Bool) {
        let coordinator = MainCoordinator(rootViewController: rootViewController)
        coordinator.output = self
        append(childCoordinator: coordinator)
        coordinator.start(animated: animated)
    }
}

// MARK: - AuthModuleOutput

extension AppCoordinator: AuthModuleOutput {
    func didSignIn(_ moduleInput: AuthModuleInput) {
        startMainCoordinator(animated: true)
    }
}

// MARK: - AuthModuleOutput
extension AppCoordinator: MainCoordinatorOutput {
    func closeMainCoordinator(_ coordinator: MainCoordinator) {
        coordinator.rootViewController.dismiss(animated: true, completion: nil)
        self.remove(childCoordinator: coordinator)
    }
}
