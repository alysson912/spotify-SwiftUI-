//
//  HomeViewModel.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 21/07/25.
//

import SwiftUI
import SwiftfulUI // SDK SwiftFulThinking
import SwiftfulRouting

@Observable // iOS 17+
final class HomeViewModel {
    
    let router: AnyRouter
    
     var currentUser: User? = nil
     var selectedCategory: Category? = nil
     var products: [Product] = []
     var productsRows: [ProductRow] = []
    
    init(router: AnyRouter) {
        self.router = router
        self.currentUser = currentUser
        self.selectedCategory = selectedCategory
        self.products = products
        self.productsRows = productsRows
    }
    
    //MARK: FUNCS
     func getData() async {
        
        guard products.isEmpty else { return }
        
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await  Array(DatabaseHelper().getProducts().prefix(8))// limitando para 8 itens
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand})) // set evita duplicar valores
            for brand in allBrands {
                //   let products = self.products.filter({$0.brand == brand})
                rows.append(ProductRow(title: brand ?? "", products: products))
            }
            productsRows = rows
        } catch {
            
        }
    }
    
    @MainActor  func goToPlayListView(product: Product) {
        guard let currentUser else { return }
        
        router.showScreen(.push) {_ in
            PlaylistView(product: product, user: currentUser)
        }
    }
    
    //MARK: COMPONENT GRID DO SDK
     var recentsSection: some View {
        
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                RecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                //MARK: SDK SWIFTFULTHINKING
                .asButton (.press){
                    self.goToPlayListView(product: product)
                }
            }
        }
    }
    
}
