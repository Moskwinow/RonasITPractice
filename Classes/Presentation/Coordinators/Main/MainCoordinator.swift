//
//  Created by Moskwinow on 10/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

protocol MainCoordinatorOutput: CoordinatorOutput {
    func closeMainCoordinator(_ coordinator: MainCoordinator)
}

final class MainCoordinator: Coordinator<UINavigationController> {

    typealias Dependencies = Any

    private let dependencies: Dependencies

    private weak var mainOutput: MainCoordinatorOutput?
    override weak var output: CoordinatorOutput? {
        get {
            return mainOutput
        }
        set {
            guard let mainOutput = newValue as? MainCoordinatorOutput else {
                fatalError("Incorrect output type")
            }
            self.mainOutput = mainOutput
        }
    }

    // MARK: -  Lifecycle

    init(rootViewController: UINavigationController? = nil, dependencies: Dependencies = [Any]()) {
        let rootViewController = rootViewController ?? UINavigationController()
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController)
    }

    override func start(animated: Bool) {
        showMainModule(animated: animated)
    }

    override func startModally(from viewController: UIViewController? = nil, animated: Bool) {
        super.startModally(from: viewController, animated: animated)
        // Modal presentation logic...
    }
    
    override func close(animated: Bool) {
        super.close(animated: animated)
        output?.childCoordinatorDidClose(self)
    }
    
    // MARK: -  Private

    private func showMainModule(animated: Bool) {
        let module = MainModule()
        module.output = self
        module.viewController.modalPresentationStyle = .overFullScreen
        module.viewController.modalTransitionStyle = .crossDissolve
        rootViewController.present(module.viewController, animated: animated)
    }
    
}

// MARK: - MainModuleOutput

extension MainCoordinator: MainModuleOutput {
    func didSignOut(_ moduleInput: MainModuleInput) {
        mainOutput?.closeMainCoordinator(self)
    }
}
