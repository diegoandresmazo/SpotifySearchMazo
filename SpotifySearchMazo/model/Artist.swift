//
//  Artist.swift
//  SpotifySearchMazo
//
//  Created by Diego on 14/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class Artist: NSObject {
    
        var name: String
        var followers : Int
        var popularity : Int
        var image : String
        var id : String
    
    init(name: String, followers: Int, popularity: Int, id: String, image: String) {
            
            self.name = name
            self.followers = followers
            self.popularity = popularity
            self.image = image
            self.id = id
        }
}
