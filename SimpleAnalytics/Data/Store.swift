//
//  Store.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 4/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI
import Combine
import SwiftDate

let barColors: [Color] = [
    Color.red,
    Color.orange,
    Color.yellow,
    Color.pink,
    Color.green,
    Color.blue
]

let settings = UserSettings()

final class AppStore: ObservableObject {
    private var propertyUrl: String
    
    var dateRange: Int = 1 {
        didSet {
            self.fetchData()
        }
    }
    
    @Published var loading: Bool
    @Published var apiError: Bool
    
    @Published var properties: [String]
    @Published var stats: Stats
    @Published var visitsBars: [Bar]
    @Published var agentBars: [Bar]
        
    init() {
        self.propertyUrl = ""
        self.loading = true
        self.apiError = false
        
        self.stats = Stats(
            timezone: "", pageviews: 0, visits: [], agents: []
        )
        self.visitsBars = []
        self.agentBars = []
        
        let settings = UserSettings()
        self.properties = settings.properties
    }
    
    func resetData() {
        self.loading = true
        self.apiError = false
        
        self.stats = Stats(
            timezone: "", pageviews: 0, visits: [], agents: []
        )
        self.visitsBars = []
        self.agentBars = []
    }
    
    func addProperty(name: String) {
        settings.properties.append(name.lowercased())
        self.properties.append(name.lowercased())
    }
    
    func removeProperty(offsets: IndexSet) {
        settings.properties.remove(at: offsets.first!)
        self.properties.remove(at: offsets.first!)
    }
    
    func setProperty(url: String) {
        self.propertyUrl = url
    }
    
    func getAgents() -> [Agent] {
        return stats.agents.filter { agent in
            agent.browser_name.isEmpty == false
        }
    }
    
    func fetchData() {
        self.resetData()
        
        let end_date = Date().toFormat("yyyy-MM-dd")
        var start_date = Date() - 1.days
        
        switch self.dateRange {
        case 0:
            start_date = Date() - 7.days
        case 1:
            start_date = Date() - 30.days
        case 2:
            start_date = Date() - 90.days
        default:
            start_date = Date() - 7.days
        }
        
        let queryString = "start=\(start_date.toFormat("yyyy-MM-dd"))&end=\(end_date)"
        let dataUrl = "https://simpleanalytics.com/\(self.propertyUrl).json?\(queryString)"
        
        APIClient.getStats(route: dataUrl) { (result) in
            self.loading = false
            
            switch result {
            case .success(let value):
                self.stats = value
                
                self.visitsBars = value.visits.map { visit in
                    Bar(id: UUID(),
                        value: Double(visit.pageviews),
                        label: visit.date,
                        legend: Legend(color: .blue, label: "Visits")
                    )
                }
                
                var agents: [Agent] = []
                if (value.agents.count < 5) {
                    agents = value.agents
                } else {
                    agents = Array(value.agents[0 ..< 5])
                }
                
                var index = -1
                self.agentBars = agents.map { agent in
                    index += 1
                    
                    return Bar(id: UUID(),
                               value: Double(agent.count),
                               label: "\(agent.count)",
                        legend: Legend(
                            color: barColors[index],
                            label: "\(agent.browser_name)"
                        )
                    )
                }
                
            case .failure(let error):
                // error handling
                self.apiError = true
                print(error)
            }
        }
    }
}
