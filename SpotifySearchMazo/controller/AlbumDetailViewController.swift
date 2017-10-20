//
//  AlbumDetailViewController.swift
//  SpotifySearchMazo
//
//  Created by Diego on 20/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var imageAlbum: UIImageView!
    
    
    var linkAlbumImage = ""
    var external = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = SpotifyServices()
        service.DownloadImage(linkImage: (self.linkAlbumImage), completionHandler: { result in
            
            self.imageAlbum.image = result!
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func SpotifyPressed(_ sender: UIButton) {
        
        let url = URL(string: self.external)

            UIApplication.shared.open(url!, options: [:], completionHandler: nil)

    }

}
