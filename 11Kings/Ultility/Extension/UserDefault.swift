//
//  UserDefault.swift
//  DreamTeam
//
//  Created by Test on 10/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
extension UserDefaults {

    static let shared = UserDefaults.standard

    static func set(object: Any, forKey key: String) {

        shared.set(object, forKey: key)
        // shared?.synchronize()  obsolete
    }
}
