//
//  Created by Moskwinow on 09/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

struct AuthViewModel: Equatable {
    
    var email: String
    var password: String
    var buttonIsEnabled: Bool
    var buttonAlpha: CGFloat
    
    init(state: AuthState) {
        email = state.email
        password = state.password
        buttonIsEnabled = state.buttonIsEnabled
        buttonAlpha = state.buttonAlpha
    }
}
