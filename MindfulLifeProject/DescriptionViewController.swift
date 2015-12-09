//
//  DescriptionViewController.swift
//  MindfulLifeProject
//
//  Created by Christopher Queen on 11/28/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var benefits1Label: UILabel!
    @IBOutlet weak var benefits2Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let language = defaults.valueForKey("language") as! String
        
        let descriptionModel = DescriptionModel()
        let data = descriptionModel.getContent(language)
            
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        benefits1Label.text = data.benefits1
        benefits2Label.text = data.benefits2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
