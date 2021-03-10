//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import RxSwift

final class AuthPresenter {

    typealias Dependencies = HasServices

    weak var view: AuthViewInput?
    weak var output: AuthModuleOutput?

    var state: AuthState

    private let dependencies: Dependencies
    
    private var authService: AuthServiceProtocol {
        dependencies.authService
    }

    init(state: AuthState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    // MARK: -  Private
    
    private func validateInputs() {
        state.buttonIsEnabled = !state.email.isEmpty && !state.password.isEmpty
        setupAlpha()
        update(animated: false)
    }
    
    private func setupAlpha() {
        if state.buttonIsEnabled {
            state.buttonAlpha = 1.0
        } else {
            state.buttonAlpha = 0.5
        }
        update(animated: false)
    }
}

// MARK: -  AuthViewOutput

extension AuthPresenter: AuthViewOutput {

    func viewDidLoad() {
        update(animated: false)
    }
    
    func emailInputChanged(_ input: String) {
        state.email = input
        validateInputs()
    }
    
    func passwordInputChanged(_ input: String) {
        state.password = input
        validateInputs()
    }
    
    func authTriggered() {
        authService.signInObservable(withEmail: state.email, password: state.password) { [unowned self] handler in
            switch handler {
            case .success(let successMessage):
                print(successMessage)
                self.output?.didSignIn(self)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    
}

// MARK: -  AuthModuleInput

extension AuthPresenter: AuthModuleInput {

    func update(animated: Bool) {
        let viewModel = AuthViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
