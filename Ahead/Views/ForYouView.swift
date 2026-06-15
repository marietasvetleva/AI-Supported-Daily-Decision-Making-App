import SwiftUI

struct ForYouView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("AI · PERSONALISED")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.accentGreen)

                    Text("For You")
                        .font(.system(size: 34, weight: .bold))

                    Text("Thu 28 May · Veenendaal")
                        .font(.system(size: 18))
                        .foregroundColor(.labelGray)
                }
                .padding(.top, 24)

                sectionTitle("URGENT")

                urgentCard

                sectionTitle("SMART INSIGHTS")

                insightCard(
                    iconColor: .accentOrangeSoft,
                    title: "Traffic heavier than usual",
                    text: "Your usual route via A12 is 14 min slower. Via Rondweg is faster today.",
                    tag: "+14 min delay",
                    time: "Now"
                )

                insightCard(
                    iconColor: .accentGreenSoft,
                    title: "Stadswandelpark is quiet now",
                    text: "Only 4 people checked in. Perfect for a lunch walk.",
                    tag: "Low crowd",
                    time: "12:00–13:00"
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .background(Color.appBackground)
    }

    func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.labelGray)
            .tracking(1)
    }

    var urgentCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("⏰ TIME-SENSITIVE")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#9B5B00"))

            Text("Leave for work in 18 min")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#3A2500"))

            Text("Rain starts at 9:30 · Bus 401 departs 8:54 · 22 min ride")
                .font(.system(size: 17))
                .foregroundColor(Color(hex: "#7A4A00"))

            HStack {
                pill("Bus 401")
                pill("8:58 arrival")

                Spacer()

                Text("Navigate")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#7A4A00"))
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

    func pill(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 15, weight: .semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.35))
            .clipShape(Capsule())
    }

    func insightCard(
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
