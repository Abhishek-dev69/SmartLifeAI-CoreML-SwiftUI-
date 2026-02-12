//
//  SmartLifeAIApp.swift
//  SmartLifeAI
//
//  Created by Abhishek on 12/02/26.
//

import SwiftUI

@main
struct SmartLifeAIApp: App {

    @StateObject private var appState = AppState() // ✅ CREATE ONCE

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState) // ✅ INJECT HERE
        }
    }
}
