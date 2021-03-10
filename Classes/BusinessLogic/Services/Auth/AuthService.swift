//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

final class AuthService: AuthServiceProtocol {
    
    func signInObservable(withEmail email: String, password: String, handler: @escaping (AuthHandler) -> ()) {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            guard email == "RonasIT" else {
                handler(.failure(.denied("Access denied with \(email)")))
                return
            }
            guard password == "123456" else {
                handler(.failure(.denied("wrong password")))
                return
            }
            handler(.success("Welcome \(email)"))
        }
    }
    
}
