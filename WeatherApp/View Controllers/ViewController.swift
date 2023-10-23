
//  Created by Esayan Well


import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Variables and constants
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    // экземпляр networkManager
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        // точность координаты
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        // доступ к геопозиции
        lm.requestWhenInUseAuthorization()
        return lm
    } ()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {
            [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // нет цикла сильных ссылок
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            // чтобы извлечь self
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        // если настройка геопозиции открыта
        guard CLLocationManager.locationServicesEnabled() else {
            // Обработка случая, когда службы геолокации выключены
            return
        }

        locationManager.requestLocation()

    }
    
    // MARK: - Update interface method
    func updateInterfaceWith(weather: CurrentWeather) {
        // помещаем метод в главную очередь (многопоточность)
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLiketemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    // массив геопозиций
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // получение широты и долготы
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
