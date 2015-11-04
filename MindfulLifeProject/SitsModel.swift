//
//  SitsModel.swift
//  MindfulLifeProject
//
//  Created by Christopher Queen on 10/10/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

import Foundation
import Alamofire

struct Sits {
    var playlistTitlesArray: [String] = []
    // Soundcloud client_url
    let clientUrl = "bc8400d9ccfc6ef41c9aca544ea5deb0"
    
    
    func getUserId(onComplete: (String) -> Void) {
        let scUrl = "http://api.soundcloud.com/resolve?url=http://soundcloud.com/mindful-life-project&client_id=\(clientUrl)"
        
        Alamofire.request(.GET, scUrl, parameters: nil).responseJSON { response in
            let result = response.result.isSuccess
            var user_id = ""
            if result {
                var json = JSON(response.result.value!)
                user_id = json["id"].stringValue
            }
            
            onComplete(user_id)
            

        }
    }
    
    func getPlaylistTitlesAndIds(onComplete: ([String:String], Bool) -> Void) {
        var playlistTitlesDict: [String:String] = [:]
        getUserId { (user_id: String) -> Void in

            // Retrieve ALL playlist data
            let scUrl = "https://api.soundcloud.com/users/\(user_id)/playlists?client_id=\(self.clientUrl)"
            Alamofire.request(.GET, scUrl, parameters: nil).responseJSON { response in
                if let data = response.result.value {
                    let jsonArray = JSON(data)
                    for playlist in jsonArray {
                        let playlistTitle = playlist.1["title"].stringValue
                        if playlistTitle != "Spanish Sits" && playlistTitle != "All Sits" {
                            playlistTitlesDict.updateValue(playlist.1["id"].stringValue, forKey: playlist.1["title"].stringValue)
                        }
                    }
                    /* Completion callback */
                    onComplete(playlistTitlesDict, true)
                } else {
                    onComplete([:], false)
                }
            }
        }
    }
    
    func getSpanishPlaylistId(onComplete: (String, Bool) -> Void) {
        var playlistTitlesDict: [String:String] = [:]
        getUserId { (user_id: String) -> Void in
            
            // Retrieve ALL playlist data
            let scUrl = "https://api.soundcloud.com/users/\(user_id)/playlists?client_id=\(self.clientUrl)"
            Alamofire.request(.GET, scUrl, parameters: nil).responseJSON { response in
                if let data = response.result.value {
                    let jsonArray = JSON(data)
                    for playlist in jsonArray {
                        let playlistTitle = playlist.1["title"].stringValue
                        if playlistTitle == "Spanish Sits" {
                            onComplete(playlist.1["id"].stringValue, true)
                        }
                    }
                } else {
                    onComplete("", false)
                }
            }
        }
    }
    
    func makeTrackAndIdsSCRequest(playlistId: String, onComplete: (urlsByTitle: [String:String], durationsByTitle: [String: String], result: Bool)-> Void) {
        let scUrl = "http://api.soundcloud.com/playlists/\(playlistId)?client_id=\(clientUrl)"
        var urlsByTitle:[String:String] = [:]
        var durationsByTitle:[String:String] = [:]
        Alamofire.request(.GET, scUrl, parameters: nil).responseJSON { response in
            if let data = response.result.value {
                let jsonArray = JSON(data)
                for jsonData in jsonArray {
                    for track in jsonData.1 {
                        let trackTitle = track.1["title"].stringValue
                        let streamUrl = track.1["stream_url"].stringValue
                        let fullUrl = "\(streamUrl)?client_id=\(self.clientUrl)"
                        let duration = track.1["duration"].stringValue
                        
                        if trackTitle != "" {
                            urlsByTitle.updateValue(fullUrl, forKey: trackTitle)
                            durationsByTitle.updateValue(duration, forKey: trackTitle)
                        }
                        
                    }
                }
                onComplete(urlsByTitle: urlsByTitle, durationsByTitle: durationsByTitle, result: true)
            } else {
                onComplete(urlsByTitle: urlsByTitle, durationsByTitle: durationsByTitle, result: false)
            }
        }
    }
    
    func getTracksAndIdsFromPlaylist(playlistId: String, onComplete: (urlsByTitle: [String:String], durationsByTitle: [String:String], result: Bool) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let language = defaults.valueForKey("language") as! String
        
        if language == "english" {
            makeTrackAndIdsSCRequest(playlistId, onComplete: { urlsByTitle, durationsByTitle, result -> Void in
                print("\(durationsByTitle)")
                onComplete(urlsByTitle: urlsByTitle, durationsByTitle: durationsByTitle, result: true)
            })
        } else {
            getSpanishPlaylistId { (spanishPlaylistId: String, result: Bool) -> Void in
                if result {
                    self.makeTrackAndIdsSCRequest(spanishPlaylistId, onComplete: { urlsByTitle, durationsByTitle, result -> Void in
                        print("\(durationsByTitle)")
                        onComplete(urlsByTitle: urlsByTitle, durationsByTitle: durationsByTitle, result: true)
                    })
                } else {
                    onComplete(urlsByTitle: ["":""], durationsByTitle: ["":""], result: false)
                }
            }
        }
    }
}
