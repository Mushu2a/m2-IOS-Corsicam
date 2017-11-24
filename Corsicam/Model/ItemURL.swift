//
//  ItemURL.swift
//  Corsicam
//
//  Created by Jeremie Elbaz on 24/11/2017.
//  Copyright © 2017 Jeremie Elbaz. All rights reserved.
//

import Foundation

class ItemURL {
    
    init() {
        
    }
    
    func corse (datas: [(String,String)]) -> [(String,String)] {
        var data = datas
        data.append(("Le col de Vizzavona","https://stream.ct-corse.fr/img/cam-vizz.jpg"))
        data.append(("Le giratoire de Bocognano","https://stream.ct-corse.fr/img/cam-boco.jpg"))
        data.append(("Vivario - Parking du Chalet","https://stream.ct-corse.fr/img/cam-viva.jpg"))
        data.append(("Entrée de Venaco","https://stream.ct-corse.fr/img/cam-venaco.jpg"))
        data.append(("Le col de Pietralba","https://stream.ct-corse.fr/img/cam-pietralba.jpg"))
        data.append(("Le col de St Georges","https://stream.ct-corse.fr/img/cam-stgeorges.jpg"))
        data.append(("L'entrée sud du tunnel de Bastia","https://stream.ct-corse.fr/img/cam-tunsud.jpg"))
        return data
    }
    
    func paris (datas: [(String,String)]) -> [(String,String)] {
        var data = datas
        data.append(("Tour Eiffel", "https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/02.-sites-culturels-630-x-405/tour-eiffel-trocadero-630x405-c-thinkstock/37221-1-fre-FR/Tour-Eiffel-Trocadero-630x405-C-Thinkstock.jpg"))
        return data
    }
    
}
