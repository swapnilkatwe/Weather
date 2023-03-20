//
//  KeychainManager.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 20/03/23.
//

import Foundation
import SwiftKeychainWrapper
import CoreLocation

struct KeychainManager {
    
    func saveDouble(_ value: Double, forKey key: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }

    func doubleForKey(_ key: String) -> Double? {
        return KeychainWrapper.standard.double(forKey: key)
    }

    func removeValueForKey(_ key: String) {
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: key))
    }
}
