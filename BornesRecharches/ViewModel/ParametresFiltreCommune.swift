//
//  Parametres.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 23/01/2023.
//

import Foundation
import SwiftUI

class ParametresFiltreCommune: ObservableObject {
    @Published var montrerParametre = false
    @Published var communeEstSelectionnee:Bool = false
    @Published var parametreCommunes:String = ""
    @Published var filtreCarteActiver:Bool = false
    
    
}
