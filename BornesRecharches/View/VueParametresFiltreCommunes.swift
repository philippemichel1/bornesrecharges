//
//  VueParametres.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 23/01/2023.
//

import SwiftUI

struct VueParametresFiltreCommunes: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.dismissSearch) private var dismissSearch
    @StateObject private var accesDonnees:AccesDonnees = AccesDonnees()
    @State var filtreRecherche: String = ""
    @State var clavierAfficher:Bool = false
    @State var ordreTriAlpha:Bool = true
    @State var communesSelectionnee: String = ""
    var pictogramme:[String] = ["abc", "figure.stand"]
    @State  var selection:Int = 1
    @ObservedObject var parametres: ParametresFiltreCommune
    @FocusState var focusSearch:Bool
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if accesDonnees.chargementDonnees {
                   //Form {
                        Label {
                            Text(parametres.communeEstSelectionnee ? "Valider votre choix pour que la carte se déplace " : "Séléctionnez une communes  pour visualiser les bornes disponibles.")
                                .padding(parametres.communeEstSelectionnee ? EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10) :  EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 13))
                                .foregroundColor(.primary)
                            
                        } icon: {
                            Image(systemName: (parametres.communeEstSelectionnee) ? Ressources.image.deplaceCarte.rawValue : Ressources.image.visualiser.rawValue)
                                .padding()
                            // .font(.system(size: 13))
                                .foregroundColor(.primary)
                                .frame(width: 10, height: 10)
                        }
                   // }// fin form
                   .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        
                    Spacer()
                    Picker("", selection: $selection) {
                        ForEach(0..<pictogramme.count) {choix in
                            Image(systemName: pictogramme[choix])
                                .onChange(of: selection) { ValeurChoisit in
                                    if ValeurChoisit == 0 {
                                        accesDonnees.trierVilleOrdreAlpha()
                                    } else {
                                        accesDonnees.trierVilleNBHabitantsDesCroissant()
                                    }
                                    
                                }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(EdgeInsets(top: 0.5, leading: 10, bottom: 0.5, trailing: 10))
                   Spacer()
                    ScrollView {
                        LazyVStack() {
                            //création d'une liste de ville
                            ForEach(accesDonnees.listeVilles,id: \.code) {villeIndex  in
                                if filtreRecherche.isEmpty || villeIndex.nom.contains(filtreRecherche) || villeIndex.nom.lowercased().contains(filtreRecherche) {
                                    HStack {
                                        Text("\(villeIndex.nom)")
                                            .font(.system(size: 13))
                                            .foregroundColor(.primary)
                                        Button(action: {
                                            self.parametres.communeEstSelectionnee .toggle()
                                            if (villeIndex.nom == communesSelectionnee) {
                                                self.parametres.communeEstSelectionnee = false
                                                self.communesSelectionnee = ""
                                               // self.focusSearch = false
                                                //dismissSearch()
                                            } else {
                                                self.parametres.communeEstSelectionnee = true
                                                self.communesSelectionnee = villeIndex.nom
                                                //self.focusSearch = false
                                                //dismissSearch()
                                            }
                                            
                                            
                                            if clavierAfficher {
                                                rentrerClavier()
                                            }
                                        }, label: {
                                            Image(systemName: (villeIndex.nom == communesSelectionnee && parametres.communeEstSelectionnee == true) ? Ressources.image.deselection.rawValue : Ressources.image.visualiser.rawValue)
                                            //Image(systemName: Ressources.image.visualiser.rawValue)
                                                .foregroundColor(villeIndex.nom == communesSelectionnee && parametres.communeEstSelectionnee == true ? Color("MonRouge") : Color("MonVert"))
                                            
                                        })
                                    }
                                }// fin if filtre
                                
                            }
                            // .focused($focusSearch)
                        } // fin LazyStack
                    } // fin scrollView
                    //.padding(EdgeInsets(top: 0.5, leading: 10, bottom: 0.5, trailing: 10))
                    //.frame(width: UIScreen.main.bounds.width - 10,height: UIScreen.main.bounds.height / 5)
                    Spacer()
                    .searchable(text: $filtreRecherche,prompt: "Rechercher commune")
                    
                    //}// fin form
                } else {
                    VueDeChargement(statutChargement: accesDonnees.ChargementExplication)
                } // fin de if
            } //fin Vstack
            // bouton de la vue sheet
            .navigationTitle("Paramètrage")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if parametres.communeEstSelectionnee {
                            parametres.parametreCommunes = self.communesSelectionnee
                        }
                        
                        dismiss()
                    } label: {
                        Image(systemName: (parametres.communeEstSelectionnee) ? Ressources.image.deplaceCarte.rawValue : Ressources.image.fermer.rawValue)
                    }
                    .interactiveDismissDisabled()
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent).foregroundColor(.primary)
                    
                }
            }
            // chargement de donnee
            .task {
                await accesDonnees.connexionJson()
            }
            // lorsque ka vue s'ouvre
            .onAppear {
                
            }
            //lorsque la vue se ferme
            .onDisappear {
                parametres.filtreCarteActiver = true
                accesDonnees.listeVilles.removeAll()
                
                print("fenetre est fermé")
            }
            
        }
    }
    //rentre le clavier
    func rentrerClavier() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct VueParametres_Previews: PreviewProvider {
    static var previews: some View {
        VueParametresFiltreCommunes(parametres: ParametresFiltreCommune())
    }
}
