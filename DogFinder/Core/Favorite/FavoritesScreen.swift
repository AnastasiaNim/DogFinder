//
//  FavoritesScreen.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//
import SwiftUI

struct FavoritesScreen: View {
    
    @EnvironmentObject var favoriteDogs: BreedFavoritesManager
    @State private var showAlert: Bool = false
    @State var selectedBreed: Breed? = nil
    
    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2).ignoresSafeArea()
            
            if favoriteDogs.breeds.isEmpty {
                emptyFavoritesView
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        headerSection
                        sectionFavoritesBreeds
                    }
                    .padding(15)
                    .animation(.easeInOut, value: favoriteDogs.breeds)
                    
                    .alert(isPresented: $showAlert, content: deletionAlert)
                }
            }
        }
    }
}

#Preview {
    FavoritesScreen()
        .environmentObject(BreedFavoritesManager())
}

extension FavoritesScreen {
    
    
    private var emptyFavoritesView: some View {
        VStack(spacing: 10) {
            
            Text("You don't have any breeds in your favorites yet.")
                .foregroundStyle(Color.accent)
            Text("🐩")
        }
        .font(.system(size: 20))
        .multilineTextAlignment(.center)
    }
    
    private var headerSection: some View {
        Group {
            Text("Favorites")
                .font(.leckerliOne(size: 35))
            
            Text("Did you find the breed you like? Add this breed to your favorites."
                .attributed(highlights: ["Add this breed"]))
            .font(.system(size: 20))
            .foregroundStyle(.secondary)
        }
    }
    private var sectionFavoritesBreeds: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(favoriteDogs.breeds) { breed in
                NavigationLink(value: FavoritesLink.details(breed)) {
                    FavoritesCell(
                        dog: breed,
                        onRemove: { 
                            selectedBreed = breed
                            showAlert = true
                        }
                    )
                    .frame(height: 250)
                    .padding(5)
                }
                
            }
        }
        
    }
    
    private var deletionAlert: () -> Alert {
        {
            Alert(
                title: Text("Do you really want to delete from favorites \(selectedBreed?.name ?? "")?"),
                message: Text(""),
                primaryButton: .default(
                    Text("No, I can't. Too cute!👹"),
                    action: {
                        showAlert = false
                        selectedBreed = nil
                    }),
                secondaryButton: .destructive(
                    Text("Delete!🧹"),
                    action: {
                        if let id = selectedBreed?.id {
                            favoriteDogs.removeBreed(id)
                        }
                        showAlert = false
                        selectedBreed = nil
                    }
                )
            )
        }
    }
}


