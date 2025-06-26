//
//  ContentView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 25/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(products) { product in
                    Text(product.title)
                        .font(.headline)
                    
                }
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
        private func getData() async {
            do {
                users = try await DatabaseHelper().getUsers()
                products = try await DatabaseHelper().getProducts()
            } catch {
                
            }
        }
    }



#Preview {
    ContentView()
}
