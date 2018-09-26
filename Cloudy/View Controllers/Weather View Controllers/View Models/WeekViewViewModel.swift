//
//  WeekViewViewModel.swift
//  Cloudy
//
//  Created by Jair Pinedo on 15/02/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

struct WeekViewViewModel {
    
    // MARK: - Properties
    
    let weatherData: [WeatherDayData]
    
  
    var numberOfSections : Int {
        return 1
    }
    
    var numberOfDays : Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeatherDayViewViewModel {
        return WeatherDayViewViewModel(weatherDayData: weatherData[index])
    }
    
    
}
