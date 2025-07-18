//
//  ContentView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 25/06/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router
    
    
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover){_ in
                    HomeView(viewModel: HomeViewModel(router: router))
                }
            }
        }
        
    }
        
        
    }



#Preview {
    RouterView { _ in
        ContentView()
    }
}
