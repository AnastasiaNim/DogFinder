//
//  FavoritesCell.swift
//  DogFinder
//
//  Created by Anastasia N.  on 23.04.2025.
//

import SwiftUI

struct FavoritesCell: View {
    let dog: Breed
    let onRemove: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            imageBreed
            HStack(spacing: 0) {
                nameBreed
                Spacer()
                
                deleteButton
            }
            .padding(.top, 8)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    ZStack {
        Color.secondary.opacity(0.2).ignoresSafeArea()
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
                FavoritesCell(dog: Breed.mockBreeds.first!) {
                    print("Remove dog with id")
                }
                .frame(height: 200)
            }
            .padding()
        }
    }
}
extension FavoritesCell {
    
    private var imageBreed: some View {
        ImageLoader(url: dog.imageURL)
            .cornerRadius(20)
    }
    
    private var nameBreed: some View {
        Text(dog.name)
            .font(.leckerliOne(size: 16))
            .foregroundStyle(Color.black.opacity(0.7))
            .lineLimit(1)
    }
    
    private var deleteButton: some View {
        Button {
            onRemove()
        } label: {
            Image(systemName: "trash")
                .font(.system(size: 15))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
        }
    }
}
