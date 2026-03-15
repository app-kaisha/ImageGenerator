//
//  AppManager.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import ImagePlayground

@Observable
class AppManager {
    let imageGenerator = ImageGenerator()
    var currentImage: UIImage?
    var showPlayground = false
    
    private(set) var error: Error?
    private(set) var isGenerating = false
    private var task: Task<Void, Never>?
    
    func generateImage() {
        error = nil
        isGenerating = true
        task?.cancel()
        
        task = Task {
            do {
                let generatedImage = try await imageGenerator.generate()
                currentImage = UIImage(cgImage: generatedImage.cgImage)
                isGenerating = false
            } catch {
                do {
                    try Task.checkCancellation()
                    self.error = error
                    isGenerating = false
                } catch {
                    // Task Cancelled
                }
                
            }
        }
    }
    
    func reset() {
        imageGenerator.resetGenerator()
        currentImage = nil
        error = nil
        isGenerating = false
        task?.cancel()
    }
    
    func add(ingredient: String) {
        imageGenerator.ingredients.append(ingredient)
        generateImage()
    }
    
    var showKitchen: Bool {
        currentImage != nil || isGenerating
    }
}

extension View {
    func previewEnvironment(generateImage: Bool = false) -> some View {
        let appManager = AppManager()
        //appManager.imageGenerator.ingredients.append("Strawberry")
        return environment(appManager)
            .onAppear {
                if generateImage {
                    appManager.imageGenerator.style = .animation
                    appManager.generateImage()
                }
            }
    }
}
