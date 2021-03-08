//
//  Created by Maksym Vechirko on 08/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var appCoordinator: AppCoordinator = .init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
        AppConfigurator.configure(application, with: launchOptions)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

        appCoordinator.start(launchOptions: launchOptions)

        return true
    }
}
