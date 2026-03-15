//
//  ImageButtonsView.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ImageButtonsView: View {
    
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        regenerateButton
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    shareButton
                }
            }
    }
    
    private var regenerateButton: some View {
        Button("Regenerate", systemImage: "arrow.clockwise") {
            appManager.generateImage()
        }
        .buttonStyle(.plain)
        .font(.footnote)
        .disabled(!appManager.showKitchen || appManager.isGenerating)
    }
    
    @ViewBuilder
    private var shareButton: some View {
        if let image = appManager.currentImage {
            let preview = SharePreview("My Recipe", image: Image(uiImage: image))
            ShareLink(
                item: Image(uiImage: image),
                preview: preview) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        ImageButtonsView()
            .previewEnvironment(generateImage: false)
    }
}
