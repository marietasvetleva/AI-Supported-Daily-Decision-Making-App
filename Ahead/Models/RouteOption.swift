import Foundation

struct RouteOption: Identifiable {
    let id = UUID()
    let title: String
    let durationMinutes: Int
    let distanceKm: Double
    let transportType: TransportMode
    let crowdLevel: CrowdLevel
    let trafficLevel: TrafficLevel
    let tag: RouteTag
    let reason: String
}
