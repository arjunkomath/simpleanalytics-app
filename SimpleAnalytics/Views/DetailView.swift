//
//  DetailView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 1/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftDate

struct DetailView: View {
    let propertyUrl: String
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        ScrollView {
            Group() {
                Picker(selection: $store.dateRange, label: Text("Choose Date Range")) {
                    Text("7 Days").tag(0)
                    Text("30 Days").tag(1)
                    Text("90 Days").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if (self.store.apiError == false) {
                    VStack(alignment: .leading) {
                        Text("Pageviews")
                            .bold()
                            .font(.title)
                        
                        if (self.store.loading) {
                            ActivityIndicator(isAnimating: $store.loading, style: .medium)
                                .padding(.top)
                        } else {
                            Text("\(self.store.stats.pageviews)")
                                .font(.largeTitle)
                        }
                        
                        Text("Visits")
                            .bold()
                            .font(.title)
                            .padding(.top)
                        if (self.store.loading) {
                            ActivityIndicator(isAnimating: $store.loading, style: .medium)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .leading)
                        } else {
                            BarChartView(bars: self.store.visitsBars, chartType: .horizontal, labelsCount: 0)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .leading)
                        }
                        
                        Text("Browsers")
                            .bold()
                            .font(.title)
                            .padding(.top)
                        if (self.store.loading) {
                            ActivityIndicator(isAnimating: $store.loading, style: .medium)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .leading)
                        } else {
                            BarChartView(bars: self.store.agentBars, chartType: .vertical, labelsCount: self.store.agentBars.count)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Image(systemName: "xmark.octagon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top)
                    
                    Text("Unable to fetch data!")
                        .font(.title)
                        .padding()
                    
                    Text("Please verify if the property URL is correct and try again.")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .onAppear(perform: fetchData)
        .navigationBarTitle(propertyUrl)
    }
    
    private func fetchData() {
        self.store.setProperty(url: self.propertyUrl)
        self.store.fetchData()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(propertyUrl: "simpleanalytics.com")
    }
}
