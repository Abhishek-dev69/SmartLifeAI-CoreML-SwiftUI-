//
//  Phone.swift
//  SmartLifeAI
//
//  Created by Abhishek on 12/02/26.
//
import Foundation

struct Phone: Identifiable {
    let id = UUID()
    let brand: String
    let model: String
    let price: Double
}
