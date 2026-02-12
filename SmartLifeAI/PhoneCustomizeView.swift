import SwiftUI
import CoreML

struct PhoneCustomizeView: View {

    @EnvironmentObject var appState: AppState
    @State private var goToResult = false

    // Inputs
    @State private var ram: Double = 6
    @State private var storage: Int = 128
    @State private var battery: Double = 3279
    @State private var camera: Double = 12
    @State private var screenSize: Double = 6.1

    var availableModels: [String] {
        PhoneCatalog.models(for: appState.selectedBrand)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("Choose Your Smartphone")
                    .font(.largeTitle)
                    .bold()

                Text("We'll estimate the price using AI")
                    .foregroundColor(.secondary)

                // BRAND
                HStack(spacing: 12) {
                    brandButton("Apple")
                    brandButton("Samsung")
                    brandButton("Google")
                    brandButton("OnePlus")
                    brandButton("Xiaomi")
                }

                // MODEL (🔥 REQUIRED)
                VStack(alignment: .leading) {
                    Text("Model").bold()

                    Picker("Model", selection: $appState.selectedModel) {
                        ForEach(availableModels, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                }

                sliderBlock("RAM Memory", "\(Int(ram)) GB", 4...16, 2, $ram)

                segmentedBlock("Internal Storage", [64, 128, 256, 512], $storage)

                sliderBlock("Battery Capacity", "\(Int(battery)) mAh", 3000...6000, 100, $battery)

                sliderBlock("Main Camera", "\(Int(camera)) MP", 12...200, 4, $camera)

                Button {
                    predictPrice()
                    goToResult = true
                } label: {
                    Text("✨ Predict Price")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                NavigationLink(
                    destination: PhonePriceResultView(),
                    isActive: $goToResult
                ) { EmptyView() }
            }
            .padding()
        }
        .onAppear {
            // ✅ Safe default
            appState.selectedModel = availableModels.first ?? ""
        }
        .onChange(of: appState.selectedBrand) { _ in
            appState.selectedModel = availableModels.first ?? ""
        }
    }

    // MARK: - Prediction
    func predictPrice() {
        do {
            let model = try PhonePriceRegression_mlmodel_(configuration: .init())

            let input = PhonePriceRegression_mlmodel_Input(
                brand_name: appState.selectedBrand,
                model: appState.selectedModel,
                screen_size: screenSize,
                operating_system: appState.selectedBrand == "Apple" ? "iOS" : "Android",
                battery_capacity: Int64(battery),
                ram: Int64(ram),
                storage: Int64(storage),
                camera_mp: Int64(camera),
                front_camera_mp: 12
            )

            let result = try model.prediction(input: input)
            let raw = result.price

            appState.predictedPrice = max(5_000, min(raw, 200_000))

        } catch {
            print("Prediction error:", error)
        }
    }

    // MARK: - UI Helpers
    func brandButton(_ name: String) -> some View {
        Button {
            appState.selectedBrand = name
        } label: {
            Text(name)
                .padding()
                .background(appState.selectedBrand == name ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                .cornerRadius(12)
        }
    }

    func sliderBlock(_ title: String, _ value: String, _ range: ClosedRange<Double>, _ step: Double, _ binding: Binding<Double>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title).bold()
                Spacer()
                Text(value).foregroundColor(.blue)
            }
            Slider(value: binding, in: range, step: step)
        }
    }

    func segmentedBlock(_ title: String, _ options: [Int], _ selection: Binding<Int>) -> some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) {
                    Text("\($0)").tag($0)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

