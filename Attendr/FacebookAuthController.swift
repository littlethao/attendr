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

class FacebookAuthController: UIViewController, FBSDKLoginButtonDelegate {
    
    var dict : [String : AnyObject]!
    
    override func viewDidAppear(_ animated:Bool){
        if FBSDKAccessToken.current() != nil{
            self.transitionToEvents()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.current() == nil{
            
            let loginButton = FBSDKLoginButton()
            view.addSubview(loginButton)
            // better to use constraints than frames here
            loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
            
            loginButton.delegate = self
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout successful")
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
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }

}
