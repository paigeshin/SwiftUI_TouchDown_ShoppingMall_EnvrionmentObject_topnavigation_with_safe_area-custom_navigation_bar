//
//  Shop.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import Foundation

class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}
