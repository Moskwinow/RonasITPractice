//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit
import SnapKit

protocol AuthViewInput: class {
    @discardableResult
    func update(with viewModel: AuthViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol AuthViewOutput: class {
    func viewDidLoad()
    func emailInputChanged(_ input: String)
    func passwordInputChanged(_ input: String)
    func authTriggered()
}

final class AuthViewController: UIViewController {

    private(set) var viewModel: AuthViewModel
    let output: AuthViewOutput

    var needsUpdate: Bool = true
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Email"
        textField.textColor = .black
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        textField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Password"
        textField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        textField.textColor = .black
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogIn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 12
        button.frame.size = CGSize(width: 80, height: 40)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: -  Lifecycle

    init(viewModel: AuthViewModel, output: AuthViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fieldsStackView.addArrangedSubview(emailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        fieldsStackView.addArrangedSubview(signInButton)
        view.addSubview(fieldsStackView)
        
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fieldsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80))
        }
        
    }
    
    // MARK: -  Actions
    
    @objc private func emailTextFieldChanged() {
        output.emailInputChanged(emailTextField.text ?? "")
    }
    
    @objc private func passwordTextFieldChanged() {
        output.passwordInputChanged(passwordTextField.text ?? "")
    }
    
    @objc private func loginButtonPressed() {
        output.authTriggered()
    }
    
}

// MARK: -  AuthViewInput

extension AuthViewController: AuthViewInput, ViewUpdatable {

    func setNeedsUpdate() {
        needsUpdate = true
    }

    @discardableResult
    func update(with viewModel: AuthViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel

        update(new: viewModel, old: oldViewModel, keyPath: \.email) { email in
            emailTextField.text = email
        }
        
        update(new: viewModel, old: oldViewModel, keyPath: \.password) { password in
            passwordTextField.text = password
        }

        update(new: viewModel, old: oldViewModel, keyPath: \.buttonIsEnabled) { isEnabled in
            signInButton.isEnabled = isEnabled
        }
        
        update(new: viewModel, old: oldViewModel, keyPath: \.buttonAlpha) { alpha in
            signInButton.alpha = alpha
        }
        
        needsUpdate = false

        return true
    }
}
