//
//  Album.swift
//  SpotifySearchMazo
//
//  Created by Diego on 17/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class Album: NSObject {
    
    var name: String
    var image : String
    var id : String
    var externalURL : String
    var countries: [String]
    
    init(name: String, id: String, image: String, countries:  [String], externalURL: String) {
        
        self.name = name
        self.image = image
        self.id = id
        self.countries = countries
        self.externalURL = externalURL
        
    }

}
