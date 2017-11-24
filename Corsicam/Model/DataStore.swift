//
//  DataStore.swift
//  Corsicam
//
//  Created by Jeremie Elbaz on 24/11/2017.
//  Copyright © 2017 Jeremie Elbaz. All rights reserved.
//

import Foundation

class DataStore {
    
    var titre:String
    var data:Data
    var date: String
    
    init(titre: String, data: Data) {
        self.data = data
        self.titre = titre
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.date = formatter.string(from: Date())
    }
}
