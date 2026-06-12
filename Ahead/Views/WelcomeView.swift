import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.95, blue: 0.92)
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 210)

                    Text("🗺️")
                        .font(.system(size: 42))

                    Text("Welcome to Ahead")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(Color(red: 0.0, green: 0.36, blue: 0.30))
                        .padding(.top, 22)

                    Text("Your personal context-aware daily\nguide. Let's set you up in 2\nminutes.")
                        .font(.system(size: 18, design: .monospaced))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                        .padding(.top, 18)

                    Spacer()

                    NavigationLink {
                        PreferencesView()
                    } label: {
                        Text("→  Get Started")
                            .font(.system(size: 17, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(width: 280, height: 58)
                            .background(Color(red: 0.10, green: 0.65, blue: 0.50))
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 130)
                }
                .padding(.horizontal, 34)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
