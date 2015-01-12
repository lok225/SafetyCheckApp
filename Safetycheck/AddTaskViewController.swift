//
//  AddTaskViewController.swift
//  Safetycheck
//
//  Created by Martin Lok on 12/01/15.
//  Copyright (c) 2015 Martin Lok. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(mainVC?.baseArray.count)
        println(mainVC?.taskArray.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var task = SafetyModel(task: taskTextField.text, done: false)
        
        mainVC?.baseArray[0].append(task)
        mainVC?.myTable.reloadData()
        
        textField.resignFirstResponder()
        self.navigationController?.popViewControllerAnimated(true)
        
        return true
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        var task = SafetyModel(task: taskTextField.text, done: false)
        
        mainVC?.baseArray[0].append(task)
        mainVC?.myTable.reloadData()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
