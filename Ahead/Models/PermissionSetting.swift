import Foundation

struct PermissionSetting: Identifiable {
    let id = UUID()
    let type: PermissionType
    var isEnabled: Bool
}
