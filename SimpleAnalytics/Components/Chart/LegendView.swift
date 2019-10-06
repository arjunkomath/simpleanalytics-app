//
//  LegendView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct LegendView: View {
    private let legends: [Legend]

    init(bars: [Bar]) {
        legends = Array(Set(bars.map { $0.legend }))
    }

    var body: some View {
        HStack(alignment: .center) {
            ForEach(legends, id: \.self) { legend in
                VStack(alignment: .center) {
                    Circle()
                        .fill(legend.color)
                        .frame(width: 16, height: 16)

                    Text(legend.label)
                        .font(.footnote)
                        .lineLimit(nil)
                }
            }
        }
    }
}

struct LegendView_Previews: PreviewProvider {
    static let bars = [Bar(id: UUID(), value: 75.5, label: "test", legend: Legend(color: .pink, label: "Pink"))]
    
    static var previews: some View {
        LegendView(bars: bars)
    }
}
