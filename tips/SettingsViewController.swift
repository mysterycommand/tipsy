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
    @IBOutlet weak var defaultControl: UISegmentedControl!

    var percents: [Double] = [0.18, 0.20, 0.22]
    var defaultPercentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = NSUserDefaults.standardUserDefaults()

        if let userPercents = defaults.objectForKey("percents") as! [Double]? {
            percents = userPercents
        }

        if let userDefaultPercentIndex = defaults.objectForKey("defaultPercentIndex") as! Int? {
            defaultPercentIndex = userDefaultPercentIndex
        }
        
        defaults.setObject(percents, forKey: "percents")
        defaults.synchronize()
        
        let bad = percents[0] * 100
        let okay = percents[1] * 100
        let good = percents[2] * 100
        
        badField.text = String(format: "%.1f", bad)
        okayField.text = String(format: "%.1f", okay)
        goodField.text = String(format: "%.1f", good)
        
        for (index, percent) in enumerate([bad, okay, good]) {
            let title = String(format: "%.1f%%", percent)
            defaultControl.setTitle(title, forSegmentAtIndex: index)
        }

        defaultControl.selectedSegmentIndex = defaultPercentIndex
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

    @IBAction func onEditingChanged(sender: AnyObject) {
        let bad = badField.text._bridgeToObjectiveC().doubleValue / 100
        let okay = okayField.text._bridgeToObjectiveC().doubleValue / 100
        let good = goodField.text._bridgeToObjectiveC().doubleValue / 100
        
        println(bad)
        println(okay)
        println(good)
        
        for (index, percent) in enumerate([bad, okay, good]) {
            let title = String(format: "%.1f%%", percent * 100)
            defaultControl.setTitle(title, forSegmentAtIndex: index)
        }
    }

    @IBAction func onValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(defaultControl.selectedSegmentIndex, forKey: "defaultPercentIndex")
        defaults.synchronize()
    }

    @IBAction func onTapDone(sender: AnyObject) {
        let bad = badField.text._bridgeToObjectiveC().doubleValue / 100
        let okay = okayField.text._bridgeToObjectiveC().doubleValue / 100
        let good = goodField.text._bridgeToObjectiveC().doubleValue / 100
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject([bad, okay, good], forKey: "percents")
        defaults.synchronize()

        if let userPercents = defaults.objectForKey("percents") as! [Double]? {
            println(userPercents)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
