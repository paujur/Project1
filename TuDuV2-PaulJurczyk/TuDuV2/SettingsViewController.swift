//
//  SettingsViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 1/13/17.
//  Copyright © 2017 Paul Jurczyk. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {

    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // changing bar back button color
       self.navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 0.14, blue: 0.28, alpha: 1.0)      }

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
