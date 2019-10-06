//
//  Graph.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import Foundation
import SwiftUI

struct Legend: Hashable {
    let color: Color
    let label: String
}

struct Bar: Identifiable {
    let id: UUID
    let value: Double
    let label: String
    let legend: Legend
}
