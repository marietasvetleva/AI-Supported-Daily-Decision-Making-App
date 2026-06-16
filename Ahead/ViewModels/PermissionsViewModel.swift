import Foundation
public import Combine

@MainActor
final class PermissionsViewModel: ObservableObject {

    private let locationService = LocationService()

    func requestLocation() {
        locationService.requestLocation()
    }
}
