//
//  Geocoder.swift
//  Cloudy
//
//  Created by Jair Pinedo on 9/25/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import CoreLocation

class Geocoder: LocationService {

    private lazy var geocoder = CLGeocoder();
    
    func geocode(addressString: String?, completionHandler: @escaping LocationService.LocationServiceCompletionHandler) {
        guard let addressString = addressString, !addressString.isEmpty else {
            completionHandler([], nil)
            return
        }
    
        geocoder.geocodeAddressString(addressString) { (placemark, error) in
            if let error = error {
                print("Unable to Forward Geocode Address (\(error)")
            }else if let _placemark = placemark {
                let locations = _placemark.compactMap({ (placemark) -> Location? in
                    guard let name = placemark.name else { return nil}
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
                completionHandler(locations, nil)
            }
        }
    }

}
