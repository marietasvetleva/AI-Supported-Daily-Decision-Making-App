import Foundation

final class AppWeatherService {

    func getWeather(
        latitude: Double = 51.4416,
        longitude: Double = 5.4697
    ) async throws -> WeatherInfo {

        let urlString = """
        https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,precipitation,rain,weather_code,wind_speed_10m
        """

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let weatherData = try JSONDecoder().decode(
            OpenMeteoResponse.self,
            from: data
        )

        return WeatherInfo(
            temperature: weatherData.current.temperature_2m,
            condition: weatherCondition(
                from: weatherData.current.weather_code
            ),
            isRaining: weatherData.current.rain > 0,
            windSpeed: weatherData.current.wind_speed_10m
        )
    }

    private func weatherCondition(from code: Int) -> String {

        switch code {

        case 0:
            return "Clear"

        case 1, 2, 3:
            return "Cloudy"

        case 45, 48:
            return "Fog"

        case 51, 53, 55:
            return "Drizzle"

        case 61, 63, 65:
            return "Rain"

        case 71, 73, 75:
            return "Snow"

        case 80, 81, 82:
            return "Rain Showers"

        case 95:
            return "Thunderstorm"

        default:
            return "Unknown"
        }
    }
}

struct OpenMeteoResponse: Decodable {
    let current: OpenMeteoCurrent
}

struct OpenMeteoCurrent: Decodable {
    let temperature_2m: Double
    let precipitation: Double
    let rain: Double
    let weather_code: Int
    let wind_speed_10m: Double
}
