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
    
    private(set) var error: Error?
    private(set) var isGenerating = false
    
    func generateImage() {
        error = nil
        isGenerating = true
        
        Task {
            do {
                let generatedImage = try await imageGenerator.generate()
                currentImage = UIImage(cgImage: generatedImage.cgImage)
                isGenerating = false
            } catch {
                self.error = error
                isGenerating = false
            }
        }
    }
}

extension View {
    func previewEnvironment() -> some View {
        let appManager = AppManager()
        return environment(appManager)
    }
}
