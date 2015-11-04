//
//  ViewController.swift
//  MindfulLifeProject
//
//  Created by Christopher Queen on 10/4/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

import UIKit
import AVFoundation
 
class HomeViewController: UIViewController {
    
    @IBOutlet weak var sitsButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var language:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        language = defaults.valueForKey("language") as! String

    }
    
    
    @IBAction func didClickSitsBtn(sender: AnyObject) {
        if language == "english" {
            if let sitsTableViewController = storyboard!.instantiateViewControllerWithIdentifier("SitsTableViewController") as? SitsTableViewController {
                
                self.navigationController?.pushViewController(sitsTableViewController, animated: true)
            }
        } else {
            if let sitPlayerViewController = storyboard!.instantiateViewControllerWithIdentifier("SitPlayerViewController") as? SitPlayerViewController {
                
                self.navigationController?.pushViewController(sitPlayerViewController, animated: true)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

