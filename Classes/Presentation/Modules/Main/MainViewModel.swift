//
//  Created by Moskwinow on 10/03/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

struct MainViewModel: Equatable {
    
    var welcome: String

    init(state: MainState) {
        self.welcome = state.welcome
    }
    
}
