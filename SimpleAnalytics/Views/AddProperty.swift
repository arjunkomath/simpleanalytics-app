//
//  AddProperty.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 4/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct AddProperty: View {
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @EnvironmentObject var store: AppStore
    
    @State private var propertyUrl = ""
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.presentation.wrappedValue.dismiss();
            }) {
                Text("Done")
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .trailing)
            .padding(.horizontal)
            
            Form {
                Section(header: Text("Add new property")) {
                    Text("Enter Property URL")
                        .bold()
                    
                    TextField("URL", text: $propertyUrl)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                }
                
                Button(action: {
                    if (self.propertyUrl != "") {
                        self.addProperty()
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                }
            }
        }
    }
    
    func addProperty() {
        self.store.addProperty(name: self.propertyUrl)
    }
}

struct AddProperty_Previews: PreviewProvider {
    static var previews: some View {
        AddProperty()
    }
}
