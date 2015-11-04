//
//  SitPlayerViewController.swift
//  MindfulLifeProject
//
//  Created by Christopher Queen on 10/16/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SitPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var togglePlay: UIButton!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    var playerItem:AVPlayerItem!
    var player:AVPlayer!
    
    var trackUrl:String!
    
    var playlistTitleAndId:(title:String, id:String) = ("", "")
    var trackTitles:[String] = ["Loading..."]
    var trackUrls:[String] = []
    var durations:[String] = []
    //    let clientUrl = "bc8400d9ccfc6ef41c9aca544ea5deb0"
    
    @IBOutlet weak var trackListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trackListTableView.userInteractionEnabled = false
        
        trackListTableView.dataSource = self
        trackListTableView.delegate = self
        let sitsModel = Sits()
        sitsModel.getTracksAndIdsFromPlaylist(playlistTitleAndId.id, onComplete: { urlsByTitle, durationsByTitle, result in
            if result {
                self.trackTitles = Array(urlsByTitle.keys)
                self.trackListTableView.dataSource = self
                self.trackUrls = Array(urlsByTitle.values)
                self.durations = Array(durationsByTitle.values)

                self.trackListTableView.reloadData()
                self.trackListTableView.userInteractionEnabled = true
            } else {
                let alertController = UIAlertController(title: "No Internet Connection", message:
                    "Connect to the internet to access sits", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                self.trackListTableView.userInteractionEnabled = false
                self.trackTitles = ["No Internet Connection"]
                self.trackListTableView.reloadData()
            }

        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    //
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.trackTitles.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("track", forIndexPath: indexPath)
        var titlesArray = trackTitles
        let sit = titlesArray[indexPath.row]
        cell.textLabel?.text = sit
        var durationString = ""
        
        if durations.count > 0 {
            durationString = secondsToHoursMinutesSeconds(Int(durations[indexPath.row])!)
        }
        
        cell.detailTextLabel?.text = durationString


        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        self.trackUrl = trackUrls[0]
        

//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        let activityIndicator = UIActivityIndicatorView()
//        cell?.accessoryView = activityIndicator
//        activityIndicator.startAnimating()
        
//        self.updatePlayer(indexPath.row)
    }
    
//    func initPlayer() {
//        player = AVPlayer()
//        trackListTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
//        
//        
//        let cell = trackListTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
//        let activityIndicator = UIActivityIndicatorView()
//        cell?.accessoryView = activityIndicator
//        
//        let trackUrl = NSURL(string: trackUrls[0])
//        let asset = AVAsset(URL: trackUrl!)
//        
//        asset.loadValuesAsynchronouslyForKeys(["duration"], completionHandler: { () -> Void in
//            let tmpPlayerItem = AVPlayerItem(asset: asset)
//            self.player.replaceCurrentItemWithPlayerItem(tmpPlayerItem)
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                let cell = self.trackListTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
//                let activityIndicator = cell?.accessoryView as! UIActivityIndicatorView
//                activityIndicator.stopAnimating()
//            }
//        })
//    }
    
//    func updatePlayer(index: Int) {
//
//        let trackUrl = NSURL(string: trackUrls[index])
//        let asset = AVAsset(URL: trackUrl!)
//        
//        asset.loadValuesAsynchronouslyForKeys(["duration"], completionHandler: { () -> Void in
//            let tmpPlayerItem = AVPlayerItem(asset: asset)
//            self.player.replaceCurrentItemWithPlayerItem(tmpPlayerItem)
//            self.player.play()
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                let cell = self.trackListTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
//                let activityIndicator = cell?.accessoryView as! UIActivityIndicatorView
//                activityIndicator.stopAnimating()
//            }
//        })
//    }
    
    func secondsToHoursMinutesSeconds (milliseconds : Int) -> String {
        let totalSeconds = milliseconds / 1000
        let m = (totalSeconds % 3600) / 60
        let s = ((totalSeconds % 3600) % 60)
        
        return "\(m):\(s)"
    }
    

    
    @IBAction func didPressToggleBtn(sender: AnyObject) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! AVPlayerViewController
        let index = trackListTableView.indexPathForSelectedRow?.row
        let url = NSURL(string:
            self.trackUrls[index!])
        destination.player = AVPlayer(URL: url!)
        destination.player!.play()
    }
}


