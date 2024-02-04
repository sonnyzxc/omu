//
//  WardrobeView.swift
//  omu
//
//  Created by Nutchalai Sawatyanon on 04/02/2024.
//

import SwiftUI

struct WardrobeView: View {
    var boughtClothes: [ClothingItem]
        
        var body: some View {
            NavigationView {
                List(boughtClothes) { item in
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("My Wardrobe")
            }
        }
}

#Preview {
    WardrobeView()
}
