//
//  VueCapsule.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 11/07/2022.
//

import SwiftUI

struct VueCapsule: View {
    @Binding  var largeur:CGFloat
    @Binding var hauteur:CGFloat
    @Binding var color:Color
    
    var body: some View {
        Capsule()
            .frame(width: largeur, height: hauteur, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(color)
    }
}
struct VueCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VueCapsule(largeur: .constant(10), hauteur: .constant(100), color: .constant(.red))
    }
}
