//
//  ProductItemView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct ProductItemView: View {
    // MARK: - PROPERTY
    let product: Product
    
    // MARK: - BODY
    var body: some View {
        
        let productBackgroundColor = Color(red: product.red, green: product.green, blue: product.blue)
        
        VStack(alignment: .leading, spacing: 6, content: {
            // PHOTO
            ZStack {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            } //: ZSTACK
            .background(productBackgroundColor)
            .cornerRadius(12)
            
            // NAME
            Text(product.name)
                .font(.title3)
                .fontWeight(.black)
            
            // PRICE
            Text(product.formattedPrice)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
        }) //: VSTACK
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: products[0])
            .previewLayout(.fixed(width: 200, height: 300))
            .padding()
            .background(colorBackground)
    }
}
