import Foundation

final class RouteService {

    func getRoutes() -> [RouteOption] {
        return [
            RouteOption(
                title: "Bike to Fontys",
                durationMinutes: 12,
                distanceKm: 3.4,
                transportType: .bike,
                crowdLevel: .low,
                trafficLevel: .low,
                tag: .fastest,
                reason: "Fastest and least crowded option right now."
            ),

            RouteOption(
                title: "Bus 401 to Eindhoven Station",
                durationMinutes: 22,
                distanceKm: 5.8,
                transportType: .transit,
                crowdLevel: .medium,
                trafficLevel: .moderate,
                tag: .calmest,
                reason: "Good option, but slightly busier than usual."
            ),

            RouteOption(
                title: "Walk to Doppio Espresso",
                durationMinutes: 6,
                distanceKm: 0.5,
                transportType: .walk,
                crowdLevel: .low,
                trafficLevel: .low,
                tag: .scenic,
                reason: "Short walk and quiet nearby place."
            )
        ]
    }
}
