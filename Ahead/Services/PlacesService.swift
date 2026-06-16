import Foundation
import MapKit

final class PlacesService {

    func getNearbyPlaces(
        latitude: Double,
        longitude: Double
    ) async throws -> [Place] {

        let request = MKLocalSearch.Request()

        request.naturalLanguageQuery = "cafe OR park OR library OR restaurant"

        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            latitudinalMeters: 3000,
            longitudinalMeters: 3000
        )

        let response = try await MKLocalSearch(
            request: request
        ).start()

        return response.mapItems.map { item in

            Place(
                id: UUID(),
                name: item.name ?? "Unknown",
                category: item.pointOfInterestCategory?.rawValue ?? "Place",
                address: item.placemark.title ?? "",
                rating: 4.0,
                isOpen: true,
                noiseLevel: .moderate,
                crowdLevel: .medium
            )
        }
    }
}
