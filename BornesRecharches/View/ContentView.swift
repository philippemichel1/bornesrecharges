//
//  ContentView.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 06/06/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var lireDonnees:AccesDonnees = AccesDonnees()
    @StateObject var valeurAleatoire:Aleatoire = Aleatoire()
    @StateObject var suivreUtilisateur:SuiviUtilisateurViewModel = SuiviUtilisateurViewModel(CLLocation(latitude: 0, longitude: 0))
    @State private var montrerPopup:Bool = false
    @State private var BorneSelectionnee:String = ""
    @State private var montrerFenetre:Bool = false // pour suppression
    @State private var borneSelectionAffichee:Bool = false
    @State private var valeurPuissance:String = ""
    @State private var fenetreFiltre:Bool = false
    
    //parametre écran
    let milieu = UIScreen.main.bounds.height / 2
    let largeurEcran = UIScreen.main.bounds.width
    let hauteurEcran = UIScreen.main.bounds.height
    
    // partie animation
    // paramétre pour animation capsule
    @State private var capsuleLargeur:CGFloat = 15
    @State private var capsuleHauteur0:CGFloat = 100
    @State private var capsuleHauteur1:CGFloat = 100
    @State private var capsuleHauteur2:CGFloat = 100
    @State private var couleurCapsule:[Color] = [Color("MonRouge"),.gray, Color("MonVert")]
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            
            if (self.lireDonnees.afficherCarte) == true {
                GeometryReader { geo in
                    VStack {
                        //ZStack {
                        // Map avec annotation
                        Map(coordinateRegion: $suivreUtilisateur.coordoneGeo, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: lireDonnees.listeBornes, annotationContent: { mesBornes in
                            
                            MapAnnotation(coordinate: mesBornes.coordonneGeo(), anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                                // exemple avec onTapeGesture
                                // Image(systemName: Ressources.image.borneRecharge.rawValue)
                                // .foregroundColor(.red)
                                PinAnnotation(masquerAnnotation: $montrerPopup)
                                    //.opacity(montrerPopup ? 0 : 1)
                                    .animation(Animation.linear(duration: 0.2))
                                    .onTapGesture {
                                        withAnimation {
                                            BorneSelectionnee = mesBornes.nom_station
                                            transfertInfoBorne(infoBorne: mesBornes)
                                            self.montrerPopup = true
                                        }
                                    }
                                //affichage fenetre sheet demie hauteur detail Borne carateristique
                                    .sheet(isPresented: $montrerPopup) {
                                        ZStack() {
                                            CaracteristiquesBornesVue()
                                                .frame(height:UIScreen.main.bounds.width - 10)
                                                .presentationDetents([.fraction(0.49)])
                                                .overlay(alignment:.topTrailing,content:  {
                                                    Button {
                                                        self.montrerPopup = false
                                                    } label: {
                                                        Image(systemName: Ressources.image.fermer.rawValue)
                                                            .padding(5)
                                                            .font(.title2)
                                                            .foregroundColor(.primary)
                                                            .clipShape(Circle())
                                                            .padding(5)
                                                    }
                                                })
                                        }
                                        
                                    }//fin carateristique bornes
                                
                                // fenetre montrer popup sur carte
                                if montrerPopup {
                                    if mesBornes.nom_station == BorneSelectionnee {
                                        ZStack(alignment: .top) {
                                            DetailsBornesVuePopup(libelle: .constant(mesBornes.nom_station), adresse: .constant(mesBornes.adresse_station), latitudeSTR: .constant(String(mesBornes.consolidated_latitude)), longitudeSTR: .constant(String(mesBornes.consolidated_longitude)), montrerFenetreDetail:$montrerFenetre)
                                            
                                        }
                                    }
                                }
                            }
                            
                        })
                        // si on déplace la carte passe le bouton GPS à off
                        .gesture(DragGesture().onChanged({ value in
                            if suivreUtilisateur.suivreUtilisateur == true {
                                suivreUtilisateur.suivreUtilisateur = false
                            }
                        }))
                        //.ignoresSafeArea(.container, edges: [.top, .vertical])
                        .ignoresSafeArea(.all)
                        // ferme la vue popup de la carte si on
                        .onTapGesture {
                            withAnimation {
                                montrerPopup = false
                                borneSelectionAffichee = false
                            }
                        }// bouton localisation
                        .overlay(alignment:.topTrailing,content: {
                            Button {
                                suivreUtilisateur.suivreUtilisateur.toggle()
                            } label: {
                                Image(systemName: (suivreUtilisateur.suivreUtilisateur) ? Ressources.image.localiser.rawValue : Ressources.image.nonLocaliser.rawValue)
                                    .padding()
                                    .background(.black.opacity(0.60))
                                    .font(.title2)
                                    .clipShape(Circle())
                                    .foregroundColor(suivreUtilisateur.suivreUtilisateur ? .green : .red)
                            }
                        })
                        // bouton localisation villes // tests
                        .overlay(alignment:.topLeading,content: {
                            Button {
                                self.fenetreFiltre.toggle()
                            } label: {
                                Image(systemName: (fenetreFiltre) ? Ressources.image.filtre.rawValue : Ressources.image.aucunFiltre.rawValue)
                                    .padding()
                                    .background(.black.opacity(0.60))
                                    .font(.title2)
                                    .clipShape(Circle())
                                    .foregroundColor(fenetreFiltre ? .green : .red)
                            }
                            
                        })
                        
                    } // fin Vstack
                    
                }// fin du géo
                
            } else {
                // le if est déprecier
                HStack(spacing:0){
                    // annimation de chargement
                    VueCapsule(largeur: $capsuleLargeur, hauteur: $capsuleHauteur0, color: $couleurCapsule[0])
                    VueCapsule(largeur: $capsuleLargeur, hauteur: $capsuleHauteur1, color: $couleurCapsule[1])
                    VueCapsule(largeur: $capsuleLargeur, hauteur: $capsuleHauteur2, color: $couleurCapsule[2])
                    HStack(spacing:0){
                        Text("\(lireDonnees.ChargementExplication)")
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                            .frame(width: 200,height: 100)
                    }
                    
                }
            }
        } // fin du if  lire borne
        
        
        //} // VStack
        // execute ne tâche chargement des donnée
        .task {
            try? await lireDonnees.lectureDonnees()
        }
        
        
        
        // timer pour animation
        .animation((Animation.linear))
        .onReceive(timer) { time in
            capsuleHauteur0 = valeurAleatoire.hauteurAleatoire()
            capsuleHauteur1 = valeurAleatoire.hauteurAleatoire()
            capsuleHauteur2 = valeurAleatoire.hauteurAleatoire()
        }
    } // fin du navigationView
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
