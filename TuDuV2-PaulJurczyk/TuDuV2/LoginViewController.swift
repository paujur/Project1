//
//  LoginViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 1/11/17.
//  Copyright © 2017 Paul Jurczyk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: Local Variables ---------------
    
    var userEmail: String?
    var userPassword: String?
    
    // MARK: IBOutlets ---------------------
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: IBActions ---------------------
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        userEmail = emailTextField.text
        userPassword = passwordTextField.text
        
        FIRAuth.auth()!.signIn(withEmail: userEmail!, password: userPassword!){ user, error in
            if error != nil {
                self.errorLabel.text = "Please Check Your Email & Password"
            }
        }
        
    }
    
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        userEmail = emailTextField.text
        userPassword = passwordTextField.text
        
        FIRAuth.auth()!.createUser(withEmail: userEmail!, password: userPassword!) { user, error in
            if error == nil {
                FIRAuth.auth()?.signIn(withEmail: self.userEmail!, password: self.userPassword!)
            } else {
                self.errorLabel.text = "Email Is Already In Use"
            }
        }
    }
    
    // Unwind to Login Screen after logout
    
    
    @IBAction func unwindAfterLogout(segue:UIStoryboardSegue) {
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.errorLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToList", sender: nil)
            }
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
