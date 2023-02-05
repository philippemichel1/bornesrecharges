//
//  CaracteristiquesBornesVue.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 24/07/2022.
//

import SwiftUI

struct CaracteristiquesBornesVue: View {
    
    
    
    //nouvellevue vue //
    @StateObject var accesDonnees:AccesDonnees = AccesDonnees()
    @Environment(\.dismiss) private var dismiss
    
    var largeurTrame:CGFloat = 70
    var hauteurTrame:CGFloat = 70
    var largeurPicto:CGFloat = 60
    var hauteurPicto:CGFloat = 60
    var couleurTrame:Color = .gray
    var couleurPicto:Color = .white
    var picto_Valide:String = "✅"
    var picton_Non_Valide:String = "❌"
    var tailleCaratere:CGFloat = 15
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(infoComplementaireAffichage,id: \.id) { element in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack{
                                ZStack {
                                    Circle()
                                        .frame(width: largeurTrame,height: hauteurTrame)
                                        .foregroundColor(couleurTrame)
                                    if element.imageTelecharger {
                                        if element.pictogrammeDynamique {
                                            //telechargement des images
                                            AsyncImage(url: URL(string: element.imageSTR)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let returneImage):
                                                    returneImage
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: largeurPicto,height: hauteurPicto)
                                                        .clipShape((Circle()))
                                                        .overlay (Text(Bool(element.infoBorne) ?? false ? picto_Valide : picton_Non_Valide).font(.system(size: tailleCaratere)), alignment: .bottomTrailing)
                                                case .failure:
                                                    Image(systemName: "questionMark")
                                                default:
                                                    Image(systemName: "questionMark")
                                                }
                                            }
                                        } else {
                                            AsyncImage(url: URL(string: element.imageSTR)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let returneImage):
                                                    returneImage
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: largeurPicto,height: hauteurPicto)
                                                        .clipShape((Circle()))
                                                case .failure:
                                                    Image(systemName: "questionmark")
                                                default:
                                                    Image(systemName: "questionmark")
                                                }
                                            }
                                        }
                                        
                                    } else {
                                        if element.pictogrammeDynamique {
                                            // image non télélechargé
                                            Image(systemName: element.imageSTR)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:largeurPicto, height: hauteurPicto)
                                                .foregroundColor(couleurPicto)
                                                .overlay (Text(Bool(element.infoBorne) ?? false ? picto_Valide : picton_Non_Valide).font(.system(size: tailleCaratere)), alignment: .bottomTrailing)
                                        } else {
                                            Image(systemName: element.imageSTR)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:largeurPicto, height: hauteurPicto)
                                                .foregroundColor(couleurPicto)
                                        }
                                    } // if image telecharge
                                } // fin zStack
                                if element.libelleDynamique  {
                                    // modification par champs
                                    Text(element.infoBorne)
                                    
                                } else {
                                    Text(element.libelleTexte)
                                        .italic()
                                }
                                
                            } // HSTACK
                        } // fin de vstack
                        
                    }// fin du for
                } // liste
                // Bouton de fermeture sheet
//                .navigationTitle("Caracteristique Borne")
//                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: Ressources.image.fermer.rawValue)
                        }
                        .interactiveDismissDisabled()
                    }
                }
                .onDisappear {
                    infoComplementaireAffichage.removeAll()
                }
           // } // fermeture Zstack
        }
    }
    
}

struct CaracteristiquesBornesVue_Previews: PreviewProvider {
    static var previews: some View {
        CaracteristiquesBornesVue()
    }
}
