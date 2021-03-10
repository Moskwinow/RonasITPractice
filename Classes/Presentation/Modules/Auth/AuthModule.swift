//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

protocol AuthModuleInput: class {
    var state: AuthState { get }
    func update(animated: Bool)
}

protocol AuthModuleOutput: class {
    func didSignIn(_ moduleInput: AuthModuleInput)
}

final class AuthModule {

    var input: AuthModuleInput {
        return presenter
    }
    weak var output: AuthModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: AuthViewController
    private let presenter: AuthPresenter

    init(state: AuthState = .init()) {
        let viewModel = AuthViewModel(state: state)
        let presenter = AuthPresenter(state: state, dependencies: ServiceContainer())
        let viewController = AuthViewController(viewModel: viewModel, output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
