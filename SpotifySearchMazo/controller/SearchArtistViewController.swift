//
//  SearchArtistViewController.swift
//  SpotifySearchMazo
//
//  Created by Diego on 14/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class SearchArtistViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var tapGesture: UITapGestureRecognizer!
    var tapGestureImage: UITapGestureRecognizer!
    var token : String = ""
    var artistImage = UIImage()
    var artistName : String = ""
    var artistId : String = ""
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var imageArtist: UIImageView!
    @IBOutlet weak var artistView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        self.imageArtist.addGestureRecognizer(self.tapGestureImage)

        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
        self.view.addGestureRecognizer(self.tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
            self.artistView.isHidden = true
            
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let term = searchBar.text{
            
            let service = SpotifyServices()
            service.SearchArtist(query: term, accessToken: self.token, completionHandler: {
                result in
                
                self.artistView.isHidden = false
                
                if result != nil {
                
                    self.labelName.text = result!.name
                    self.labelFollowers.text =  String(describing: result!.followers)
                    self.labelPopularity.text = String(describing: result!.popularity)
                    
                    self.artistName = result!.name
                    self.artistId = result!.id
                    
                
                service.DownloadImage(linkImage: (result?.image)!, completionHandler: { result in
                    
                self.imageArtist.image = result
                    
                    self.artistImage = result!
                    
                })
              
                }else{
                    
                    self.labelName.text = "Artist Not Found"
                    self.labelFollowers.text =  ""
                    self.labelPopularity.text = ""
                    
                }
            
            })
        }
    }
    
    @objc func hideKeyboard(){
        
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(self.tapGesture)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        if (gesture.view as? UIImageView) != nil {
            
            let artistDetailVC = storyboard?.instantiateViewController(withIdentifier: "ArtistDetail") as! ArtistDetailViewController
            
                artistDetailVC.artistName = self.artistName
                artistDetailVC.artistImage = self.artistImage
                artistDetailVC.token = self.token
                artistDetailVC.artistId = self.artistId
            
            navigationController?.pushViewController(artistDetailVC, animated: true)

        }
    }
    
}
