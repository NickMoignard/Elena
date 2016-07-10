//
//  ViewController.swift
//  Elena
//
//  Created by Nicholas Moignard on 8/7/16.
//  Copyright © 2016 Elena. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
  
  
  func logUserIntoFirebase () -> Void {
    // swap facebook for firebase credentials and pass that to Firebase
    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
    FIRAuth.auth()?.signInWithCredential(credential) {
      (user, error) in
      
      print("login didCompleteWithResult")
//      self.performSegueWithIdentifier("showHome", sender: self)
    }
  }
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    let loginView = FBSDKLoginButton()
    self.view.addSubview(loginView)
    loginView.center = self.view.center
    loginView.readPermissions = ["public_profile", "email", "user_friends"]
    loginView.delegate = self
    
    
    if (FBSDKAccessToken.currentAccessToken() != nil) {
      // User is already logged in, do work such as go to next view controller.
      logUserIntoFirebase()
      
    } else {
      // need to login
      print("user needs to login")
    }
    

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // =========== FacebookSDK Delegate Methods ===================================================================================================
  
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    print("User Logged In")
    
    
    if ((error) != nil)
    {
      // Process error
      print(error.localizedDescription)
    }
    else if result.isCancelled {
      // Handle cancellations
    }
    else {
      // If you ask for multiple permissions at once, you
      // should check if specific permissions missing
      
      if result.grantedPermissions.contains("email")
      {
        // Do work
      }
      
    }
    logUserIntoFirebase()
    
    
  }

  
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    print("User Logged Out")
    try! FIRAuth.auth()!.signOut()
  }
  
  func returnUserData() {
    // grab user info from facebook
    
    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
      
      if ((error) != nil)
      {
        // Process error
        print("Error: \(error)")
      }
      else
      {
        print("fetched user: \(result)")
        let userName : NSString = result.valueForKey("name") as! NSString
        print("User Name is: \(userName)")
        let userEmail : NSString = result.valueForKey("email") as! NSString
        print("User Email is: \(userEmail)")
      }
    })
  }
  
  // =========== Segues ===================================================================================================
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "showHome") {
      let destinationViewController = segue.destinationViewController as! HomeViewController
      
      // set properties of destinationViewController
      destinationViewController.username = "WOW!"
    }
  }
  

}


