import SwiftUI

extension Color {
    static let appBackground = Color(hex: "#F2EFE9")
    static let cardBackground = Color.white
    static let accentOrange = Color(hex: "#E8873A")
    static let accentOrangeSoft = Color(hex: "#FDF3E7")
    static let accentGreen = Color(hex: "#2D7A5F")
    static let accentGreenSoft = Color(hex: "#D6EDE5")
    static let accentPeach = Color(hex: "#F5DDD0")
    static let labelGray = Color(hex: "#9A9A9A")
    static let tagGreen = Color(hex: "#E3F3ED")
    static let tagGreenText = Color(hex: "#2D7A5F")
    static let tagOrange = Color(hex: "#FDE8CD")
    static let tagOrangeText = Color(hex: "#C97220")
    static let tagRed = Color(hex: "#FFE5E5")
    static let tagRedText = Color(hex: "#C0392B")
    static let divider = Color(hex: "#E8E4DD")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64

        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 255, 255, 255)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct WeatherStatsCard: View {
    var body: some View {
        HStack(spacing: 0) {
            statItem(value: "14°", label: "RAIN 9:30")
            dividerLine
            statItem(value: "Mod.", label: "TRAFFIC")
            dividerLine
            statItem(value: "Low", label: "CROWDS")
            dividerLine
            statItem(value: "22m", label: "TO WORK")
        }
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .semibold))

            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.labelGray)
        }
        .frame(maxWidth: .infinity)
    }

    private var dividerLine: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(width: 1, height: 36)
    }
}

struct DepartureAlertCard: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.accentOrange)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text("Leave by 8:45 am")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "#B85C10"))

                Text("Rain starts at 9:30  · 22 min commute via\nBus 401 right now")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#B85C10").opacity(0.85))
            }

            Spacer()
        }
        .padding(16)
        .background(Color.accentOrangeSoft)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct PlanRouteButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentGreenSoft.opacity(0.4))
                    .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Plan a route")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)

                    Text("Live traffic · ETA")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                }

                Spacer()
            }
            .padding(16)
            .background(Color.accentGreen)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

struct ActionCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String

    var body: some View {
        Button(action: {}) {
            VStack(alignment: .leading, spacing: 12) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconColor)
                    .frame(width: 44, height: 44)

                Text(title)
                    .font(.system(size: 16, weight: .semibold))

                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.labelGray)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

struct NearbyPlaceCard: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "#EDE9E2"))
                .frame(height: 90)

            Text(place.name)
                .font(.system(size: 15, weight: .semibold))

            Text(place.address)
                .font(.system(size: 13))
                .foregroundColor(.labelGray)

            Text(place.crowdLevel.rawValue)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.tagGreenText)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.tagGreen)
                .clipShape(Capsule())
        }
        .padding(12)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 160)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            tabButton(0, "house", "Home")
            tabButton(1, "arrow.triangle.swap", "Routes")
            tabButton(3, "sparkles", "For you")
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color.cardBackground)
        .overlay(Divider(), alignment: .top)
    }

    func tabButton(_ index: Int, _ icon: String, _ title: String) -> some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 22))

                Text(title)
                    .font(.system(size: 10))

                if selectedTab == index {
                    Circle()
                        .fill(Color.accentGreen)
                        .frame(width: 4, height: 4)
                } else {
                    Spacer().frame(height: 4)
                }
            }
            .foregroundColor(selectedTab == index ? .accentGreen : .labelGray)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

struct HomeView: View {
    @State private var selectedTab = 0
    @StateObject private var viewModel = HomeViewModel()
    

    var body: some View {
        VStack(spacing: 0) {
            pageContent

            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }

    @ViewBuilder
    private var pageContent: some View {
        if selectedTab == 0 {
            homeContent
        } else if selectedTab == 1 {
            PlanningView()
        } else if selectedTab == 3 {
            ForYouView()
        }
    }

    private var homeContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Good morning")
                        .font(.system(size: 16))
                        .foregroundColor(.labelGray)

                    Text("Hi, Marieta")
                        .font(.system(size: 32, weight: .bold))
                }

                WeatherStatsCard()
                DepartureAlertCard()

                VStack(alignment: .leading, spacing: 12) {
                    Text("WHAT DO YOU NEED?")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.labelGray)

                    PlanRouteButton()

                    HStack(spacing: 12) {
                        ActionCard(
                            icon: "mappin",
                            iconColor: .accentGreenSoft,
                            title: "Find a place",
                            subtitle: "Nearby crowd levels"
                        )

                        ActionCard(
                            icon: "star",
                            iconColor: .accentPeach,
                            title: "Suggest activity",
                            subtitle: "Based on your day"
                        )
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("NEARBY NOW")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.labelGray)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.nearbyPlaces) { place in
                                NearbyPlaceCard(place: place)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground)
    }
}

struct PlaceholderPage: View {
    let title: String

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            Text(title)
                .font(.system(size: 28, weight: .bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}
