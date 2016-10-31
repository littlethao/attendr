//
//  ResponseViewController.swift
//  
//
//  Created by Thao Vo on 28/10/2016.
//
//

import UIKit

class ResponseViewController: UIViewController {

    var myStringValue:Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postRSVP()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postRSVP() {
        // We will simply print out the value here
        print("The value of myStringValue is: \(myStringValue)")
        let event_id = myStringValue[3] 
        let defaults = UserDefaults.standard
        if let user_id = defaults.string(forKey: "user_id") {
            print("User ID is: \(user_id)")
            print("Event ID is: \(event_id)")
        
        var request = URLRequest(url: URL(string: "https://attendr-server.herokuapp.com/response/new")!)
        request.httpMethod = "POST"
        let postString = "user_id=\(user_id)&event_id=\(event_id)"
        print("\(postString)")
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
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
