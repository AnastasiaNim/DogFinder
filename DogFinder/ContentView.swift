//
//  ContentView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 29.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentedContent: Bool = false
    var body: some View {
        if isPresentedContent {
            RootView()
        } else {
            SplashScreen(showContent: $isPresentedContent)
        }
    }
}

#Preview {
    ContentView()
}
