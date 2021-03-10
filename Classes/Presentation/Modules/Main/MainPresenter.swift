//
//  Created by Moskwinow on 10/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

final class MainPresenter {

    typealias Dependencies = Any

    weak var view: MainViewInput?
    weak var output: MainModuleOutput?

    var state: MainState

    private let dependencies: Dependencies

    init(state: MainState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
}

// MARK: -  MainViewOutput

extension MainPresenter: MainViewOutput {

    func viewDidLoad() {
        update(animated: false)
    }
    
    func signOutTriggered() {
        output?.didSignOut(self)
    }
}

// MARK: -  MainModuleInput

extension MainPresenter: MainModuleInput {

    func update(animated: Bool) {
        let viewModel = MainViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
