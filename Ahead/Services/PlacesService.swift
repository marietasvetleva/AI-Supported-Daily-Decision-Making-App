import Foundation

final class PlacesService {

    func getNearbyPlaces() async throws -> [Place] {

        return [

            Place(
                id: UUID(),
                name: "Doppio Espresso",
                category: "Cafe",
                address: "Stationsplein 1",
                rating: 4.5,
                isOpen: true,
                noiseLevel: .quiet,
                crowdLevel: .low
            ),

            Place(
                id: UUID(),
                name: "Albert Heijn",
                category: "Supermarket",
                address: "Heuvel Galerie",
                rating: 4.2,
                isOpen: true,
                noiseLevel: .moderate,
                crowdLevel: .medium
            ),

            Place(
                id: UUID(),
                name: "Stadswandelpark",
                category: "Park",
                address: "Stadswandelpark Eindhoven",
                rating: 4.8,
                isOpen: true,
                noiseLevel: .quiet,
                crowdLevel: .low
            )
        ]
    }
}
