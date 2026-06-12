import Foundation

struct RouteStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let durationMinutes: Int?
    let distanceMeters: Int?
}
