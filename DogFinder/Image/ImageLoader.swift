//
//  ImageLoader.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//

import SwiftUI
import NukeUI

// пакет https://github.com/kean/Nuke
// выбрать при добавлении в xcode после установки пакет NukeUI
struct ImageLoader: View {
    let url: URL?
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                NukeImageLoader(url: url)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

fileprivate struct NukeImageLoader: View {
    @State private var showError: Bool = false
    let url: URL?
    var body: some View {
 
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if state.error != nil {
                ZStack {
                    Color.red
                    Text("Error loading image")// Indicates an error
                }
            } else {
                Color.gray.opacity(0.1)
            }
        }
    }
}


#Preview {
    VStack {
        
        ImageLoader(url: nil)
        ImageLoader(url: .init(string: "https://fastly.picsum.photos/id/16/367/267.jpg?hmac=ZyyuET1a6X-Ym6MXK8OyHrdWFJiLI4To0iYLTlyrD-0")!)
        ImageLoader(url: .init(string:"https://fastly.WRONGURL")!)
        
    }
    
}


