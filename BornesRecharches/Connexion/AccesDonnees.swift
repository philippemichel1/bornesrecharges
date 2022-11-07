//
//  AccesDonnees.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 07/07/2022.
//

import SwiftUI
import UIKit

@MainActor // gestion des tâches 
class AccesDonnees:ObservableObject {
    @Published var listeBornes:[BorneModele] = []
    @Published var afficherCarte:Bool = false
    @Published var chargementBorbes:Bool = false
    @Published var ChargementExplication = "Chargement en cours"
    // lecture du fichier csv
    
    func lectureDonnees() async throws {
        //Task.init() {
        //let statusTache = Task { () -> String in
        let statusTache = Task { () in
            if let sourceFichier = URL(string: "https://titastus.com/wp-content/uploads/titastusdev/bornesrecharges/bornesrecharges.csv") {
                for try await line in sourceFichier.lines {
                    let  colonnes = line.split(separator: ";")
                    //let nom_amenageur = colonnes[0]
                    //let siren_amenageur = colonnes[1]
                    //let contact_amenageur = colonnes[2]
                    //let nom_operateur = colonnes[3]
                    //let contact_operateur = colonnes[4]
                    //let telephone_operateur = colonnes[5]
                    //let nom_enseigne = colonnes[6]
                    //let id_station_itinerance = colonnes[7]
                    //let id_station_local = colonnes[8]
                    let nom_station = nettoyageChaine(chaine: String(colonnes[9]))
                    //let implantation_station = colonnes[10]
                    let adresse_station = nettoyageChaine(chaine: String(colonnes[11]))
                    //let code_insee_commune = colonnes[12]
                    //let coordonneesXY = colonnes[13]
                    let nbre_pdc = nettoyageChaine(chaine: String(colonnes[14]))
                    //let id_pdc_itinerance = colonnes[15]
                    // let id_pdc_local = colonnes[16]
                    let puissance_nominale = nettoyageChaine(chaine: String(colonnes[17]))
                    let prise_type_ef = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[18])))
                    let prise_type_2 = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[19])))
                    let prise_type_combo_ccs = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[20])))
                    let prise_type_chademo = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[21])))
                    let prise_type_autre = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[22])))
                    let gratuit = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[23])))
                    let paiement_acte = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[24])))
                    let paiement_cb = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[25])))
                    let paiement_autre = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[26])))
                    //let horaires = colonnes[27]
                    let accessibilite_pmr = nettoyageChaine(chaine: String(colonnes[31]))
                    let condition_acces = nettoyageChaine(chaine: String(colonnes[28]))
                    let station_deux_roues = convertirStrVSBouleen(chaine: nettoyageChaine(chaine: String(colonnes[33])))
                    let raccordement = nettoyageChaine(chaine: String(colonnes[34]))
                    let num_pdl = nettoyageChaine(chaine: String(colonnes[37]))
                    //let date_mise_en_service = colonnes[32]
                    //let observations = colonnes[33]
                    //let date_maj = colonnes[34]
                    //let last_modified = colonnes[35]
                    //let datagouv_dataset_id = colonnes[36]
                    //let datagouv_resource_id = colonnes[37]
                    //let datagouv_organization_or_owner = colonnes[38]
                    let consolidated_longitude = convertirStrVSDouble(chaine: nettoyageChaine(chaine: String(colonnes[43])))
                    let consolidated_latitude = convertirStrVSDouble(chaine: nettoyageChaine(chaine: String(colonnes[44])))
                    //let consolidated_code_postal = colonnes[41]
                    //let consolidated_commune = colonnes[42]
                    //let consolidated_is_lon_lat_correct = colonnes[43]
                    //let consolidated_is_code_insee_verified = colonnes[44]
                    
                    if nom_station != "\"nom_station(9)\"" {
                        //ligne = ligne + 1
                        let mesBornes = BorneModele(nom_station: nom_station, adresse_station: adresse_station,puissance_nominale: puissance_nominale, consolidated_longitude: consolidated_longitude, consolidated_latitude: consolidated_latitude, prise_type_ef: prise_type_ef, prise_type_2: prise_type_2, prise_type_combo_ccs: prise_type_combo_ccs, prise_type_chademo: prise_type_chademo,prise_type_autre:prise_type_autre,num_pdl:num_pdl,nbre_pdc:nbre_pdc, paiement_acte:paiement_acte, gratuit: gratuit, paiement_cb: paiement_cb,paiement_autre: paiement_autre, condition_acces: condition_acces, accessibilite_pmr:accessibilite_pmr,station_deux_roues:station_deux_roues, raccordement:raccordement)
                        
                        
                        //DispatchQueue.main.async {
                            self.listeBornes.append(mesBornes)
                           //self.chargementBorbes = true
                        //}
                    }
                } // fin for
            } // fin du fin
            //return " \(ChargementExplication)"
        }
        let resultatTache = await statusTache.result
        
            switch resultatTache {
            case .success( _):
                    self.chargementBorbes = true
                    self.ChargementExplication = "Chargement terminé"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    self.afficherCarte = true
                 }
                
                   
                
            case .failure(let error):
                self.ChargementExplication = "Error: \(error.localizedDescription)"
                self.chargementBorbes = false
            }
        
        //}
    }
    
    // suppression des guillemets
    func nettoyageChaine(chaine:String) -> String {
        var newchaine:String?
        let caractereRecherche = "\""
        if chaine.contains(caractereRecherche) {
            newchaine = chaine.replacingOccurrences(of: caractereRecherche, with: "")
            newchaine = newchaine!.trimmingCharacters(in: .whitespaces)
        }
        return newchaine!
    }
    
    //convertir chaine vers double
    func convertirStrVSDouble(chaine:String) -> Double {
        var resultatDouble:Double?
        if let convertirDouble = Double(chaine) {
            resultatDouble = convertirDouble
        } else {
            resultatDouble = 0.000
        }
        return resultatDouble!
    }
    
    //convertir chaine vers booleen
    func convertirStrVSBouleen(chaine:String) -> Bool {
        var resultatBooleen:Bool?
        if let convertirBooleen = Bool(chaine) {
            resultatBooleen = convertirBooleen
        } else {
            resultatBooleen = false
        }
        return resultatBooleen!
    }
}
