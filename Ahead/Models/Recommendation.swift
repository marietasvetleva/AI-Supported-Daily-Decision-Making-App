import Foundation

struct Recommendation: Identifiable {
    let id: UUID
    let title: String
    let reason: String
    let place: Place?
    let route: Route?
}
