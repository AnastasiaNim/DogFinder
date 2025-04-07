//
//  BreedDetails.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//
import SwiftUI
// все хорошо было поправил чуток лишние отступы привел все в еще более читабельный вид вынес картинку убрал лишние offset разбил повторяющийся код
// добавил кнопку назад кастомную
// все получилось хорошо 🫰🥖🥖🥖
struct BreedDetails: View {
    @Environment(\.dismiss) private var dismiss // так можно закрывать экран программно это функция
    let dog: Breed
    @State var likeButtonIsPressed: Bool = false
    static let textSize: Font = .system(size: 15)
    static let textColor: Color = .secondary
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                makeImage(size: geometry.size)
                VStack(spacing: 16) {
                    infoLine
                    detailedDescription
                }
                .padding(.horizontal, 20)
                .offset(y: -50)
            }
        }
        .background(Color.secondary.opacity(0.1))
        .ignoresSafeArea()
        .safeAreaInset(edge: .bottom) {
            favoritesButton
                .padding(.horizontal)
        }
        .safeAreaInset(edge: .top, alignment: .leading) {
            backButton
        }
        .navigationBarBackButtonHidden()
    }
}


extension BreedDetails {
    
    private func makeImage(size: CGSize) -> some View {
        ImageLoader(url: dog.imageURL)
            .frame(height: size.height * 0.4)
        //.cornerRadius(50, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .gray.opacity(0.4), radius: 15, y: 10)
    }
    
    private var infoLine: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text(dog.name)
                .font(.leckerliOne(size: 20))
                .foregroundStyle(.black)
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundStyle(Color.accentColor)
                Text(dog.origin ?? "")
                    .font(Self.textSize)
                    .foregroundStyle(Self.textColor)
                
                Spacer()
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.accent)
                    .rotationEffect(.degrees(30), anchor: .bottomTrailing)
                    .offset(y: 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            Color.white,
            in: RoundedRectangle(cornerRadius: 25)
        )
    }
    
    private var specificationsSection: some View  {
        
        HStack(spacing: 10) {
            InfoCellView(title: String(dog.lifeSpan?.dropLast(5) ?? "1"), subtitle: "Age")
            
            InfoCellView(title: "\(dog.weight.imperial.firstDigit) inch", subtitle: "Weight")
            
            InfoCellView(title: "\(dog.height.imperial.firstDigit) inch", subtitle: "Height")
            
        }
        
    }
    
    private var detailedDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle("Details")
                
                Text(dog.highlightDescription)
                    .font(Self.textSize)
                    .foregroundStyle(Self.textColor)
            }
            
            specificationsSection
            
            sectionView(title: "Temperament", subtitle: dog.temperament)
            
            sectionView(title: "Breed For", subtitle: dog.bredFor)
        }
        
    }
    
    private func sectionView(title: String,
                             subtitle: String?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionTitle(title)
            Text(subtitle ?? "")
                .font(Self.textSize)
                .foregroundStyle(Self.textColor)
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.black)
            .font(.leckerliOne(size: 20))
    }
    
    private var favoritesButton: some View {
        Button {
            likeButtonIsPressed.toggle()
            
        } label: {
            
            HStack {
                Image( systemName: likeButtonIsPressed ? "trash" : "star.fill")
                
                Text(likeButtonIsPressed ? "Delete from Favorite" : "Add to Favorite")
            }
            .font(BreedDetails.textSize)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(Color.accent, in: RoundedRectangle(cornerRadius: 10))
            
        }
    }
    
    //кастомная кнопка назад
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 23).weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal)
        }
    }
    
    private struct InfoCellView: View {
        let title: String
        let subtitle: String
        
        var body: some View {
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(BreedDetails.textColor)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "pawprint.fill")
                    .foregroundColor(BreedDetails.textColor.opacity(0.07))
                    .font(.system(size: 50))
                    .rotationEffect(Angle(degrees: -30))
                    .offset(x: 10, y: 10)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}


#Preview {
    BreedDetails(dog: Breed.mockBreeds.first!)
}




