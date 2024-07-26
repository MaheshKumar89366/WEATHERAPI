//
//  WeatherViewModel.swift
//  WEATHERAPISAMPLE
//
//  Created by Mahesh Kumar Narre on 26/07/24.
//

import Foundation

class WeatherViewModel {
    private let apiKey = "46cf593ba6e98547bc569c0f3fd3ec66"
    
    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        guard !city.isEmpty else {
            completion(nil)
            return
        }
        
        let cityEscaped = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(String(describing: error))")
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                completion(weatherResponse)
            }
        }.resume()
    }
}
