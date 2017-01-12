//
//  DataModel.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//


import Foundation

// MARK: Global Variables ----------------------

var listOfListsArray = [List]()

extension List {
    
    var tasksArray: [Task] {
        
        if self.tasks?.count == 0 {
            return [Task]()
        }
        
        return Array(self.tasks!) as! [Task]
    }
}






//var listOfListsArray = [ListOfTasks]()
//var currentListName: String?
//var currentTask: Task?
//var currentList = [Task]()

//
//
//
//class ListOfTasks {
//    var name: String
//    var listOfTasksArray = [Task]()
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class  Task {
//    
//    var name: String
//    var details = String()
//    var dueDate = String()
//    init(name: String) {
//        self.name = name
//    }
//    
//    // needs to hold task title, details, and due date -> all string format
//}
