//
//  FirebaseAuth.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 1/11/17.
//  Copyright © 2017 Paul Jurczyk. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    

}
