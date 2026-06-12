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
            (a, r, g, b) = (1, 1, 1, 0)
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


struct NearbyPlace: Identifiable {
    let id = UUID()
    let name: String
    let walkTime: String
    let crowdLabel: String
    let crowdColor: Color
    let crowdTextColor: Color
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
                .foregroundColor(.primary)
            Text(label)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.labelGray)
                .tracking(0.4)
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
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(hex: "#B85C10").opacity(0.85))
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.accentOrangeSoft)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.accentOrange.opacity(0.5), lineWidth: 1)
        )
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

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.labelGray)
                }
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
    let place: NearbyPlace

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "#EDE9E2"))
                .frame(height: 90)
                .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(place.walkTime)
                    .font(.system(size: 13))
                    .foregroundColor(.labelGray)

                Text(place.crowdLabel)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(place.crowdTextColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(place.crowdColor)
                    .clipShape(Capsule())
            }
        }
        .padding(12)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 160)
    }
}

enum Tab: String, CaseIterable {
    case home = "Home"
    case routes = "Routes"
    case places = "Places"
    case forYou = "For you"
    case settings = "Settings"

    var icon: String {
        switch self {
        case .home: return "house"
        case .routes: return "arrow.triangle.swap"
        case .places: return "mappin.circle"
        case .forYou: return "sparkles"
        case .settings: return "gearshape"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: { selectedTab = tab }) {
                    VStack(spacing: 5) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == tab ? .accentGreen : .labelGray)

                        Text(tab.rawValue)
                            .font(.system(size: 10))
                            .foregroundColor(selectedTab == tab ? .accentGreen : .labelGray)

                        if selectedTab == tab {
                            Circle()
                                .fill(Color.accentGreen)
                                .frame(width: 4, height: 4)
                        } else {
                            Spacer().frame(height: 4)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color.cardBackground)
        .overlay(Divider(), alignment: .top)
    }
}

struct HomeView: View {
    @State private var selectedTab: Tab = .routes

    let nearbyPlaces: [NearbyPlace] = [
        NearbyPlace(name: "Doppio Espresso", walkTime: "3 min walk",
                    crowdLabel: "Quiet now", crowdColor: .tagGreen, crowdTextColor: .tagGreenText),
        NearbyPlace(name: "Albert Heijn", walkTime: "6 min walk",
                    crowdLabel: "Moderate", crowdColor: .tagOrange, crowdTextColor: .tagOrangeText),
        NearbyPlace(name: "Starbucks", walkTime: "9 min walk",
                    crowdLabel: "Empty", crowdColor: .tagRed, crowdTextColor: .tagRedText),
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: Greeting
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Good morning")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.labelGray)
                        Text("Hi, Marieta")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                    }

                
                    WeatherStatsCard()

                    DepartureAlertCard()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("WHAT DO YOU NEED?")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.labelGray)
                            .tracking(0.8)

                        PlanRouteButton()

                        HStack(spacing: 12) {
                            ActionCard(
                                icon: "mappin",
                                iconColor: Color.accentGreenSoft,
                                title: "Find a place",
                                subtitle: "Nearby  crowd levels"
                            )
                            ActionCard(
                                icon: "star",
                                iconColor: Color.accentPeach,
                                title: "Suggest activity",
                                subtitle: "Based on your day"
                            )
                        }
                    }

                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("NEARBY NOW")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.labelGray)
                            .tracking(0.8)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(nearbyPlaces) { place in
                                    NearbyPlaceCard(place: place)
                                }
                            }
                            .padding(.trailing, 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
            .background(Color.appBackground)

            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    HomeView()
}
