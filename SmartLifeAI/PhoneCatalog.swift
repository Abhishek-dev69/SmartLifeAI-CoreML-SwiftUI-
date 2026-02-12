import Foundation

struct PhoneCatalog {

    static let all: [Phone] = [

        // Apple
        Phone(brand: "Apple", model: "iPhone 11", price: 49999),
        Phone(brand: "Apple", model: "iPhone 12", price: 59999),
        Phone(brand: "Apple", model: "iPhone 13", price: 69999),
        Phone(brand: "Apple", model: "iPhone 14", price: 79999),
        Phone(brand: "Apple", model: "iPhone 15", price: 89999),

        // Samsung
        Phone(brand: "Samsung", model: "Galaxy S21", price: 64999),
        Phone(brand: "Samsung", model: "Galaxy S22", price: 69999),
        Phone(brand: "Samsung", model: "Galaxy S23", price: 74999),

        // Google
        Phone(brand: "Google", model: "Pixel 7", price: 59999),
        Phone(brand: "Google", model: "Pixel 8", price: 75999),

        // OnePlus
        Phone(brand: "OnePlus", model: "OnePlus 10", price: 54999),
        Phone(brand: "OnePlus", model: "OnePlus 11", price: 61999)
    ]

    // ✅ BRAND → MODELS (derived, not hardcoded separately)
    static func models(for brand: String) -> [String] {
        all
            .filter { $0.brand == brand }
            .map { $0.model }
    }

    // ✅ SIMILAR PHONES BY PRICE RANGE (future-proof)
    static func phones(in range: ClosedRange<Double>) -> [Phone] {
        all.filter { range.contains($0.price) }
    }
}

