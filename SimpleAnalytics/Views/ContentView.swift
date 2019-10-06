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
    
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.properties, id: \.self) { propertyUrl in
                    NavigationLink(destination: DetailView(propertyUrl: propertyUrl)) {
                        Text(propertyUrl)
                    }
                }.onDelete(perform: delete)
            }
            .navigationBarTitle("Properties")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showActionSheet.toggle()
                }) {
                    Text("Add property")
                }
            ).sheet(isPresented: $showActionSheet) {
                AddProperty().environmentObject(self.store)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        self.store.removeProperty(offsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
