//
//  AddLocationViewModelTest.swift
//  CloudyTests
//
//  Created by Jair Pinedo on 9/25/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import Cloudy

class AddLocationViewModelTest: XCTestCase {
    
    private class MockLocationService: LocationService {
        func geocode(addressString: String?, completionHandler: @escaping LocationService.LocationServiceCompletionHandler) {
            if let addressString = addressString, !addressString.isEmpty {
                // Create location
                let location = Location(name: "Brussels", latitude: 50.8503, longitude: 4.3517)
                
                // Invoke completion handler
                completionHandler([location], nil)
            } else {
                // Invoke completion handler
                completionHandler([], nil)
            }
        }
    }
    
    var viewModel: AddLocationViewViewModel!
    
    var scheduler: SchedulerType!
    
    var query:BehaviorRelay<String>!
    
    override func setUp() {
        
        query = BehaviorRelay<String>(value: "")
        
        let locationService = MockLocationService()
        
        viewModel = AddLocationViewViewModel(query: query.asDriver(), locationService: locationService)
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLocations_HasLocations() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        query.accept("Bruss")
        
        // toBlocking in order to make synchronous
        let result = try! observable.skip(1).toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count,1)
        
        let location = result.first!
        
        XCTAssertEqual(location.name, "Brussels")
    }
    
    func testLocations_NoLocations() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        let result: [Location] = try! observable.toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 0)
    }
    
    func testLocationAtIndex_NonNil() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set query
        query.accept("Brus")
        
        // Fetch result
        let _ = try! observable.skip(1).toBlocking().first()!
        
        // Fetch location
        let result = viewModel.location(at: 0)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "Brussels")
        
    }
}
