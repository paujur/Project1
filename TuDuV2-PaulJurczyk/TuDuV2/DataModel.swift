//
//  DataModel.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//


import Foundation
import Firebase

// MARK: Global Variables ----------------------

var listOfListsArray = [ListOfTasks]()
//var currentListName: String?
//var currentTask: Task?
//var currentList = [Task]()




class ListOfTasks {
    var name: String
    var listOfTasksArray = [Task]()
    var ref: FIRDatabaseReference?
    init(name: String) {
        self.name = name
    }
    // this changes it to an object for Firebase to use
    func toAnyObject() -> Any {
        return [
            "name": name
        ]
    }
}

class  Task {
    
    var name: String
    var details = String()
    var dueDate = String()
    var ref: FIRDatabaseReference?
    init(name: String) {
        self.name = name
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name
        ]
    }

}








