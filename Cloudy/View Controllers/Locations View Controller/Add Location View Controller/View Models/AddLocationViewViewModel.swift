//
//  AddLocationViewViewModel.swift
//  Cloudy
//
//  Created by Jair Pinedo on 05/03/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//
import RxSwift
import RxCocoa
import Foundation

class AddLocationViewViewModel {
    
    var hasLocations: Bool { return numberOfLocations > 0 }
    var numberOfLocations: Int { return _locations.value.count }
    
    private let _locations = BehaviorRelay<[Location]>(value: [])
    private let _querying = BehaviorRelay<Bool>(value: false)
    
    var locations: Driver<[Location]> { return _locations.asDriver() }
    var querying: Driver<Bool> { return _querying.asDriver() }
    
    private let locationService: LocationService
    
    private let disposeBag = DisposeBag()
    
    init(query: Driver<String>, locationService: LocationService) {
        self.locationService = locationService
        query
            .throttle(0.5)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (addressString) in
                self?.geocode(addressString: addressString)
            })
            .disposed(by: disposeBag)
    }
    
    func location(at index: Int) -> Location? {
        guard index < _locations.value.count else { return nil }
        return _locations.value[index]
    }
    
    func viewModelForLocations(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else { return nil }
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
    }
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString, !addressString.isEmpty else {
            _locations.accept([])
            return
        }
        
        _querying.accept(true)
        
        locationService.geocode(addressString: addressString) { [weak self] (locations, error) in
            self?._querying.accept(false)
            self?._locations.accept(locations)
            
            if let error = error {
                print("Unable to forward geocode address \(error)")
            }
        }
    }
}






