import Foundation
import Combine

@MainActor
final class PlacesViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var isLoading = false

    private let placesService = PlacesService()

    func load() async {
        isLoading = true

        do {
            places = try await placesService.getNearbyPlaces(
                latitude: 51.4416,
                longitude: 5.4697
            )
        } catch {
            print("Places loading error:", error)
        }

        isLoading = false
    }
}
