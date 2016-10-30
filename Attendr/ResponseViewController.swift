//
//  ResponseViewController.swift
//  
//
//  Created by Thao Vo on 28/10/2016.
//
//

import UIKit

class ResponseViewController: UIViewController {

    var myStringValue:Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We will simply print out the value here
        print("The value of myStringValue is: \(myStringValue!)")
        let defaults = UserDefaults.standard
        
        if let stringOne = defaults.string(forKey: "user_id") {
               print("User ID is: \(stringOne)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
