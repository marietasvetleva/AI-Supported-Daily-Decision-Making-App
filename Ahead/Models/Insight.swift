import Foundation

struct Insight: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let type: InsightType
    let tag: String
}
