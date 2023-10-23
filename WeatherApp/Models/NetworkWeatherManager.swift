//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Владимир Есаян on 20.10.2023.
//  Copyright © 2023 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - NetworkWeatherManager
class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city): urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        // создаем URL (если неправильная строка, URL не будет создан)
        // безопасное извлечение url
        guard let url = URL(string: urlString) else {return}
        // создаем сессию
        let session = URLSession(configuration: .default)
        // создаем запрос
        let task = session.dataTask(with: url) { data, response, error in
            // проверяем наличие данных
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        // для того, чтобы запрос произошел
        task.resume()
    }
    
    // функция для распарсивания (декодирования)
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData =  try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
