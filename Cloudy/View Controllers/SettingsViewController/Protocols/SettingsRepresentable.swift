//
//  SettingsRepresentable.swift
//  Cloudy
//
//  Created by Jair Pinedo on 16/02/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var text: String { get }
    var accessoryType: UITableViewCellAccessoryType { get }
    
}
