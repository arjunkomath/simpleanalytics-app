//
//  BarChartView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct BarChartView: View {
    let bars: [Bar]
    let chartType: ChartType
    let labelsCount: Int
    
    var body: some View {
        Group {
            if bars.isEmpty {
                Text("There is no data to display chart...")
            } else {
                VStack {
                    if chartType == ChartType.horizontal {
                        VStack {
                            BarsView(bars: bars, chartType: chartType)
                            if labelsCount > 0 {
                                LabelsView(bars: bars, labelsCount: labelsCount, chartType: chartType)
                            }
                        }
                    } else {
                        HStack {
                            BarsView(bars: bars, chartType: chartType)
                            if labelsCount > 0 {
                                LabelsView(bars: bars, labelsCount: labelsCount, chartType: chartType)
                            }
                        }
                    }
                    LegendView(bars: bars)
                        .padding()
                        .accessibility(hidden: true)
                }
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static let bars = [Bar(id: UUID(), value: 75.5, label: "test", legend: Legend(color: .pink, label: "Pink"))]
    
    static var previews: some View {
        BarChartView(bars: bars, chartType: .horizontal, labelsCount: 1)
    }
}
