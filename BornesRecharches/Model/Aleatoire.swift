//
//  Aleatoire.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 11/07/2022.
//

import Foundation
import SwiftUI

class Aleatoire : ObservableObject {
    @Published var Hauteur:CGFloat
    
    init(Hauteur: CGFloat) {
        self.Hauteur = Hauteur
    }
    
    func hauteurAleatoire() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(Hauteur)))
    }
    
    
        
       
}

