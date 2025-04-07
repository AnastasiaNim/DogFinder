//
//  BreedRowView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI

struct BreedRowView: View {
    
    let breed: Breed
    let imageWidth: CGFloat = 150
    let rowHeight: CGFloat = 200
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(breed.name)
                    .font(.leckerliOne(size: 23))
                    .padding(.bottom, 10)
                Text(breed.temperament ?? "")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: "scalemass")
                        .foregroundStyle(.accent)
                        .fontWeight(.bold)
                    Text("\(breed.weight.imperial) lbc")
                        .foregroundStyle(.secondary)
                        .bold()
                }
            }
            
            Spacer()
            ImageLoader(url: breed.imageURL)
                .frame(width: imageWidth)
                .cornerRadius(25)
        }
        .padding()
        .frame(height: rowHeight)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 30.0))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 0)
    }
}

#Preview {
    
    ZStack {
        Color.gray.opacity(0.7)
            .ignoresSafeArea()
        
        BreedRowView(breed: Breed.mockBreeds.first!)
    }
}
