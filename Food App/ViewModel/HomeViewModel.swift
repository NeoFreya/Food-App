//
//  HomeViewModel.swift
//  Food App
//
//  Created by Abdul Halim on 01/03/21.
//  Copyright © 2021 NEONFACT. All rights reserved.
//

import SwiftUI
import CoreLocation

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManagaer = CLLocationManager()
    @Published var seacrh = ""
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            locationManagaer.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
        
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            guard let safeData = res else {return}
            
            var addres = ""
            
            addres += safeData.first?.name ?? ""
            addres += ", "
            addres += safeData.first?.locality ?? ""
            
            self.userAddress = addres
        }
    }
}
