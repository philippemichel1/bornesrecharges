//
//  LocaliseLieuViewModel.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 28/02/2023.
//

import Foundation
import CoreLocation

class LocaliseLieuViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    private var geo = CLGeocoder()
    private var manager = CLLocationManager()
    @Published var lieuVersCoordonnee:CLLocation?
    var positionUtilisateur: PositionUtilisateur?
    
    
    
    //convertir un point géographique en localisation
    func convertirCoordone(position: CLLocation) {
        geo.reverseGeocodeLocation(position, completionHandler: geoCodeCompletion(resultat:erreur:))
    }
    
    //Convertir un lieu en
    func geoCodeCompletion(resultat: [CLPlacemark]?, erreur: Error?) {
        guard let listeResultats = resultat?.last else {return}
        let coordonee = listeResultats.location?.coordinate
        let latitude = coordonee?.latitude ?? 0
        let longitude = coordonee?.longitude ?? 0
        let ville = listeResultats.locality ?? ""
        let pays = listeResultats.country ?? ""
        let nouvellePositionUtilisateur = PositionUtilisateur(latitude: latitude, longitude: longitude, ville: ville, pays: pays)
        self.positionUtilisateur = nouvellePositionUtilisateur
        lieuVersCoordonnee = CLLocation(latitude: latitude, longitude: longitude)
        print("Lieu vers coordonnée lors de l'appel: \(lieuVersCoordonnee!)")
    }
    
    // convertir un lieu en point géographique
    func convertirAdresse(adresse: String) {
       //suivreUtilisateur = false
        //montrerPosition()
        manager.stopUpdatingLocation()
        geo.geocodeAddressString(adresse, completionHandler: geoCodeCompletion(resultat:erreur:))
    }
    
    
}



