//
//  Stats.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 1/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import Foundation
import SwiftUI

struct Stats: Codable, Hashable {
    let timezone: String
    let pageviews: Int
    let visits: [Visit]
    let agents: [Agent]
}

struct Visit: Codable, Hashable {
    let date: String
    let pageviews: Int
}

struct Agent: Codable, Hashable {
    let count: Int
    let browser_name: String?
    let browser_version: String?
    let os_name: String?
    let os_version: String?
    let type: String?
}
