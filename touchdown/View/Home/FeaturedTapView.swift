//
//  FeaturedTapView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct FeaturedTapView: View {
    var body: some View {
        TabView {
            ForEach(players) { player in
                FeaturedItemView(player: player)
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct FeaturedTapView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedTapView()
            .previewDevice("iPhone 12 Pro")
            .background(Color.gray)
    }
}
