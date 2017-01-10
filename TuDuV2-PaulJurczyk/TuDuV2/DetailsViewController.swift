//
//  DetailsViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {
    
    
    // MARK: IBOutlets -----------------------------------------
    
    @IBOutlet weak var taskDetailNameTextField: UITextField!
    
    @IBOutlet weak var taskDetailDetailsTextView: UITextView!

    @IBOutlet weak var taskDetailDueDateTextField: UITextField!
    
    // MARK: Local variable ---------------------------
    var task: Task?
    var detailsCreatedBefore = false
    // MARK: IBActions ---------------------------
  

    @IBAction func saveTaskDetails(_ sender: Any) {
    
        if detailsCreatedBefore == false && task?.name == taskDetailNameTextField.text! {
        createDetails(details: taskDetailDetailsTextView.text, dueDate: taskDetailDueDateTextField.text!)
        } else {
            updateTask(newName: taskDetailNameTextField.text!, task: task!)
        }
        task?.name = taskDetailNameTextField.text!
        task?.details = taskDetailDetailsTextView.text
        task?.dueDate = taskDetailDueDateTextField.text!
        navigationController!.popViewController(animated: true)
        
    }
    
    func createDetails(details: String, dueDate: String){
        detailsCreatedBefore = true
        let detailsRef = FIRDatabase.database().reference(withPath: "lists/" + "\(currentListName!)/tasks" + "/" + "\(self.task!.name)")
        let detailRef = detailsRef.child("details")
        let dueDateRef = detailsRef.child("dueDate")
        detailRef.setValue(details)
        dueDateRef.setValue(dueDate)
        
    }
    
    func updateDetails(details: String, dueDate: String){
        detailsCreatedBefore = true
        let detailsRef = FIRDatabase.database().reference(withPath: "lists/" + "\(currentListName!)/tasks" + "/" + "\(taskDetailNameTextField.text!)")
        let detailRef = detailsRef.child("details")
        let dueDateRef = detailsRef.child("dueDate")
        detailRef.setValue(details)
        dueDateRef.setValue(dueDate)
    }
    
    func updateTask(newName: String, task: Task) {
        if task.name != newName {
            let ref = FIRDatabase.database().reference(withPath: "lists/" + "\(currentListName!)" + "/" + "\(self.task!.name)")
            ref.removeValue()
            createTask(name: newName)
            updateDetails(details: taskDetailDetailsTextView.text, dueDate: taskDetailDueDateTextField.text!)
        } else { print("something wrong here")}
    }
    
    func createTask(name: String){
        let tasksRef = FIRDatabase.database().reference(withPath: "lists/\(currentListName!)")
        let task = Task(name: name)
        let taskRef = tasksRef.child(name)
        taskRef.setValue(task.toAnyObject())
    }
    

    override func viewDidLoad() {
        if let task = task {
            taskDetailNameTextField.text = task.name
            taskDetailDetailsTextView.text = task.details
            taskDetailDueDateTextField.text = task.dueDate
        }
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
