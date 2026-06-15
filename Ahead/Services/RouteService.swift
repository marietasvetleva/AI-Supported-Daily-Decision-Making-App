import Foundation

final class RouteService {
    func getRoutes() async throws -> [RouteOption] {
        return [
            RouteOption(
                title: "Via Vestdijk",
                durationMinutes: 22,
                distanceKm: 4.1,
                transportType: .transit,
                crowdLevel: .low,
                trafficLevel: .moderate,
                tag: .fastest,
                reason: "Fastest right now. Low crowds on bus 401."
            )
        ]
    }
}
