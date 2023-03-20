//
//  SessionManager.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 19/03/23.
//

import Foundation
import CoreLocation

class SessionManager {
    static let shared = SessionManager()
    init() { }
    
    var currentCoordinate: CLLocationCoordinate2D? {
        get {
            return getLocation
        }
        set {
            saveLocattion(newValue)
        }
    }

    // Saving location in keychain to retrive again
    private func saveLocattion(_ coordinate: CLLocationCoordinate2D?) {
        KeychainManager().saveDouble(coordinate?.latitude ?? 0.0, forKey: Constants().coordinateLatitude)
        KeychainManager().saveDouble(coordinate?.longitude ?? 0.0, forKey: Constants().coordinateLongitude)
    }
    
    private var getLocation: CLLocationCoordinate2D? {
        let lat = KeychainManager().doubleForKey(Constants().coordinateLatitude) ?? 0.0
        let long = KeychainManager().doubleForKey(Constants().coordinateLongitude) ?? 0.0
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
