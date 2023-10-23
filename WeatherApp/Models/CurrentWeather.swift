//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Владимир Есаян on 23.10.2023.
//  Copyright © 2023 Ivan Akulov. All rights reserved.
//

import Foundation

// MARK: - обновление интерфейса

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    // переводим в string температуру и округляем значение
    var temperatureString: String {
        // округление 0 знаков после запятой
        return String(format: "%.0f", temperature)
    }
    
    let feelsLiketemperature: Double
    var feelsLiketemperatureString: String {
        // округление 0 знаков после запятой
        return String(format: "%.0f", feelsLiketemperature)
    }
    // id для обновления интефейса
    let conditionCode: Int
    // обновление картинок в зависимости от погоды
    var systemIconNameString: String {
        switch conditionCode {
            // если гроза
        case 200...232: return "cloud.bolt.rain.fill"
            // если мелкий дождь
        case 300...321: return "cloud.drizzle.fill"
            // если дождь
        case 500...531: return "cloud.rain.fill"
            // если снег
        case 600...622: return "cloud.snow.fill"
            // если туман
        case 700...781: return "smoke.fill"
            // если солнечно
        case 800: return "sun.min.fill"
            // если облачно
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    // инициализатор, который может вернуть nill
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLiketemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
