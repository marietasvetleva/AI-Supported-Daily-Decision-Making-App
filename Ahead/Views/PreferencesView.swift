import SwiftUI


struct PreferencesView: View {

    @EnvironmentObject var preferencesVM: UserPreferencesViewModel

    struct PreferencesView: View {
        @State private var selectedTransport: String? = nil
        @State private var selectedDecisionStyle: String? = nil
        @State private var selectedPlaces: Set<String> = []
        @State private var avoidCrowdedPlaces = false
        @State private var preferQuietPlaces = false
        @State private var maxWalkingMinutes = 15.0

        let transportOptions = ["🚶 Walk", "🚲 Bike", "🚌 Transit", "🚗 Car"]

        let decisionStyleOptions = [
            "Fastest",
            "Quiet",
            "Cheap",
            "Balanced"
        ]

        let placeOptions = [
            "Cafes",
            "Study spots",
            "Parks",
            "Food"
        ]

        var body: some View {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tell Ahead about you")
                                .font(.system(size: 32, weight: .bold))

                            Text("This helps the AI recommend better routes, places, and activities.")
                                .font(.system(size: 16))
                                .foregroundColor(.labelGray)
                        }

                        sectionTitle("How do you usually move?")

                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                            ForEach(transportOptions, id: \.self) { option in
                                preferenceButton(
                                    title: option,
                                    isSelected: selectedTransport == option
                                ) {
                                    selectedTransport = option
                                }
                            }
                        }

                        sectionTitle("What matters most?")

                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                            ForEach(decisionStyleOptions, id: \.self) { option in
                                preferenceButton(
                                    title: option,
                                    isSelected: selectedDecisionStyle == option
                                ) {
                                    selectedDecisionStyle = option
                                }
                            }
                        }

                        sectionTitle("Places you like")

                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                            ForEach(placeOptions, id: \.self) { option in
                                preferenceButton(
                                    title: option,
                                    isSelected: selectedPlaces.contains(option)
                                ) {
                                    if selectedPlaces.contains(option) {
                                        selectedPlaces.remove(option)
                                    } else {
                                        selectedPlaces.insert(option)
                                    }
                                }
                            }
                        }

                        sectionTitle("Comfort preferences")

                        ToggleRow(
                            title: "Avoid crowded places",
                            isOn: $avoidCrowdedPlaces
                        )

                        ToggleRow(
                            title: "Prefer quiet places",
                            isOn: $preferQuietPlaces
                        )

                        sectionTitle("Max walking time")

                        VStack(alignment: .leading, spacing: 12) {
                            Text("\(Int(maxWalkingMinutes)) minutes")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.accentGreen)

                            Slider(value: $maxWalkingMinutes, in: 5...45, step: 5)
                                .tint(.accentGreen)
                        }
                        .padding()
                        .background(Color.cardBackground)
                        .cornerRadius(16)

                        NavigationLink {
                            PermissionsView()
                        } label: {
                            Text("Next")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 58)
                                .background(Color.accentGreen)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 60)
                    .padding(.bottom, 34)
                }
            }
        }

        private func sectionTitle(_ title: String) -> some View {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.labelGray)
        }

        private func preferenceButton(
            title: String,
            isSelected: Bool,
            action: @escaping () -> Void
        ) -> some View {
            Button(action: action) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .accentGreen)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        isSelected
                        ? Color.accentGreen
                        : Color.cardBackground
                    )
                    .cornerRadius(14)
            }
            .buttonStyle(.plain)
        }
    }

    struct ToggleRow: View {
        let title: String
        @Binding var isOn: Bool

        var body: some View {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))

                Spacer()

                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(.accentGreen)
            }
            .padding()
            .background(Color.cardBackground)
            .cornerRadius(16)
        }
    }

    #Preview {
        NavigationStack {
            PreferencesView()
        }
    }

    @State private var selectedTransport: String? = nil
    @State private var selectedDecisionStyle: String? = nil
    @State private var selectedPlaces: Set<String> = []
    @State private var avoidCrowdedPlaces = true
    @State private var preferQuietPlaces = true
    @State private var maxWalkingMinutes = 15.0

    let transportOptions = ["🚶 Walk", "🚲 Bike", "🚌 Transit", "🚗 Car"]

    let decisionStyleOptions = [
        "Fastest",
        "Quiet",
        "Cheap",
        "Balanced"
    ]

    let placeOptions = [
        "Cafes",
        "Study spots",
        "Parks",
        "Food"
    ]

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tell Ahead about you")
                            .font(.system(size: 32, weight: .bold))

                        Text("This helps the AI recommend better routes, places, and activities.")
                            .font(.system(size: 16))
                            .foregroundColor(.labelGray)
                    }

                    sectionTitle("How do you usually move?")

                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                        ForEach(transportOptions, id: \.self) { option in
                            preferenceButton(
                                title: option,
                                isSelected: selectedTransport == option
                            ) {
                                selectedTransport = option
                            }
                        }
                    }

                    sectionTitle("What matters most?")

                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                        ForEach(decisionStyleOptions, id: \.self) { option in
                            preferenceButton(
                                title: option,
                                isSelected: selectedDecisionStyle == option
                            ) {
                                selectedDecisionStyle = option
                            }
                        }
                    }

                    sectionTitle("Places you like")

                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                        ForEach(placeOptions, id: \.self) { option in
                            preferenceButton(
                                title: option,
                                isSelected: selectedPlaces.contains(option)
                            ) {
                                if selectedPlaces.contains(option) {
                                    selectedPlaces.remove(option)
                                } else {
                                    selectedPlaces.insert(option)
                                }
                            }
                        }
                    }

                    sectionTitle("Comfort preferences")

                    ToggleRow(
                        title: "Avoid crowded places",
                        isOn: $avoidCrowdedPlaces
                    )

                    ToggleRow(
                        title: "Prefer quiet places",
                        isOn: $preferQuietPlaces
                    )

                    sectionTitle("Max walking time")

                    VStack(alignment: .leading, spacing: 12) {
                        Text("\(Int(maxWalkingMinutes)) minutes")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.accentGreen)

                        Slider(value: $maxWalkingMinutes, in: 5...45, step: 5)
                            .tint(.accentGreen)
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(16)

                    NavigationLink {
                        PermissionsView()
                    } label: {
                        Text("Next")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.accentGreen)
                            .cornerRadius(12)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 28)
                .padding(.top, 60)
                .padding(.bottom, 34)
            }
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.labelGray)
    }

    private func preferenceButton(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(isSelected ? .white : .accentGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    isSelected
                    ? Color.accentGreen
                    : Color.cardBackground
                )
                .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.accentGreen)
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        PreferencesView()
    }
}
