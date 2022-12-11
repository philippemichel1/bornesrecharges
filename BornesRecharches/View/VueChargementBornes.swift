//
//  VueChargementBornes.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 11/12/2022.
//

import SwiftUI

struct VueChargementBornes: View {
    
    @StateObject var valeurAleatoire:Aleatoire = Aleatoire(hauteurAnimation: 200)
    let nbrCapsule = 2
    @State private var capsuleLargeur:CGFloat = 15
    @State private var capsuleHauteur:CGFloat = 100
    @State private var couleurCapsule:[Color] = [Color("MonRouge"),.gray, Color("MonVert")]
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var statutChargement:String
    var body: some View {
        HStack(spacing:0){
            ForEach((0...nbrCapsule).reversed(), id: \.self) {capsule in
                VueCapsule(largeur: $capsuleLargeur, hauteur: $capsuleHauteur, color: $couleurCapsule[capsule])
                    .animation((Animation.linear))
                    .onReceive(timer) { time in
                        capsuleHauteur = valeurAleatoire.hauteurAleatoire()
                    }
            }
            HStack(spacing:0){
                Text("\(statutChargement)")
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                    .frame(width: 200,height: 100)
            }
        }
    }
}

struct VueChargementBornes_Previews: PreviewProvider {
    static var previews: some View {
        VueChargementBornes(statutChargement:"Chargement complet")
    }
}
