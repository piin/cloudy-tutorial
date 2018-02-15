//
//  DateViewViewModel.swift
//  Cloudy
//
//  Created by Jair Pinedo on 15/02/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

struct DayViewViewModel {
    
    let weatherData: WeatherData
    
    private let dateFormater = DateFormatter()
    private let timeFormater = DateFormatter()
    
    var date: String {
        dateFormater.dateFormat = "EEE, MMMM d"
        
        return dateFormater.string(from: weatherData.time)
    }
    
    var time: String {
        dateFormater.dateFormat = UserDefaults.timeNotation().timeFormat 
        
        return dateFormater.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        let temperature = weatherData.temperature
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format:"%.1f ºF", temperature)
        case .celsius:
            return String(format: "%.1f ºC", temperature.toCelcius())
        }
    }
    
    var windSpeed: String {
        let windSpeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH",windSpeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName:  weatherData.icon)
    }
    
    
    
}
