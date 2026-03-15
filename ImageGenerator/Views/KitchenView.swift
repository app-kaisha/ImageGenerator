//
//  KitchenView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import ImagePlayground

struct KitchenView: View {
    
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        
        @Bindable var appManager = appManager
        
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
        .imagePlaygroundSheet(
            isPresented: $appManager.showPlayground,
            concepts: appManager.imageGenerator.concepts,
            sourceImage: appManager.currentImage.map(Image.init),
            onCompletion: { url in
                if let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data) {
                    appManager.currentImage = uiImage
                }
            }
        )
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
