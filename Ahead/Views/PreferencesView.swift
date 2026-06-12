import SwiftUI

struct PreferencesView: View {
    @State private var selectedTransport: String? = nil
    @State private var selectedInterests: Set<String> = []
    @State private var avoidCrowdedPlaces = true

    let transportOptions = ["🚶 Walk", "🚲 Bike", "🚌 Transit", "🚗 Car"]
    let interestOptions = ["Parks", "Food", "Culture", "Sports"]

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.95, blue: 0.92)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 28) {
                Text("How do you get around?")
                    .font(.system(size: 20, weight: .bold))

                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 18) {
                    ForEach(transportOptions, id: \.self) { option in
                        preferenceButton(
                            title: option,
                            isSelected: selectedTransport == option
                        ) {
                            selectedTransport = option
                        }
                    }
                }

                Divider()

                Text("Interests")
                    .font(.system(size: 20, weight: .bold))

                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 18) {
                    ForEach(interestOptions, id: \.self) { option in
                        preferenceButton(
                            title: option,
                            isSelected: selectedInterests.contains(option)
                        ) {
                            if selectedInterests.contains(option) {
                                selectedInterests.remove(option)
                            } else {
                                selectedInterests.insert(option)
                            }
                        }
                    }
                }

                Divider()

                Text("Avoid")
                    .font(.system(size: 20, weight: .bold))

                HStack {
                    Text("Crowded Places")
                        .font(.system(size: 16, design: .monospaced))
                        .foregroundColor(Color(red: 0.0, green: 0.55, blue: 0.40))

                    Spacer()

                    Toggle("", isOn: $avoidCrowdedPlaces)
                        .labelsHidden()
                        .tint(Color(red: 0.10, green: 0.65, blue: 0.50))
                }
                .padding()
                .background(.white)
                .cornerRadius(12)

                Spacer()

                NavigationLink {
                    PermissionsView()
                } label: {
                    Text("Next")
                        .font(.system(size: 17, weight: .semibold, design: .monospaced))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .background(Color(red: 0.10, green: 0.65, blue: 0.50))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 28)
            .padding(.top, 70)
            .padding(.bottom, 34)
        }
        .navigationBarBackButtonHidden(false)
    }

    private func preferenceButton(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    isSelected
                    ? Color(red: 0.0, green: 0.36, blue: 0.30)
                    : Color(red: 0.10, green: 0.65, blue: 0.50)
                )
                .cornerRadius(8)
        }
    }
}

#Preview {
    NavigationStack {
        PreferencesView()
    }
}
