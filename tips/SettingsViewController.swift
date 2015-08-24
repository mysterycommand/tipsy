//
//  SettingsViewController.swift
//  tips
//
//  Created by Matt Hayes on 8/23/15.
//  Copyright (c) 2015 Matt Hayes. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var badField: UITextField!
    @IBOutlet weak var okayField: UITextField!
    @IBOutlet weak var goodField: UITextField!

    var percents: [Double] = [0.18, 0.20, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userPercents = defaults.objectForKey("percents") as! [Double]? {
            percents = userPercents
        }
        
        defaults.setObject(percents, forKey: "percents")
        defaults.synchronize()
        
        println(Int(percents[0] * 100))

        badField.text = String(format: "%d", Int(percents[0] * 100))
        okayField.text = String(format: "%d", Int(percents[1] * 100))
        goodField.text = String(format: "%d", Int(percents[2] * 100))
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

    @IBAction func onTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
