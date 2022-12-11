//
//  CaracteristiqueBorneModele.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 11/12/2022.
//

import Foundation
// Struct pour affichage des données dans la vue caractique des bornes
struct CaracteristiqueBorneModele:Identifiable {
    var id:UUID = UUID()
    var imageSTR:String
    var imageTelecharger:Bool
    var libelleTexte:String
    var libelleDynamique:Bool
    var pictogrammeDynamique:Bool
    var infoBorne:String
}
