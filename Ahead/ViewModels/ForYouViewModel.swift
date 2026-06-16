import Foundation
import Combine

@MainActor
final class ForYouViewModel: ObservableObject {

    @Published var recommendation: Recommendation?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let aiService = AIRecommendationService()
    private let weatherService = AppWeatherService()
    private let placesService = PlacesService()

    func load(preferences: UserPreferences) async {
        isLoading = true
        errorMessage = nil

        do {
            let weather = try await weatherService.getWeather()

            let places: [Place]

            do {
                places = try await placesService.getNearbyPlaces(
                    latitude: 51.4416,
                    longitude: 5.4697
                )
            } catch {
                print("MapKit failed, using fallback places:", error)

                places = [
                    Place(
                        id: UUID(),
                        name: "Doppio Espresso",
                        category: "Cafe",
                        address: "Eindhoven Center",
                        rating: 4.5,
                        isOpen: true,
                        noiseLevel: .quiet,
                        crowdLevel: .low
                    )
                ]
            }

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
