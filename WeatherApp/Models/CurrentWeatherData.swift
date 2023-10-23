//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Владимир Есаян on 23.10.2023.
//  Copyright © 2023 Ivan Akulov. All rights reserved.
//

import Foundation

// MARK: - парсим JSON
struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    // для переименования по camelCase
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
