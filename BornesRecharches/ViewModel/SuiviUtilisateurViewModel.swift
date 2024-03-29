//
//  SuiviUtilisateurViewModel.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 06/06/2022.
//

import SwiftUI
import MapKit
//import CoreLocation

class SuiviUtilisateurViewModel:NSObject, CLLocationManagerDelegate, ObservableObject {
    var manager:CLLocationManager = CLLocationManager()
    @Published var coordoneGeo:MKCoordinateRegion
    @Published var suivreUtilisateur:Bool = true
    @Published var positionUtilisateur: PositionUtilisateur?
    var majPosition:CLLocation?
    var span:MKCoordinateSpan
    private var geo = CLGeocoder()
    
    
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
        montrerPosition()
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
    }
//    //Convertir un lieu en
    func geoCodeCompletion(resultat: [CLPlacemark]?, erreur: Error?) {
        guard let listeResultats = resultat?.last else {return}
        let coordonee = listeResultats.location?.coordinate
        let latitude = coordonee?.latitude ?? 0
        let longitude = coordonee?.longitude ?? 0
        let ville = listeResultats.locality ?? ""
        let pays = listeResultats.country ?? ""
        let nouvellePositionUtilisateur = PositionUtilisateur(latitude: latitude, longitude: longitude, ville: ville, pays: pays)
        self.positionUtilisateur = nouvellePositionUtilisateur
      let lieuVersCoordonnee = CLLocation(latitude: latitude, longitude: longitude)
       
    // afficher la zone choisie sur la carte
        if lieuVersCoordonnee != nil {
            centrerPosition(nouvellePosition: lieuVersCoordonnee)
        }
    }

// convertir un lieu en point géographique
    func convertirAdresse(adresse: String) {
       suivreUtilisateur = false
        montrerPosition()
        geo.geocodeAddressString(adresse, completionHandler: geoCodeCompletion(resultat:erreur:))
    }
    // centrer la position
    func centrerPosition(nouvellePosition: CLLocation) {
        majPosition = nouvellePosition
        coordoneGeo = MKCoordinateRegion(center: nouvellePosition.coordinate, span: span)
    }
    // montrer position utilisateur
    func montrerPosition() {
        suivreUtilisateur ? manager.startUpdatingLocation() : manager.stopUpdatingLocation()
    }
}


