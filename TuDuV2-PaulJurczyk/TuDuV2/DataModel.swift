//
//  DataModel.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//


import Foundation

// MARK: Global Variables ----------------------

var listOfListsArray = [ListOfTasks]()
//var currentListName: String?
//var currentTask: Task?
//var currentList = [Task]()

class Model {
    static let shared = Model()
//    private init() {}
    let key = "persist-lists"
    
    func persistListsToDefaults() {
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfListsArray)
        UserDefaults.standard.set(data, forKey: key)
    }
    func loadPersistedListsFromDefaults() {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
        let lists = NSKeyedUnarchiver.unarchiveObject(with: data) as! [ListOfTasks]
        
        listOfListsArray = lists
        }
    }
  
    
}


class ListOfTasks: NSObject, NSCoding {
    
    private struct Keys {
        static let name = "name"
        static let listOfTasksArray = "listOfTasksArray"
    }
    
    var name: String
    var listOfTasksArray = [Task]()
    init(name: String) {
        self.name = name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(listOfTasksArray, forKey: Keys.listOfTasksArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Keys.name) as! String
        listOfTasksArray = aDecoder.decodeObject(forKey: Keys.listOfTasksArray) as! [Task]
    }
    
}

class  Task: NSObject, NSCoding {
    
    private struct Keys {
        static let name = "name"
        static let details = "details"
        static let dueDate = "dueDate"
    }
    var name: String
    var details = String()
    var dueDate = String()
    init(name: String) {
        self.name = name
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(details, forKey: Keys.details)
        aCoder.encode(dueDate, forKey: Keys.dueDate)
    }
    
    required init?(coder aDecoder: NSCoder){
            name = aDecoder.decodeObject(forKey: Keys.name) as! String
            details = aDecoder.decodeObject(forKey: Keys.details) as! String
           dueDate = aDecoder.decodeObject(forKey: Keys.dueDate) as! String
        
    }
}
