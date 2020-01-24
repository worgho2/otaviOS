//
//  Model.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Model {
    static let instance = Model()
    
    var isConsoleCracked: Bool
    var hasInternetExplorerAccess: Bool
    
    private init() {
        self.isConsoleCracked = false
        self.hasInternetExplorerAccess = false
    }
}
