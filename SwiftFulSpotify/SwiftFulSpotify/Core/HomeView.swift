//
//  HomeView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 30/06/25.
//

import SwiftUI
import SwiftfulUI // SDK SwiftFulThinking

struct HomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack (spacing: 16){
                            recentsSection
                            
                            if let product = products.first {
                          newReleasesSection(product: product)
                                
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        
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
            products = try await  Array(DatabaseHelper().getProducts().prefix(8))// limitando para 8 itens
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
//                        
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
  //MARK: COMPONENT GRID DO SDK
    private var recentsSection: some View {
        
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                RecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
            }
        }
    }

    private func newReleasesSection(product: Product) -> some View {
        NewReleaseCell(
            
            imageName: product.firstImage,
            headline: product.brand,
            subHeadline: product.category,
            title: product.title,
            subtitle: product.description,
            
            onAddToPlayListPressed: {
                //MARK: IMPREMENTAR ACTION BUTTON
            },
               
            onPlayPressed: {
                //MARK: IMPREMENTAR ACTION BUTTON
            }
        )
    }
}

#Preview {
    HomeView()
}
