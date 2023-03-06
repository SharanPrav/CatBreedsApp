//
//  ErrorView.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import SwiftUI

struct ErrorView: View {
    
    @StateObject var viewModel: BreedsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.errorMessage ?? "Something went wrong")
                .font(.headline)
                .padding(20)
            Button("Retry") {
                viewModel.displayCatBreeds()
            }.buttonStyle(.borderedProminent)
        }
    }
}
