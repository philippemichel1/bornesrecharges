//
//  BorneModele.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 07/07/2022.
//

import SwiftUI
import MapKit



struct BorneModele:Identifiable {
    var id:UUID = UUID()
    var nom_station:String
    var adresse_station:String
    var puissance_nominale:String
    var consolidated_longitude:Double
    var consolidated_latitude:Double
    var prise_type_ef:Bool
    var prise_type_2 :Bool
    var prise_type_combo_ccs:Bool
    var prise_type_chademo:Bool
    var prise_type_autre:Bool
    var num_pdl:String
    var nbre_pdc:String
    var paiement_acte:Bool
    var gratuit:Bool
    var paiement_cb:Bool
    var paiement_autre:Bool
    var condition_acces:String
    var accessibilite_pmr:String
    var station_deux_roues:Bool
    var raccordement:String
    
    // retourne la representation d'un point géographique
    func coordonneGeo() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: consolidated_latitude, longitude: consolidated_longitude)
    }
}




