import SwiftUI

struct PhonePriceResultView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 24) {

            VStack(alignment: .leading, spacing: 8) {
                Text("Estimated Market Value")
                    .foregroundColor(.secondary)

                Text("₹\(Int(appState.predictedPrice))")
                    .font(.largeTitle)
                    .bold()

                Text("\(appState.selectedBrand) • \(appState.selectedModel)")
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                featureCard("Processor", appState.selectedBrand == "Apple" ? "A-Series" : "Snapdragon")
                featureCard("Battery", "4000+ mAh")
                featureCard("Camera", "High-Res")
                featureCard("RAM", "6 GB")
            }

            Button {
                // next: loan eligibility
            } label: {
                Text("Continue to Loan Check →")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer()
        }
        .padding()
        .navigationTitle("Price Check")
        .navigationBarTitleDisplayMode(.inline)
    }

    func featureCard(_ title: String, _ value: String) -> some View {
        VStack {
            Text(title).font(.caption)
            Text(value).bold()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

