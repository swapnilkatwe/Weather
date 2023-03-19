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
    private var coordidate: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 40.7128, longitude: 74.0060) // Defaulkt New york
    init() { }
    
    var currentCoordinate: CLLocationCoordinate2D? {
        get {
            return coordidate
        }
        set {
            coordidate = newValue
        }
    }
}
