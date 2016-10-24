//
//  ViewController.swift
//  Attendr
//
//  Created by Matt Vickers on 24/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func UIButton() {
        let alert = UIAlertController(title: "Welcome to Attendr", message: "Hello Daters!",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            nil))
        present(alert, animated: true, completion: nil)
    }
    
}




