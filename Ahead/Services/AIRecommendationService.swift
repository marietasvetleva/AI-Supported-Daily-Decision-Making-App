import Foundation

final class AIRecommendationService {

    func generateRecommendation(
        preferences: UserPreferences,
        weather: WeatherInfo,
        places: [Place]
    ) async throws -> Recommendation {

        let quietPlaces = places.filter {
            preferences.preferQuiet ? $0.noiseLevel == .quiet : true
        }

        let uncrowdedPlaces = quietPlaces.filter {
            preferences.avoidCrowds ? $0.crowdLevel != .high : true
        }

        let bestPlace = uncrowdedPlaces.first ?? places.first

        return Recommendation(
            id: UUID(),
            title: "Best choice right now",
            reason: "Based on your preferences, weather, crowd level, and nearby places.",
            place: bestPlace,
            route: nil
        )
    }
}
