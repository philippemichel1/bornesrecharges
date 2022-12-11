//
//  Aleatoire.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 11/07/2022.
//

import Foundation
import SwiftUI

class Aleatoire : ObservableObject {
    @Published var hauteurAnimation:CGFloat
    
    init(hauteurAnimation: CGFloat) {
        self.hauteurAnimation = hauteurAnimation
    }
    
    func hauteurAleatoire() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(hauteurAnimation)))
    }
    
    
        
       
}

