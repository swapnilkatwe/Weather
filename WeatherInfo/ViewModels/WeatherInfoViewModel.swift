//
//  WeatherInfoViewModel.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 17/03/23.
//

import Foundation
import Alamofire

class WeatherInfoViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private var currentWeather: CurrentWeather? {
        didSet {
            bind?(currentWeather)
        }
    }
    
    var bind: ((CurrentWeather?) -> Void)?
    
    var currentDate: String {
        dateFormater(date: currentWeather?.dt, dateFormat: "HH:mm, dd MMMM yy")
    }

    var currentTemperature: String {
        guard let temperature = currentWeather?.main?.temp else { return "-°" }
        return "\((temperature - 273.15).doubleToString())°"
    }
    
    var weatherDescription: String {
        guard let description = currentWeather?.weather?.first?.description else { return "NA" }
        return description
    }

    var cityName: String {
        guard let city = currentWeather?.name else { return "-" }
        return city
    }

    var weatherImageUrl: String {
        return Constants().imageBaseUrl + (currentWeather?.weather?.first?.icon ?? "") + "@2x.png"
    }
    
    //MARK: - Location
    func getCurrentLocation() {
        actualLocation()
    }

    //MARK: - Helpers
    private func dateFormater(date: TimeInterval?, dateFormat: String) -> String {
        guard let date = date else { return "-" }
        let dateText = Date(timeIntervalSince1970: date)
        let formater = DateFormatter()
        formater.timeZone = TimeZone(secondsFromGMT: currentWeather?.timezone ?? 0)
        formater.dateFormat = dateFormat
        return formater.string(from: dateText)
        
    }

    //MARK: - API calls
    func getCurrentWeather() {
        WeatherManager.shared.getCurrentWeatherDataFor(
            lat: SessionManager.shared.currentCoordinate?.latitude,
            long: SessionManager.shared.currentCoordinate?.longitude) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.currentWeather = weather
            case .failure(let error):
                print(error)
            }
        }
    }
}


import CoreLocation
extension WeatherInfoViewModel:  CLLocationManagerDelegate  {
    
    private func actualLocation() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        print("-->\(location.latitude), \(location.longitude)")

        SessionManager.shared.currentCoordinate = location
        locationManager.stopUpdatingLocation()
        getCurrentWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            debugPrint("No access")
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("Access")
        @unknown default:
            break
        }
    }
}


//MARK: - Extensions
extension WeatherInfoViewModel: SearchViewModelDelegate {
    func locationUpdated() {
        getCurrentWeather()
    }
}
