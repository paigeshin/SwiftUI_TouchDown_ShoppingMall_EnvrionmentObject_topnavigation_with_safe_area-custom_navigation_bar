//
//  CategoryItemvIEW.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct CategoryItemView: View {
    // MARK: - PROPERTY
    
    let category: Category

    // MARK: - BODY
    var body: some View {
        Button(action: {}, label: {
            HStack(alignment: .center, spacing: 6, content: {
                
                Image(category.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.gray)
                
                Text(category.name.uppercased())
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                
                Spacer()
                
            }) //: HSTACK
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }) //: BUTTON
    }
}

struct CategoryItemvIEW_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: categories[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
