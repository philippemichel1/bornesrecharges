//
//  VueSearchBar.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 22/04/2023.
//

import SwiftUI

struct VueSearchBar: View {
    @Binding var filtreRecherche:String
    @FocusState var focusFiltreRecherche:Bool
    var body: some View {
        HStack {
            HStack {
                Image(systemName: Ressources.image.rechercher.rawValue)
                    .background(Color(.systemGray6))
                TextField("Commune", text: $filtreRecherche)
                    .focused($focusFiltreRecherche)
            }
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray,lineWidth: 1))
            if focusFiltreRecherche {
                Button(action: {
                    filtreRecherche = ""
                    focusFiltreRecherche = false
                }, label: {
                    Text("Annuler")
                        .foregroundColor(.primary)
                })
            }
        }
        .padding()
    }
    
}

struct VueSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VueSearchBar(filtreRecherche: .constant(""))
    }
}
