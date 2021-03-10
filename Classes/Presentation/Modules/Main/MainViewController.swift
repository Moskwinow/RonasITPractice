//
//  Created by Moskwinow on 10/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit
import SnapKit

protocol MainViewInput: class {
    @discardableResult
    func update(with viewModel: MainViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol MainViewOutput: class {
    func viewDidLoad()
    func signOutTriggered()
}

final class MainViewController: UIViewController {

    private(set) var viewModel: MainViewModel
    let output: MainViewOutput

    var needsUpdate: Bool = true
    
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 12
        button.frame.size = CGSize(width: 120, height: 40)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: -  Lifecycle

    init(viewModel: MainViewModel, output: MainViewOutput) {
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
        view.addSubview(welcomeLabel)
        view.addSubview(signOutButton)
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        welcomeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
        }
        
        signOutButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        
    }
    
    // MARK: -  Actions
    
    @objc func signOutButtonPressed() {
        print("Signing OUT...")
        output.signOutTriggered()
    }
    
}

// MARK: -  MainViewInput

extension MainViewController: MainViewInput, ViewUpdatable {

    func setNeedsUpdate() {
        needsUpdate = true
    }

    @discardableResult
    func update(with viewModel: MainViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel

        update(new: viewModel, old: oldViewModel, keyPath: \.welcome) { text in
            welcomeLabel.text = text
        }

        needsUpdate = false

        return true
    }
}
