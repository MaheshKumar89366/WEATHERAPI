//
//  Weather.swift
//  WEATHERAPISAMPLE
//
//  Created by Mahesh Kumar Narre on 26/07/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
    }
}
