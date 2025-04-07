//
//  SearchBarView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI


struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.secondary :  Color.accent)
            
            TextField("Search by ...", text: $searchText)
                .foregroundStyle(Color.accent)
                .autocorrectionDisabled(true)
                .multilineTextAlignment(.leading)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.background)
                .shadow(color: Color.accent.opacity(0.15),
                        radius: 10, x: 0.0, y: 0.0)
        )
        .padding(.bottom, 20)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

