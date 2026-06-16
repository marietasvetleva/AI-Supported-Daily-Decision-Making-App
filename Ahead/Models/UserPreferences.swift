import Foundation

struct UserPreferences {
    var transport: String?
    var decisionStyle: String?
    var favoritePlaces: [String]
    var avoidCrowds: Bool
    var preferQuiet: Bool
    var maxWalkingMinutes: Int
}
