//
//  VueSearchBar.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 22/04/2023.
//

import SwiftUI

struct VueSearchBar: View {
    @Binding var filtreRecherche:String
    var body: some View {
        HStack {
            TextField("Rechercher une commune", text: $filtreRecherche)
                .padding(.horizontal, 10)
                .frame(height: 36)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            Button(action: {
                filtreRecherche = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.primary)
            })
            .padding(.trailing, 10)
        }
        .frame(height: 44)    }
}

struct VueSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VueSearchBar(filtreRecherche: .constant(""))
    }
}
