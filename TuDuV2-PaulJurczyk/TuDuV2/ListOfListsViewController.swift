//
//  ViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class ListOfListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlets -------------------------------
    
    @IBOutlet weak var newListNameTextField: UITextField!
    @IBOutlet weak var listOfListsTableView: UITableView!
    
    // MARK: IBActions ---------------------------
    
    @IBAction func addNewListButtonTapped(_ sender: UIButton) {
        let newListName = newListNameTextField.text
        if newListName != "" { // want to make sure not to add a list with no name
        let newList = ListOfTasks(name: newListName!)
        listOfListsArray.append(newList)
        }
        // clear the list name textfield
        listOfListsTableView.reloadData()
        newListNameTextField.text = ""
    }
    
    
    
   
    // MARK: UITableViewDataSource methods -----------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "EditListSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)  {
        if editingStyle == .delete {
            listOfListsArray.remove(at: indexPath.row)
            listOfListsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfListsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListOfListsTableViewCell
        listCell.listCellNameLabel.text = listOfListsArray[indexPath.row].name
        // set cell background to clear
        listCell.backgroundColor = UIColor.clear
        return listCell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditListSegue") {
            let singleListViewController = segue.destination as! SingleListViewController
            singleListViewController.list = listOfListsArray[(listOfListsTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // below gets rid of cells in table before they are created
        listOfListsTableView.tableFooterView = UIView(frame: CGRect.zero)
        // set the background of the table to clear
        listOfListsTableView.backgroundColor = UIColor.clear
        listOfListsTableView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

