//
//  DonneeDecodable.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 15/01/2023.
//

import Foundation
struct communes:Decodable {
    var nom:String
    var code:String
    var population:Int64?
}
