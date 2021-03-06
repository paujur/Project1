//
//  DetailsViewController.swift
//  TuDuV2
//
//  Created by Paul Jurczyk on 11/16/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: IBOutlets -----------------------------------------
    
    @IBOutlet weak var taskDetailNameTextField: UITextField!
    
    @IBOutlet weak var taskDetailDetailsTextView: UITextView!

    @IBOutlet weak var taskDetailDueDateTextField: UITextField!
    
    // MARK: Local variable ---------------------------
    var task: Task?
    
    // MARK: IBActions ---------------------------
  

    @IBAction func saveTaskDetails(_ sender: Any) {
        task?.name = taskDetailNameTextField.text!
        task?.details = taskDetailDetailsTextView.text
        task?.dueDate = taskDetailDueDateTextField.text!
        navigationController!.popViewController(animated: true)
        
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
