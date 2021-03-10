//
//  Created by Maksym Vechirko on 08/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseCrashlytics
import IQKeyboardManagerSwift

final class AppConfigurator {

    static func configure(_ application: UIApplication, with launchOptions: LaunchOptions?) {
        let appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.bundleVersion))"
        UserDefaults.standard.appVersion = appVersion
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        FirebaseApp.configure()
    }
}

private extension UserDefaults {

    var appVersion: String? {
        get {
            return string(forKey: #function)
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}
