//
//  KitchenView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct KitchenView: View {
    
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Refine Your Dish")
                .font(.largeTitle.weight(.semibold))
            
            imageArea
            
            ImageButtonsView()
            IngredientsListView()
            
            Spacer()
            if let error = appManager.error {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Start Over", systemImage: "chevron.left") {
                    appManager.reset()
                }
            }
        }
    }
    
    private var imageArea: some View {
        Group {
            if let image = appManager.currentImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                
                Rectangle()
                    .fill(.gray.opacity(0.2))
            }
        }
        .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        KitchenView()
            .previewEnvironment()
    }
}
