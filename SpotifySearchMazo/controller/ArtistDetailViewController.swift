//
//  ArtistDetailViewController.swift
//  SpotifySearchMazo
//
//  Created by Diego on 17/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageArtist: UIImageView!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var artistName: String = ""
    var artistImage = UIImage()
    var artistId : String = ""
    var token: String = ""
    var albums: [Album] = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageArtist.image = artistImage
        self.nameArtist.text = artistName
        
        
        let service = SpotifyServices()
        service.DownloadAlbums(idArtist: self.artistId, accessToken: self.token) { result in
            
            
            if result?.count != 0 {
                
                self.albums = result!
                self.tableView.reloadData()
             }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.albums.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Entró acá")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlbumTableViewCell
        let album = self.albums[indexPath.row]
        
        if album.countries.count != 0 && album.countries.count < 5{
            
            var stringCountries = ""
            
            for country in album.countries{
                
                stringCountries = stringCountries + country + " , "
                
            }
        
        cell.albumCountries.text = stringCountries
            
        }else{
            
            if album.countries.count != 0{
                
                cell.albumCountries.text = "Available in more than 5 countries"
                
            }
        }
        
        cell.albumName.text = album.name
        
        let service = SpotifyServices()
        service.DownloadImage(linkImage: (album.image), completionHandler: { result in
            
            cell.albumImage.image = result!
            
            
            

        })
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAlbum"{
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let selectedAlbum = self.albums[indexPath.row]
                
                let albumViewController = segue.destination as! AlbumDetailViewController
                albumViewController.external = selectedAlbum.externalURL
                albumViewController.linkAlbumImage = selectedAlbum.image
                
            }
            
        }
    }
    
}
