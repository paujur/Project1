//
//  SingleListViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit
import Firebase

class SingleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets --------------------------------
    
    @IBOutlet weak var listOfTasksTableView: UITableView!
    
    @IBOutlet weak var newTaskNameTextField: UITextField!
    
    @IBOutlet weak var currentListNameTextField: UITextField!
    
    

    // MARK: Local variable ---------------------------
    var list: ListOfTasks?

    // MARK: IBActions ---------------------------
    
    @IBAction func saveListDetails(_ sender: Any) {
        updateListName(newName: currentListNameTextField.text!, list: list!)
        list?.name = currentListNameTextField.text!
        navigationController!.popViewController(animated: true)
    }
    
    

    
    
    @IBAction func addNewTaskButtonTapped(_ sender: UIButton) {
        currentListName = currentListNameTextField.text!
        
        let newTaskName = newTaskNameTextField.text
        if newTaskName != "" { // make sure not to add a task with no name
            let newTask = Task(name: newTaskName!)
            list?.listOfTasksArray.append(newTask)
        }
        listOfTasksTableView.reloadData()
        newTaskNameTextField.text = ""
        // add it to Firebase
        createTask(name: newTaskName!)
    }
    
    
    // MARK: Firebase: Create, Update, Delete
    
    func createTask(name: String){
        let tasksRef = FIRDatabase.database().reference(withPath: "lists/\(list!.name)")
        let task = Task(name: name)
        let taskRef = tasksRef.child(name)
        taskRef.setValue(task.toAnyObject())
    }
    
    func createTaskAfterUpdate(name: String, listName: String){
        let tasksRef = FIRDatabase.database().reference(withPath: "lists/\(listName)")
        let task = Task(name: name)
        let taskRef = tasksRef.child(name)
        taskRef.setValue(task.toAnyObject())
    }
    
    
    func createListOfLists(name: String){
        let listOfListsRef = FIRDatabase.database().reference(withPath: "lists")
        let listOfLists = ListOfTasks(name: name)
        let listOfListRef = listOfListsRef.child(name)
        listOfListRef.setValue(listOfLists.toAnyObject())
    }
    func updateListName(newName: String, list: ListOfTasks) {
        if list.name != newName {
            let ref = FIRDatabase.database().reference(withPath: "lists/\(list.name)")
            ref.removeValue()
            createListOfLists(name: newName)
            for task in list.listOfTasksArray {
                createTaskAfterUpdate(name: task.name, listName: newName)
            }
        } else { print("something wrong here")}
    }
    
    // MARK: UITableViewDataSource methods -----------------------
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "EditTaskSegue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)  {
        if editingStyle == .delete {
            list?.listOfTasksArray.remove(at: indexPath.row)
            listOfTasksTableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = list else { return 0 }
        return list.listOfTasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! ListOfTasksTableViewCell
        taskCell.taskCellNameLabel.text = list?.listOfTasksArray[indexPath.row].name
        // set cell background to clear
        taskCell.backgroundColor = UIColor.clear
        return taskCell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditTaskSegue") {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.task = list?.listOfTasksArray[(listOfTasksTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // below gets rid of cells in table before they are created
        listOfTasksTableView.tableFooterView = UIView(frame: CGRect.zero)
        // set the background of the table to clear
        listOfTasksTableView.backgroundColor = UIColor.clear

        currentListNameTextField.text = list?.name
        listOfTasksTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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
