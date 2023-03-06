//
//  RowVIew.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import SwiftUI

struct RowView: View {
    
    let breed: Breed
    let imageSize: CGFloat = 100
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            AsyncImage(url: breed.imageUrl) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                } else if phase.error != nil {
                    Color.gray
                        .frame(width: imageSize, height: imageSize)
                        .overlay(Text("No Image").font(.caption), alignment: .center)
                } else {
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                }
            }.clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading, spacing: 10) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.origin)
                    .font(.subheadline)
                Text(breed.temperament)
                    .font(.caption)
            }
            .padding(.trailing, 10)
            .padding(.vertical, 5)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        let breed = Breed.example()
        RowView(breed: breed)
    }
}
