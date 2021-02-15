//
//  ContentView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/14.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            // ConditaionView with `EnvironmentObject`
            if shop.showingProduct == false && shop.selectedProduct == nil {
                VStack(spacing: 0) {
                    NavigationBarView()
                        .padding()
                        .padding(.bottom)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    ScrollView(.vertical, showsIndicators: false, content:  {
                        VStack(spacing: 0) {
                            FeaturedTapView()
                                .padding(.vertical, 20)
                            
                            CategoryGridview()
                            
                            TitleView(title: "Helmets")
                            
                            // LazyVGrid, LazyHGrid, 보이지 않는 화면은 rendering하지 않는다. Better Performance
                            // gridLayout: row 2를 가지고 있는 super global variable
                            LazyVGrid(columns: gridLayout, spacing: 15, content: {
                                ForEach(products) { product in
                                    ProductItemView(product: product)
                                        /* Change Screen with `EnvironmentObject` instead of NavigationLink */
                                        .onTapGesture {
                                            feedback.impactOccurred()
                                            
                                            withAnimation(.easeOut) {
                                                shop.selectedProduct = product
                                                shop.showingProduct = true
                                            }
                                        }
                                } //: LOOP
                            }) //: GRID
                            .padding(15)
                            
                            TitleView(title: "Brands")
                            
                            BrandgridView()
                            
                            FooterView()
                                .padding(.horizontal)
                        } //: VSTACK
                    }) //: SCROLL
                    
                
                } //: VSTACK
                .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            } else {
                ProductDetailView()
            }
        } //: ZSTACK
        .ignoresSafeArea(.all, edges: .top)
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Shop())
    }
}
