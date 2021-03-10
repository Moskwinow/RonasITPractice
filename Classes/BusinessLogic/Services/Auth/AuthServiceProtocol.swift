//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import RxSwift

typealias AuthHandler = Result<String, AuthError>

protocol HasAuthService {
    var authService: AuthServiceProtocol { get }
}

protocol AuthServiceProtocol: class {
    func signInObservable(withEmail email: String, password: String, handler: @escaping(AuthHandler) -> () )
}

enum AuthError: Error {
    case denied(String)
}

