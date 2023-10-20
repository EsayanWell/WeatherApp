//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Владимир Есаян on 20.10.2023.
//  Copyright © 2023 Ivan Akulov. All rights reserved.
//

import Foundation
// MARK: - NetworkWeatherManager
struct NetworkWeatherManager {
    // city вместо London, чтобы можно было вбивать свой город
    func fetchCurrentWeather(forCity city :String) {
        // создаем константу для адрес
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        // создаем URL (если неправильная строка, URL не будет создан)
        // безопасное извлечение url
        guard let url = URL(string: urlString) else {return}
        // создаем сессию
        let session = URLSession(configuration: .default)
        // создаем запрос
        let task = session.dataTask(with: url) { data, response, error in
            // проверяем наличие данных
            if let data = data {
                // если данные есть то
                let dataString = String(data: data, encoding: .utf8)
                // распечатываем то, что хранится в строке
                print(dataString!)
            }
        }
        // для того, чтобы запрос произошел
        task.resume()
    }
}
