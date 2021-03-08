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
        let viewController = ViewController()
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
