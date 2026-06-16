import Foundation

final class AIRecommendationService {

    func generateRecommendation(
        preferences: UserPreferences,
        weather: WeatherInfo,
        places: [Place]
    ) async throws -> Recommendation {

        let filteredPlaces = places.filter { place in
            if preferences.preferQuiet && place.noiseLevel != .quiet {
                return false
            }

            if preferences.avoidCrowds && place.crowdLevel == .high {
                return false
            }

            if !preferences.favoritePlaces.isEmpty {
                return preferences.favoritePlaces.contains { favorite in
                    place.category.lowercased().contains(favorite.lowercased())
                    || place.name.lowercased().contains(favorite.lowercased())
                }
            }

            return true
        }

        let bestPlace = filteredPlaces.first ?? places.first

        let title = makeTitle(
            weather: weather,
            place: bestPlace,
            preferences: preferences
        )

        let reason = makeReason(
            weather: weather,
            place: bestPlace,
            preferences: preferences
        )

        return Recommendation(
            id: UUID(),
            title: title,
            reason: reason,
            place: bestPlace,
            route: nil
        )
    }

    private func makeTitle(
        weather: WeatherInfo,
        place: Place?,
        preferences: UserPreferences
    ) -> String {
        guard let place else {
            return "No strong recommendation yet"
        }

        if weather.isRaining {
            return "Go somewhere indoors"
        }

        if preferences.preferQuiet {
            return "\(place.name) looks calm now"
        }

        return "\(place.name) is a good choice"
    }

    private func makeReason(
        weather: WeatherInfo,
        place: Place?,
        preferences: UserPreferences
    ) -> String {
        guard let place else {
            return "Ahead needs more nearby place data before it can recommend something."
        }

        var reasons: [String] = []

        reasons.append("It matches your current preferences.")

        if weather.isRaining {
            reasons.append("It is better to choose an indoor option because it is raining.")
        }

        if preferences.avoidCrowds {
            reasons.append("Crowded places are avoided.")
        }

        if preferences.preferQuiet {
            reasons.append("Quiet places are prioritised.")
        }

        reasons.append("\(place.name) has a \(place.crowdLevel.rawValue.lowercased()) crowd level.")

        return reasons.joined(separator: " ")
    }
}
