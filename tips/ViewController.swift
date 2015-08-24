//
//  ViewController.swift
//  tips
//
//  Created by Matt Hayes on 8/23/15.
//  Copyright (c) 2015 Matt Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentsControl: UISegmentedControl!
    
    var percents: [Double] = [0.18, 0.20, 0.22]

    override func viewDidLoad() {
        super.viewDidLoad()

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if let userPercents = defaults.objectForKey("percents") as! [Double]? {
            percents = userPercents
//            println(percents)
        }
        
        defaults.setObject(percents, forKey: "percents")
        defaults.synchronize()
        
        for (index, percent) in enumerate(percents) {
            let title = String(format: "%.2f%%", percent * 100)
            percentsControl.setTitle(title, forSegmentAtIndex: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let bill = billField.text._bridgeToObjectiveC().doubleValue

        let percent = percents[percentsControl.selectedSegmentIndex]
        let tip = bill * percent
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

