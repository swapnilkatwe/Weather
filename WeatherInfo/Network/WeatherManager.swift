//
//  WeatherManager.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 18/03/23.
//

import Foundation

class WeatherManager {

    static let shared = WeatherManager()

    func getCurrentWeatherDataFor(lat: Double?, long: Double?, completion: @escaping (Result<CurrentWeather>) -> Void) {
        
        guard let latitude = lat, let longitude = long else {
            let error = NSError(domain: "", code: 902, userInfo: [NSLocalizedDescriptionKey: "Coordinates are not valid" as Any])
            completion(.failure(error))
            return
        }
        let stringUrl = Constants().baseUrl + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants().apiKey)"
        guard let url = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        AlamofireManager.executeRequest(url) { result in
            switch result {
            case .success(let json):
                do {
                    let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: json)
                    completion(.success(currentWeather))
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func searchResults(searchText: String, completion: @escaping (Result<CityList>) -> Void) {
        if searchText.count > 2 {
            let stringUrl = Constants().geoCodeUrl + "direct?q=\(searchText)&limit=5&appid=\(Constants().apiKey)"
            guard let url = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

            AlamofireManager.executeRequest(url, method: .get) { result in
                switch result {
                case .success(let json):
                    do {
                        let cityList = try JSONDecoder().decode(CityList.self, from: json)
                        completion(.success(cityList))
                    } catch let error {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
