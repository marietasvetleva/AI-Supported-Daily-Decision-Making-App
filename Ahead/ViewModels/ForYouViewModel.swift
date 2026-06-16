import Foundation
public import Combine

@MainActor
final class ForYouViewModel: ObservableObject {

    @Published var recommendation: Recommendation?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let aiService = AIRecommendationService()
    private let weatherService = WeatherService()
    private let placesService = PlacesService()

    func load(preferences: UserPreferences) async {
        isLoading = true
        errorMessage = nil

        do {
            let weather = try await weatherService.getWeather()
            let places = try await placesService.getNearbyPlaces()

            recommendation = try await aiService.generateRecommendation(
                preferences: preferences,
                weather: weather,
                places: places
            )
        } catch {
            errorMessage = "Could not generate a recommendation."
            print("ForYou error:", error)
        }

        isLoading = false
    }
}
