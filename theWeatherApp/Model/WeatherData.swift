//
//  WeatherData.swift
//  theWeatherApp
//
//  Created by Lina Li on 2020-11-16.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
    let coord: Coord
    
    
}

struct Main: Codable {
    let temp : Double
}

struct Weather: Codable {
    let description : String
    let id : Int
}

struct Coord: Codable {
    let lat : Double
    let lon : Double
}
