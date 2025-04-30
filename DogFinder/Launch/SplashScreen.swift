//
//  SplashScreen.swift
//  DogFinder
//
//  Created by Anastasia N.  on 29.04.2025.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var showContent: Bool
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("splashImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Snout Scout")
                    .font(.leckerliOne(size: 50))
                    .foregroundStyle(Color.accentColor)
                    .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut) {
                    showContent = true
                }
            }
            
        }
    }
}

#Preview {
    SplashScreen(showContent: .constant(true))
}
