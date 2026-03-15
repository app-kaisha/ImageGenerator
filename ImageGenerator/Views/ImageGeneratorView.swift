//
//  ImageGeneratorView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ImageGeneratorView: View {
    
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if appManager.showKitchen {
                    KitchenView()
                } else {
                    StartView()
                }
            }
            .overlay {
                if appManager.isGenerating {
                    loadingView()
                }
            }
        }
    }
    
    private func loadingView() -> some View {
        HStack(spacing: 8) {
            ProgressView()
            Text("Generating Image...")
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        ImageGeneratorView()
            .previewEnvironment()
    }
}
