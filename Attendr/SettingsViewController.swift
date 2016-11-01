//
//  FacebookAuth.swift
//  Attendr
//
//  Created by Matt Vickers on 26/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        // better to use constraints than frames here
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout successful")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        }
        print("Login successful")
        self.getFBUserData()
        
        self.transitionToEvents()
    }
    func transitionToEvents(){
        // Instantiate SecondViewController
        let TabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        
        // Take user to SecondViewController
        self.present(TabBarController, animated: true)
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, picture.type(large),gender, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    self.postUser()
                }
            })
        }
    }
    
    func postUser() {
        let firstName = self.dict["first_name"]!
        let lastName = self.dict["last_name"]!
        let facebookId = self.dict["id"]!
        let age = "nil"
        let gender = self.dict["gender"]!
        var request = URLRequest(url: URL(string: "https://attendr-server.herokuapp.com/users/new")!)
        request.httpMethod = "POST"
        let postString = "first=\(firstName)&last=\(lastName)&fbid=\(facebookId)&age=\(age)&gender=\(gender)"
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
