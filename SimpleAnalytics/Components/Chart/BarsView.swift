//
//  BarsView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

enum ChartType: String {
    case vertical = "vertical"
    case horizontal = "horizontal"
}

struct BarsView: View {
    let bars: [Bar]
    let max: Double
    let chartType: ChartType
    
    init(bars: [Bar], chartType: ChartType) {
        self.bars = bars
        self.max = bars.map { $0.value }.max() ?? 0
        self.chartType = chartType
    }
    
    var body: some View {
        GeometryReader { geometry in
            if (self.chartType == ChartType.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(self.bars) { bar in
                        Capsule()
                            .fill(bar.legend.color)
                            .frame(width: CGFloat(bar.value) / CGFloat(self.max) * geometry.size.width)
                            .padding(.vertical, 2)
                            .accessibility(label: Text(bar.label))
                            .accessibility(value: Text(bar.legend.label))
                    }
                }
            } else {
                HStack(alignment: .bottom, spacing: 0) {
                    ForEach(self.bars) { bar in
                        Capsule()
                            .fill(bar.legend.color)
                            .frame(height: CGFloat(bar.value) / CGFloat(self.max) * geometry.size.height)
                            .padding(.horizontal, 1)
                            .accessibility(label: Text(bar.label))
                            .accessibility(value: Text(bar.legend.label))
                    }
                }
            }
        }
    }
}

struct BarsView_Previews: PreviewProvider {
    static let bars = [Bar(id: UUID(), value: 75.5, label: "test", legend: Legend(color: .pink, label: "Pink"))]
    
    static var previews: some View {
        BarsView(bars: bars, chartType: .horizontal)
    }
}
