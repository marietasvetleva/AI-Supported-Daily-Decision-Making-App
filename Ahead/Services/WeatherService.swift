import Foundation

final class WeatherService {
    func getWeather() async throws -> WeatherInfo {
        return WeatherInfo(
            temperature: 14,
            condition: "Rain",
            isRaining: true,
            windSpeed: 12
        )
    }
}
