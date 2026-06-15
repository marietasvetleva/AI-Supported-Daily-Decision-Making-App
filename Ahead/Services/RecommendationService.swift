import Foundation

final class RecommendationService {
    
    func getRecommendation(
        weather: WeatherInfo,
        places: [Place],
        routes: [Route]
    ) -> Recommendation {
        
        Recommendation(
            id: UUID(),
            title: "Leave before the rain starts",
            reason: "Rain is expected soon, so it is better to leave earlier.",
            place: places.first,
            route: routes.first
        )
    }
}
