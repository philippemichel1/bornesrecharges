//
//  VueDeChargement.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 12/12/2022.
//

import SwiftUI

struct VueDeChargement: View {
    @StateObject var valeurAleatoire:Aleatoire = Aleatoire(hauteurAnimation: 200)
    let nbrCapsule = 2
    @State private var hauteurCapsule:[CGFloat] = [0,0,0]
    @State private var capsuleLargeur:CGFloat = 15
    @State private var couleurCapsule:[Color] = [Color("MonRouge"),.gray, Color("MonVert")]
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var statutChargement:String
    var body: some View {
        HStack(spacing:0){
            ForEach((0...nbrCapsule).reversed(), id: \.self) {capsule in
                VueCapsule(largeur: $capsuleLargeur, hauteur: $hauteurCapsule[capsule], color: $couleurCapsule[capsule])
                    .animation(.linear(duration: 0.4),value: hauteurCapsule[capsule])
                    .onReceive(timer) { time in
                        hauteurCapsule[capsule] = valeurAleatoire.hauteurAleatoire()
                    }
            }
            
            Text("\(statutChargement)")
                .font(.caption2)
                .multilineTextAlignment(.leading)
                .frame(width: 200,height: 100)
        }
        
    }
}

struct VueDeChargement_Previews: PreviewProvider {
    static var previews: some View {
        VueDeChargement(statutChargement: "Chargement complet")
    }
}
