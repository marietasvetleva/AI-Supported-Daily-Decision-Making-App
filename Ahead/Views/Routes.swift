import SwiftUI

struct RoutesView: View {

    @StateObject private var viewModel = RoutesViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("SMART ROUTES")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.accentGreen)

                    Text("Routes")
                        .font(.system(size: 34, weight: .bold))

                    Text("Choose the best way to get there right now.")
                        .font(.system(size: 18))
                        .foregroundColor(.labelGray)
                }
                .padding(.top, 24)

                ForEach(viewModel.routes) { route in
                    routeCard(route)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .background(Color.appBackground)
        .task {
            await viewModel.load()
        }
    }

    private func routeCard(_ route: RouteOption) -> some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text(route.tag.rawValue.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.accentGreen)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.tagGreen)
                    .clipShape(Capsule())

                Spacer()

                Text(route.transportType.rawValue)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.labelGray)
            }

            Text(route.title)
                .font(.system(size: 22, weight: .bold))

            Text(route.reason)
                .font(.system(size: 16))
                .foregroundColor(.labelGray)

            HStack(spacing: 12) {
                routeInfo("\(route.durationMinutes) min")
                routeInfo(String(format: "%.1f km", route.distanceKm))
                routeInfo("Crowd: \(route.crowdLevel.rawValue)")
                routeInfo("Traffic: \(route.trafficLevel.rawValue)")
            }
        }
        .padding(20)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.divider, lineWidth: 1)
        )
    }

    private func routeInfo(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.accentOrangeSoft)
            .clipShape(Capsule())
    }
}

#Preview {
    RoutesView()
}
