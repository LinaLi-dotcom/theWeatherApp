//
//  WeatherModel.swift
//  theWeatherApp
//
//  Created by Lina Li on 2020-11-16.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let latitude: Double
    let lontitude: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)

    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}

