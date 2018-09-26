//
//  LocationService.swift
//  Cloudy
//
//  Created by Jair Pinedo on 9/25/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

protocol LocationService {
    
    typealias LocationServiceCompletionHandler = ([Location], Error?) -> Void
    
    func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler)
}
