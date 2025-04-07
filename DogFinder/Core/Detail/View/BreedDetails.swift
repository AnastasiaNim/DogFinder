//
//  BreedDetails.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//

import SwiftUI


struct DetailLoadingView: View {
    @Binding var dog: DogModel?
    
    var body: some View {
        ZStack {
            if let dog = dog {
                BreedDetails(dog: dog)
            }
        }
    }
}

struct BreedDetails: View {
    @StateObject private var vm: DetailViewModel
    
    init(dog: DogModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(dog: dog))
        print("initializing Detail View for \(dog.name)")
    }
    var body: some View {
        Text("")
    }
}



#Preview {
    BreedDetails(dog: <#DogModel#>)
}
