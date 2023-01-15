//
//  VueFilltreCommunes.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 15/01/2023.
//

import SwiftUI

struct VueFilltreCommunes: View {
    var body: some View {
        VStack {
            Text("Séléctionnez une communes pour visualiser les bornes disponibles.")
                .padding()
                .padding(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .font(.system(size: 13))
                .foregroundColor(.primary)
            Spacer()
        }
       
    }
}

struct VueFilltreCommunes_Previews: PreviewProvider {
    static var previews: some View {
        VueFilltreCommunes()
    }
}
