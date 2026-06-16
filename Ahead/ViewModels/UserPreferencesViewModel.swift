import Foundation
public import Combine

@MainActor
final class UserPreferencesViewModel: ObservableObject {

    @Published var preferences = UserPreferences(
        transport: nil,
        decisionStyle: nil,
        favoritePlaces: [],
        avoidCrowds: true,
        preferQuiet: true,
        maxWalkingMinutes: 15
    )

    func setTransport(_ transport: String) {
        preferences.transport = transport
    }

    func setDecisionStyle(_ style: String) {
        preferences.decisionStyle = style
    }

    func toggleFavoritePlace(_ place: String) {
        if preferences.favoritePlaces.contains(place) {
            preferences.favoritePlaces.removeAll { $0 == place }
        } else {
            preferences.favoritePlaces.append(place)
        }
    }

    func setAvoidCrowds(_ value: Bool) {
        preferences.avoidCrowds = value
    }

    func setPreferQuiet(_ value: Bool) {
        preferences.preferQuiet = value
    }

    func setMaxWalkingMinutes(_ value: Int) {
        preferences.maxWalkingMinutes = value
    }
}
