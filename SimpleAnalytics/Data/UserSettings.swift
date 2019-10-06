//
//  UserSettings.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 4/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import Combine
import SwiftUI

final class UserSettings: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    @UserDefault("properties", defaultValue: ["simpleanalytics.com"])
    var properties: [String] {
        didSet {
            didChange.send()
        }
    }
}
