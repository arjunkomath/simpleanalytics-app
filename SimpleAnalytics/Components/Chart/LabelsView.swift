//
//  LabelsView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct LabelsView: View {
    let bars: [Bar]
    let labelsCount: Int
    let chartType: ChartType
    
    private var threshold: Int {
        let threshold = bars.count / labelsCount
        return threshold == 0 ? 1 : threshold
    }
    
    var body: some View {
        Group {
            if chartType == ChartType.vertical {
                VStack {
                    ForEach(0..<bars.count, id: \.self) { index in
                        Group {
                            if index % self.threshold == 0 {
                                Spacer()
                                Text(self.bars[index].label)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
            } else {
                HStack {
                    ForEach(0..<bars.count, id: \.self) { index in
                        Group {
                            if index % self.threshold == 0 {
                                Spacer()
                                Text(self.bars[index].label)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
            }   
        }
    }
}

struct LabelsView_Previews: PreviewProvider {
    static let bars = [Bar(id: UUID(), value: 75.5, label: "test", legend: Legend(color: .pink, label: "Pink"))]
    
    static var previews: some View {
        LabelsView(bars: bars, labelsCount: 1, chartType: .horizontal)
    }
}
