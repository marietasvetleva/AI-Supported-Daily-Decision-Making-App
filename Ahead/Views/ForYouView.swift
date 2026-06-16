import SwiftUI

struct ForYouView: View {

    @EnvironmentObject var preferencesVM: UserPreferencesViewModel
    @StateObject private var viewModel = ForYouViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {

                header

                if viewModel.isLoading {
                    ProgressView("Creating your AI recommendation...")
                        .padding(.top, 30)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else if let recommendation = viewModel.recommendation {
                    sectionTitle("AI RECOMMENDATION")
                    aiRecommendationCard(recommendation)
                }

                sectionTitle("SMART INSIGHTS")

                insightCard(
                    iconColor: .accentOrangeSoft,
                    title: "Weather-aware suggestion",
                    text: "Ahead checks your weather, preferences, nearby places, and crowd levels before suggesting what to do.",
                    tag: "AI based",
                    time: "Now"
                )

                insightCard(
                    iconColor: .accentGreenSoft,
                    title: "Personalised for you",
                    text: "Your preferences help Ahead avoid crowded or noisy places when making suggestions.",
                    tag: "Personalised",
                    time: "Today"
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .background(Color.appBackground)
        .task {
            await viewModel.load(preferences: preferencesVM.preferences)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("AI · PERSONALISED")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.accentGreen)

            Text("For You")
                .font(.system(size: 34, weight: .bold))

            Text("Smart suggestions based on your day")
                .font(.system(size: 18))
                .foregroundColor(.labelGray)
        }
        .padding(.top, 24)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.labelGray)
            .tracking(1)
    }

    private func aiRecommendationCard(_ recommendation: Recommendation) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("✨ BEST CHOICE NOW")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#9B5B00"))

            Text(recommendation.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#3A2500"))

            Text(recommendation.reason)
                .font(.system(size: 17))
                .foregroundColor(Color(hex: "#7A4A00"))

            if let place = recommendation.place {
                HStack {
                    pill(place.name)
                    pill(place.category)

                    Spacer()

                    Text("Open")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "#7A4A00"))
                }
            }
        }
        .padding(22)
        .background(Color(hex: "#F6A21A"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(hex: "#C77A00"), lineWidth: 2)
        )
    }

    private func pill(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 15, weight: .semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.35))
            .clipShape(Capsule())
    }

    private func insightCard(
        iconColor: Color,
        title: String,
        text: String,
        tag: String,
        time: String
    ) -> some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedRectangle(cornerRadius: 14)
                .fill(iconColor)
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 21, weight: .bold))

                Text(text)
                    .font(.system(size: 17))
                    .foregroundColor(.labelGray)
                    .lineSpacing(3)

                HStack {
                    Text(tag)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.accentOrangeSoft)
                        .clipShape(Capsule())

                    Spacer()

                    Text(time)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.labelGray)
                }
            }
        }
        .padding(20)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.divider, lineWidth: 1)
        )
    }
}

#Preview {
    ForYouView()
        .environmentObject(UserPreferencesViewModel())
}
