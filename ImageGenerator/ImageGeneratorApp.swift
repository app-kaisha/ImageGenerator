//
//  ImageGeneratorApp.swift
//  ImageGenerator
//
//  Created by app-kaihatsusha on 15/03/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

@main
struct ImageGeneratorApp: App {
    
    @State var appManager = AppManager()
    
    var body: some Scene {
        WindowGroup {
            ImageGeneratorView()
                .environment(appManager)
        }
    }
}
