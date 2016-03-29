//
//  AuthorizationViewController.swift
//  MPS
//
//  Created by sandric on 28.03.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var errorInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if ProfileService.profileExists() {
            self.onSuccess()
        }
    }
    

    @IBAction func signInButtonPressed(sender: UIButton) {
        print("signing in username:" + self.usernameTextField.text! + ", password: " + self.passwordTextField.text!);
        
        ProfileService.signIn(self.usernameTextField.text!, password: self.passwordTextField.text!, callbackSuccess: self.onSuccess, callbackError: self.onError)
    }
    
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        print("signing up username:" + self.usernameTextField.text! + ", password: " + self.passwordTextField.text!);
        
        ProfileService.signUp(self.usernameTextField.text!, password: self.passwordTextField.text!, callbackSuccess: self.onSuccess, callbackError: self.onError)
    }
    
    
    func onSuccess () {
        print("callback success called")
        
        performSegueWithIdentifier("AuthorizedSegue", sender: self)
    }
    
    func onError (errorInfo:String) {
        print("callback error called")
        
        errorInfoLabel.text = errorInfo
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "AuthorizedSegue":
                print("All done for authorization user data")
                
            default:
                print("Unknown segue.")
        }
    }

}
