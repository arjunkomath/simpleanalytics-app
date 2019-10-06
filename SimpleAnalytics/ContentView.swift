//
//  ContentView.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 1/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        NavigationView {
            MasterView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
