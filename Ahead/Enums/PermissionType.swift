import Foundation

enum PermissionType: String {
    case location = "Location"
    case notifications = "Notifications"
    case calendar = "Calendar"

    var icon: String {
        switch self {
        case .location: return "location.fill"
        case .notifications: return "bell.fill"
        case .calendar: return "calendar"
        }
    }

    var subtitle: String {
        switch self {
        case .location: return "Live routes & nearby spots"
        case .notifications: return "Timely reminders"
        case .calendar: return "Smarter scheduling"
        }
    }
}
