//
//  SuiviUtilisateurViewModel.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 06/06/2022.
//

import SwiftUI
import MapKit

class SuiviUtilisateurViewModel:NSObject, CLLocationManagerDelegate, ObservableObject {
    var manager:CLLocationManager = CLLocationManager()
    @Published var coordoneGeo:MKCoordinateRegion
    @Published var suivreUtilisateur:Bool = true
    var majPosition:CLLocation?
    
    var span:MKCoordinateSpan
    
    init( _ localisation: CLLocation ) {
        span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        coordoneGeo = MKCoordinateRegion(center: localisation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        super.init()
        manager.delegate = self
        demarrer()
    }
    
    //demarrer la localisation
    func demarrer() {
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    // autorisation  position
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case.authorizedAlways: print("authorizedAlways")
        case.authorizedWhenInUse: print("authorizedWhenInUse")
        case.denied: print("denied")
        case.notDetermined: print("notDetermined")
        case.restricted: print("restricted")
        @unknown default: print("@unknown")
        }
    }
    
    
    //erreur de localisation
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //recupérer une position
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let majPosition = locations.last {
            if ((majPosition == nil) || (majPosition != nil && suivreUtilisateur)) {
                centrerPosition(nouvellePosition: majPosition)
            }
        }
        
        func centrerPosition(nouvellePosition: CLLocation) {
            majPosition = nouvellePosition
            coordoneGeo = MKCoordinateRegion(center: nouvellePosition.coordinate, span: span)
            
        }
    }
}

