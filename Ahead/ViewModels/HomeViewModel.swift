import Foundation
public import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var weather: WeatherInfo?
    @Published var nearbyPlaces: [Place] = []
    @Published var isLoading = false
    @Published var recommendation: Recommendation?

    private let weatherService = AppWeatherService()
    private let placesService = PlacesService()
    private let aiService = AIRecommendationService()
    private let locationService = LocationService()

    func load(
        preferences: UserPreferences,
        latitude: Double,
        longitude: Double
    ) async {

        isLoading = true

        do {

            weather = try await weatherService.getWeather()

            nearbyPlaces = try await placesService.getNearbyPlaces(
                latitude: latitude,
                longitude: longitude
            )

            recommendation = try await aiService.generateRecommendation(
                preferences: preferences,
                weather: weather!,
                places: nearbyPlaces
            )

        } catch {
            print(error)
        }

        isLoading = false
    }
}
