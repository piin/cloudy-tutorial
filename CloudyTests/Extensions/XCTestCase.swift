//
//  XCTestCase.swift
//  CloudyTests
//
//  Created by Jair Pinedo on 20/02/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStubFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
}

