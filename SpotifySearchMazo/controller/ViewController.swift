//
//  ViewController.swift
//  SpotifySearchMazo
//
//  Created by Diego on 14/10/17.
//  Copyright © 2017 DiegoMazo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        UIApplication.shared.open(loginUrl!, options: [:], completionHandler: nil)
    }
    
    func setup () {
        
        auth.redirectURL     = URL(string: "SpotifySearchMazo://returnAfterLogin")
        auth.clientID        = "e98ff4dea592477db453dff925c9a738"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
        
    }
    
    @objc func updateAfterFirstLogin () {
        
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            self.loginButton.isHidden = true
            
            let searchArtistVC = storyboard?.instantiateViewController(withIdentifier: "SearchArtist") as! SearchArtistViewController
            
            searchArtistVC.token = self.session.accessToken
            
            navigationController?.pushViewController(searchArtistVC, animated: true)
            
        }
        
    }
    
}

