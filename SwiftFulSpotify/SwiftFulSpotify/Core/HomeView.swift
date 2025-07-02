//
//  HomeView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 30/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 200, height: 200)
                            
                        }
                    } header: {
                        header
                    }
                })
                .padding(.top, 8)
            //   .scrollIndicators(.hidden) //ios16+
            }
            .clipped()
        }
        .task {
            await getData()
        }
        .navigationBarHidden(true) // Oculta a barra
       // .toolbar(.hidden, for: .navigationBar) //iOS 16+
    }
    
    
    //MARK: FUNCS
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            //     products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
    
    
    //MARK: UI COMPONENTS
    private var header : some View {
        HStack (spacing: 0){
            ZStack {
                if let currentUser = currentUser {
                    ImageLoaderView()
                    
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 40, height: 40)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 8.0) {
                    //MARK: enum com os Itens
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                
                .padding(.horizontal, 16)
            }
            //   .scrollIndicators(.hidden) //ios16+
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
}

#Preview {
    HomeView()
}
