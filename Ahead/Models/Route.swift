import Foundation

struct Route: Identifiable {
    let id: UUID
    let title: String
    let startLocation: String
    let endLocation: String
    let durationMinutes: Int
    let distanceKm: Double
    let transportType: TransportMode
}
