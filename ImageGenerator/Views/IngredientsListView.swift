//
//  IngredientsListView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct IngredientsListView: View {
    
    @Environment(AppManager.self) private var appManager
    
    @State private var newIngredient = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TextField("Add Ingredients (optional)", text: $newIngredient)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    appManager.add(ingredient: newIngredient)
                    newIngredient = ""
                }
            
            if !appManager.imageGenerator.ingredients.isEmpty {
                Text("Added Ingredients")
                    .font(.body.bold())
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem(), GridItem()]){
                    ForEach(appManager.imageGenerator.ingredients, id: \.description) { ingredient in
                        field(ingredient: ingredient)
                    }
                }
            }
        }
    }
    
    private func field(ingredient: String) -> some View {
        HStack {
            Text(ingredient.capitalized)
                .lineLimit(1)
            Spacer()
            Button {
                //appManager.remove(ingredient: ingredient)
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.plain)

        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .foregroundStyle(.white)
        .background(.blue, in: Capsule())
    }
}

#Preview {
    IngredientsListView()
        .previewEnvironment()
        .padding()
}
