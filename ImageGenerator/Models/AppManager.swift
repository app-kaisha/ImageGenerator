//
//  AppManager.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

@Observable
class AppManager {
    let imageGenerator = ImageGenerator()
    
    private(set) var error: Error?
    private(set) var isGenerating = false
    
    func generateImage() {
        error = nil
        isGenerating = true
        
        Task {
            do {
                let generatedImage = try await imageGenerator.generate()
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
