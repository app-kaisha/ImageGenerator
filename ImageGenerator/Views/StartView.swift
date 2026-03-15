//
//  StartView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import ImagePlayground

struct StartView: View {
    
    @State var imageGenerator = ImageGenerator()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Create a Unique Dish")
                .font(.largeTitle.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Label("Choose a dish", systemImage: "fork.knife")
                .padding(.top, 8)
            
            Picker("Recipes", selection: $imageGenerator.recipe) {
                ForEach(ImageGenerator.recipes, id:\.description) { recipe in
                    Text(recipe)
                }
            }
            
            Label("Choose an image style", systemImage: "paintpalette.fill")
                .padding(.top, 8)
            
            Picker("Styles", selection: $imageGenerator.style) {
                ForEach(ImageGenerator.styles) { style in
                    Text(style.id.capitalized)
                        .tag(style)
                }
            }
            
            Spacer()
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .frame(width: ImageGenerator.imageSize)
        .padding()
    }
}

#Preview {
    StartView()
}
