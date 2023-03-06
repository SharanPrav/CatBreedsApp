//
//  BreedListView.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import SwiftUI

struct BreedListView: View {
    @StateObject var viewModel = BreedsViewModel(service: CatServcie())
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 100, height: 100, alignment: .center)
            } else if viewModel.errorMessage != nil {
                ErrorView(viewModel: viewModel)
            } else {
                List {
                    ForEach(viewModel.breeds) { breed in
                        RowView(breed: breed)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
                .refreshable {
                    viewModel.displayCatBreeds()
                }
            
                .listStyle(.plain)
                .navigationTitle("Cat Breeds")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView()
    }
}

