import Foundation

struct Place: Identifiable {
    let id: UUID
    let name: String
    let category: String
    let address: String
    let rating: Double
    let isOpen: Bool
    let noiseLevel: NoiseLevel
    let crowdLevel: CrowdLevel
}
