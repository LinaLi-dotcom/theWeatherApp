//
//  WeatherManager.swift
//  theWeatherApp
//
//  Created by Lina Li on 2020-11-16.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=529bad52d5b848bb3896c318cab01e90&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        
        let urlString =  "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //     1. Create a URL
        if let url = URL(string: urlString) {
            //     2. Create a URLSession
            let session = URLSession(configuration: .default)
            //     3. Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                        
                    }
                }
            }
            //     4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) ->WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, latitude: lat, lontitude: lon)
            return weather
            
    
        } catch {
            print(error)
            return nil
        }
    }
    
}


