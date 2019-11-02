//
//  BrowsersDetail.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 2/11/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import SwiftUI

struct BrowsersDetail: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        List(store.getAgents(), id: \.browser_name) { agent in
            Text(agent.browser_name)
                .font(.headline)
            Spacer()
            Text("\(agent.count)")
        }
        .navigationBarTitle("Browsers")
    }
}

struct BrowsersDetail_Previews: PreviewProvider {
    static var previews: some View {
        BrowsersDetail()
    }
}
