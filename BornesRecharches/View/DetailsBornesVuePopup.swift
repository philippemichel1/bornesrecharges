//
//  DetailsBornesVuePopup.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 14/07/2022.
//

import SwiftUI

struct DetailsBornesVuePopup: View {
    @State var deplacementFenetre:CGSize = CGSize.zero
    @Binding var libelle:String
    @Binding var adresse:String
    @Binding var latitudeSTR:String
    @Binding var longitudeSTR:String
    @Binding var montrerFenetreDetail:Bool
    
    var body: some View {
       VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(libelle)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
                    .padding(.bottom,5)
                
            }
            VStack(alignment: .leading) {
                Text("Adresse")
                    .underline()
                    .font(.system(size: 11))
                    .padding(.bottom,0.5)
                
                Text(adresse)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
            }
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            
            VStack(alignment: .leading) {
                Text("Position")
                    .underline()
                    .font(.system(size: 11))
                    .padding(.top,5)
                    .padding(.bottom,0.5)
                
                Text("Latitude " + latitudeSTR)
                    .font(.system(size: 13))
                    .padding(.trailing)
                Text("Longitude " + longitudeSTR)
                    .font(.system(size: 13))
                    .padding(.trailing)
                
            }
        }
        .padding(5)
        .frame(width: 220, height: 200)
        .background(Color.gray.opacity(0.60)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 10, x: 3, y: -1))
        //.position(x:UIScreen.main.bounds.width / 2,y:110)
        
    }
}

struct DetailsBornesVuePopup_Previews: PreviewProvider {
    static var previews: some View {
        DetailsBornesVuePopup(libelle: .constant("Borne Dijon ma borne est la plus"), adresse: .constant("15 bis rue edmé Piot 21000 dijon"), latitudeSTR: .constant("0.9876543"), longitudeSTR: .constant("0.7654321"), montrerFenetreDetail: .constant(true))
    }
}
