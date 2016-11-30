//
//  SingleListViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class SingleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets --------------------------------
    
    @IBOutlet weak var listOfTasksTableView: UITableView!
    
    @IBOutlet weak var newTaskNameTextField: UITextField!
    
    @IBOutlet weak var currentListNameTextField: UITextField!
    
    

    // MARK: Local variable ---------------------------
    var list: ListOfTasks?

    // MARK: IBActions ---------------------------
    
    @IBAction func saveListDetails(_ sender: Any) {
        list?.name = currentListNameTextField.text!
        navigationController!.popViewController(animated: true)
    }
    
    

    
    
    @IBAction func addNewTaskButtonTapped(_ sender: UIButton) {
        // below is to change the list name if user decides to change it
        
    
        let newTaskName = newTaskNameTextField.text
        if newTaskName != "" { // make sure not to add a task with no name
            let newTask = Task(name: newTaskName!)
            list?.listOfTasksArray.append(newTask)
        }
        listOfTasksTableView.reloadData()
        newTaskNameTextField.text = ""
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
