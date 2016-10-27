//
//  EventsController.swift
//  Attendr
//
//  Created by jonathan shad on 27/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EventsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("hello")
        Alamofire.request("https://attendr-server.herokuapp.com/events").responseJSON { response in
            
            
            if let value = response.result.value {
                let json = JSON(value)
                
                print(json["events"][0]["name"].stringValue)
                print(json["events"][0]["address"].stringValue)
                print(json["events"][0]["date"].stringValue)
                print(json["events"][0]["link"].stringValue)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

