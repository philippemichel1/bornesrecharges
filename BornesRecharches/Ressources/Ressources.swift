//
//  Ressources.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 06/06/2022.
//

import Foundation
import SwiftUI

// Liste des images
struct Ressources {
    enum image:String {
        case epingle = "pin.fill"
        case localiser = "location.fill"
        case nonLocaliser = "location.slash.fill"
        case borneRecharge = "powerplug.fill"
        case fermer = "xmark.circle.fill"
        case pmr = "figure.roll.runningpace"
        case deuxroux = "figure.outdoor.cycle"
        case carteCredit = "creditcard.fill"
        case euro = "eurosign.circle.fill"
        case paiementacte = "arrow.up.right.and.arrow.down.left.rectangle.fill"
        case autrepaiement = "purchased.circle.fill"
        case cadenas = "lock.square.stack.fill"
        case racordement = "cable.connector.horizontal"
        case puissance_nominale = "bolt.fill"
        case nbr_bornes = "car.2.fill"
        case aucunFiltre = "tray.and.arrow.up.fill"
        case filtre = "tray.and.arrow.down.fill"
        case visualiser = "eye.fill"
        case deplaceCarte = "move.3d"
        case deselection = "trash.fill"
        
        
        
        // Liste des urls (images)
        enum urlString:String {
            case prisetype2 =  "https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/images/prise_type_2.jpeg"
        }
        
        
            
        
        
    }
}
