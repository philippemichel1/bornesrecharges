//
//  DonneesVueBorneCaracteristique.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 24/08/2022.
//

import Foundation
import SwiftUI

var infoComplementaireAffichage:[ElementModel] = []
    // recupere les info de la borne selectionne
    func transfertInfoBorne(infoBorne: BorneModele){
        var donneesSurBornes = [ElementModel(imageSTR: "https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/images/prise_type_ef.jpeg", imageTelecharger: true,libelleTexte: "Prise Type EF",libelleDynamique: false, pictogrammeDynamique: true, infoBorne: String(infoBorne.prise_type_ef)),
                                         ElementModel(imageSTR: "https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/images/prise_type_2.jpeg", imageTelecharger: true,libelleTexte:"Prise Type 2",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.prise_type_2)),
                                         ElementModel(imageSTR:"https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/images/prise_type_combo_ccs.jpeg", imageTelecharger: true,libelleTexte:"Prise Combo CCS",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.prise_type_combo_ccs)),
                                         ElementModel(imageSTR:"https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/images/prise_type_chademo.jpeg", imageTelecharger: true,libelleTexte:"Prise Chademo",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.prise_type_chademo)),
                                         ElementModel(imageSTR: "powerplug.fill", imageTelecharger: false,libelleTexte:"Autre Prise",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.prise_type_autre)),
                                         ElementModel(imageSTR: "bolt.fill", imageTelecharger: false, libelleTexte:"",libelleDynamique: true,pictogrammeDynamique: false,infoBorne: String(infoBorne.puissance_nominale)),
                                         ElementModel(imageSTR: "car.2.fill", imageTelecharger: false, libelleTexte:"",libelleDynamique: true,pictogrammeDynamique: false,infoBorne: String(infoBorne.nbre_pdc)),
                                         ElementModel(imageSTR: "eurosign.circle.fill", imageTelecharger: false, libelleTexte:"Recharge Gratuite",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.gratuit)),
                                         ElementModel(imageSTR: "purchased.circle.fill", imageTelecharger: false,libelleTexte:"Paiment Acte",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.paiement_acte)),
                                         ElementModel(imageSTR: "creditcard.fill", imageTelecharger: false, libelleTexte:"Carte Crédit",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.paiement_cb)),
                                         ElementModel(imageSTR: "a.circle.fill", imageTelecharger: false, libelleTexte:"Paiement Autre",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.paiement_autre)),
                                         ElementModel(imageSTR: "lock.square.stack.fill", imageTelecharger: false,libelleTexte:"",libelleDynamique: true,pictogrammeDynamique: false,infoBorne: String(infoBorne.condition_acces)),
                                         ElementModel(imageSTR: "figure.roll.runningpace", imageTelecharger: false,libelleTexte:"",libelleDynamique: true,pictogrammeDynamique: false,infoBorne: String(infoBorne.accessibilite_pmr)),
                                         ElementModel(imageSTR: "figure.outdoor.cycle", imageTelecharger: false,libelleTexte:"Station deux roues",libelleDynamique: false,pictogrammeDynamique: true,infoBorne: String(infoBorne.station_deux_roues)),
                                         ElementModel(imageSTR: "cable.connector.horizontal", imageTelecharger: false, libelleTexte:"",libelleDynamique: true,pictogrammeDynamique: false,infoBorne: String(infoBorne.raccordement))]
        
        infoComplementaireAffichage = donneesSurBornes
        
}






