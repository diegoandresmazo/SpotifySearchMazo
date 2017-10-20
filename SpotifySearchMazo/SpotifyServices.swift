//
//  SpotifyServices.swift
//  SpotifySearchMazo
//
//  Created by Diego on 14/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON


class SpotifyServices {
    
    var resultArtist : Artist!
    var resultAlbums =  [Album]()

    func SearchArtist(query:String, accessToken: String, completionHandler: @escaping (Artist?) -> Void) {
    
        let url = URL(string: "https://api.spotify.com/v1/search")!
        
        Alamofire.request(url, method: .get, parameters: ["type":"artist", "q":query, "market":"US", "limit": "1"], encoding: URLEncoding.default, headers: ["Authorization": "Bearer " + accessToken]).responseJSON(){ response in
        
            switch response.result {
            
            case .success:
                
                    if let value = response.result.value{
                
                        let json = JSON(value)
                
                        let artists = json["artists"]["items"].arrayValue
                
                            for artist in artists{
                                
                                var stringImages = [String]()
                                
                                let nameArtist = artist["name"].stringValue
                                let popularityArtist = artist["popularity"].intValue
                                let idArtist = artist["id"].stringValue
                                let followersArtist = artist["followers"]["total"].intValue
                                let images = artist["images"].arrayValue
                                
                                for image in images{

                                    let imageLink = image["url"].stringValue
                                    stringImages.append(imageLink)
                                    
                                }
                                
                                if images.count == 0 {
                                    
                                    
                                stringImages.append("https://pbs.twimg.com/profile_images/558556141605511168/2JDJX8SQ.png")
                                    
                                }
                                
                                self.resultArtist = Artist(name: nameArtist, followers: followersArtist, popularity: popularityArtist, id: idArtist, image: stringImages[0])
                }
                
            }
            completionHandler(self.resultArtist)
            
        case .failure(let error):
            
            print(error)
            completionHandler(nil)
            
            }
        }
    }
    
    func DownloadImage(linkImage:String, completionHandler: @escaping (UIImage?) -> Void) {
        
        var imageView = UIImage()
        let url = URL(string: linkImage)
        
        Alamofire.request(url!).responseImage { response in
            
        switch response.result {
         
        case .success:
            
            if let image = response.result.value {
                
                imageView = image
                
            }
            completionHandler(imageView)

            
        case .failure(let error):
                
                print(error)
                completionHandler(nil)
            }
            
        }
        
        

    }
    
    func DownloadAlbums(idArtist:String, accessToken: String, completionHandler: @escaping ([Album]?) -> Void) {
        
        let linkCompleto = "https://api.spotify.com/v1/artists/" + idArtist + "/albums"
        let url = URL(string: linkCompleto)
        
       Alamofire.request(url!, method: .get, parameters: ["type":"single,album", "market":"US"], encoding: URLEncoding.default, headers: ["Authorization": "Bearer " + accessToken]).responseJSON() { response in
            
        
        switch response.result {
            
        case .success:
            
            if let value = response.result.value{
                
                let json = JSON(value)
                
                let albums = json["items"].arrayValue
                
                
                for album in albums{
                    
                    var stringImages = [String]()
                    var stringCountries = [String]()
                    
                    let nameAlbum = album["name"].stringValue
                    let idAlbum = album["id"].stringValue
                    let images = album["images"].arrayValue
                    let countries =  album["available_markets"].arrayValue
                    let externalURL = album["external_urls"]["spotify"].stringValue
                    
                    for country in countries{
                        
                        let stringCountry = country.stringValue
                        stringCountries.append(stringCountry)
                        
                    }
                    
                    for image in images{
                        
                        let imageLink = image["url"].stringValue
                        stringImages.append(imageLink)
                        
                    }
                    
                    if images.count == 0 {
                        
                        stringImages.append("https://pbs.twimg.com/profile_images/558556141605511168/2JDJX8SQ.png")
                    }
                    
                    let resultAlbum = Album(name: nameAlbum, id: idAlbum, image: stringImages[0], countries: stringCountries, externalURL: externalURL)
                
                    
                    self.resultAlbums.append(resultAlbum)
                }
            }
            completionHandler(self.resultAlbums)
            
        case .failure(let error):
            
                print(error)
                completionHandler(nil)
            
                }

            }
            
        }
}
