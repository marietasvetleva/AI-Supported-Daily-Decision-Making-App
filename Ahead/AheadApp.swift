import SwiftUI

@main
struct AheadApp: App {

    @StateObject private var preferencesVM = UserPreferencesViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(preferencesVM)
        }
    }
}
