import Foundation

struct UserPreference {
    
    let prefersQuietPlaces: Bool
    let prefersOutdoorPlaces: Bool
    var transportMode: TransportMode?
    var interests: Set<Interest>
    var avoidCrowdedPlaces: Bool
}

