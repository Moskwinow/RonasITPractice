//
//  Created by Moskwinow on 10/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

protocol MainModuleInput: class {
    var state: MainState { get }
    func update(animated: Bool)
}

protocol MainModuleOutput: class {
    func didSignOut(_ moduleInput: MainModuleInput) 
}

final class MainModule {

    var input: MainModuleInput {
        return presenter
    }
    weak var output: MainModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: MainViewController
    private let presenter: MainPresenter

    init(state: MainState = .init()) {
        let viewModel = MainViewModel(state: state)
        let presenter = MainPresenter(state: state, dependencies: ServiceContainer())
        let viewController = MainViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
