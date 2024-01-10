//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Владимир Есаян on 20.10.2023.

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
