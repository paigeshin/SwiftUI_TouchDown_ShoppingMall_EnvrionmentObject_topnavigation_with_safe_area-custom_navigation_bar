//
//  TouchdownApp.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/14.
//

import SwiftUI

struct TouchdownApp: View {
    var body: some View {
        ContentView()
            .environmentObject(Shop())
    }
}

struct TouchdownApp_Previews: PreviewProvider {
    static var previews: some View {
        TouchdownApp()
    }
}
