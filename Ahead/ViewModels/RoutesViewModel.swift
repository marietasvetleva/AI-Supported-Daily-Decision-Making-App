import Foundation
public import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [RouteOption] = []

    private let routeService = RouteService()

    func load() async {
        routes = routeService.getRoutes()
    }
}
