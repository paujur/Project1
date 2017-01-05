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
var currentListName: String?
//var currentTask: Task?
//var currentList = [Task]()


// Going to create a global function that will synch firebase data to local data. Would be better to move into a class and create a singleton... but don't want to mess with the data model at this point.

func listenForChanges(){
    let lists = FIRDatabase.database().reference(withPath: "lists")
    lists.observe(.value, with: didUpdateNotes)
}

func didUpdateNotes(snapshot: FIRDataSnapshot){
    listOfListsArray.removeAll()
    
    let dict = snapshot
    for list in dict.children {
        let newList = ListOfTasks(snapshot: list as! FIRDataSnapshot)
        listOfListsArray.append(newList)
    }
        //ListOfTasks(snapshot: snapshot)
    
//    for list in snapshot.children{
//        let list = ListOfTasks(snapshot: list as! FIRDataSnapshot)
//        
       //    }
}


class ListOfTasks {
    var name: String
    var listOfTasksArray = [Task]()
    var ref: FIRDatabaseReference?
    init(name: String) {
        self.name = name
    }
    init(snapshot: FIRDataSnapshot) {
        let dict = snapshot.value as! [String : Any]
        name = snapshot.key
        ref = snapshot.ref
        let tasks = dict[snapshot.key] as! [Any]
        for task in tasks {
            let newTask = Task(snapshot: task as! FIRDataSnapshot)
            listOfTasksArray.append(newTask)
        }
    }
    
    // this changes it to an object for Firebase to use and creats a child with key "name"
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
    
     init(snapshot: FIRDataSnapshot) {
        let dict = snapshot.value as! [String : Any]
        name = snapshot.key
        ref = snapshot.ref
        details = dict["details"] as! String
        dueDate = dict["dueDate"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name
        ]
    }

}








