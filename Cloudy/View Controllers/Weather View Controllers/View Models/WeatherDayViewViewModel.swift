//
//  WeatherDayViewViewModel.swift
//  Cloudy
//
//  Created by Jair Pinedo on 16/02/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

struct WeatherDayViewViewModel {
    
    let weatherDayData: WeatherDayData
    
    private let dateFormatter = DateFormatter()
    private let dayFromatter = DateFormatter()
    
    var day: String {
        
        dayFromatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    var date: String {
        
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    var temperature: String {
        
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        
        return "\(min) - \(max) "
    }
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit: return String(format: "%.0f ºF", temperature )
        case .celsius: return String(format: "%.0f ºC", temperature.toCelcius())
        }
    }
    
    var windSpeed: String {
        let windSpeed = weatherDayData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial: return String(format: "%.f MPH", windSpeed)
        case .metric: return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    var image: UIImage? {
        
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }
    
}

extension WeatherDayViewViewModel: WeatherDayRepresentable {
    
}
