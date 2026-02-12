//
//  AppState.swift
//  SmartLifeAI
//
//  Created by Abhishek on 12/02/26.
//

import Foundation
import SwiftUI
import Combine

final class AppState: ObservableObject {

    @Published var predictedPrice: Double = 0
    @Published var confidence: Double = 0.92

    @Published var selectedBrand: String = "Apple"
    @Published var selectedModel: String = "iPhone 14"

    // 🔥 NEW
    @Published var similarPhones: [Phone] = []
}

