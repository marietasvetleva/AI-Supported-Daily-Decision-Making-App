import Foundation
public import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var weather: WeatherInfo?
    @Published var nearbyPlaces: [Place] = []
    @Published var isLoading = false

    private let weatherService = WeatherService()
    private let placesService = PlacesService()

    func load() async {
        isLoading = true

        do {
            weather = try await weatherService.getWeather()
            nearbyPlaces = try await placesService.getNearbyPlaces()
        } catch {
            print("Home loading error:", error)
        }

        isLoading = false
    }
}
