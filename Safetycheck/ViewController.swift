//
//  ViewController.swift
//  Safetycheck
//
//  Created by Martin Lok on 05/01/15.
//  Copyright (c) 2015 Martin Lok. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    
    var taskArray: [SafetyModel] = []
    var doneTaskArray: [SafetyModel] = []
    
    var baseArray: [[SafetyModel]] = []
    
    var cell: TaskCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var task = SafetyModel(task: "hey", done: false)
        var task1 = SafetyModel(task: "hi", done: true)
        var task2 = SafetyModel(task: "hi", done: true)
        var task3 = SafetyModel(task: "hi", done: true)
        
        taskArray = []
        doneTaskArray = [task1,task, task2, task3]
        
        baseArray = [taskArray, doneTaskArray]
        
        var navBar = self.navigationController?.navigationBar
        
        navBar?.barStyle = UIBarStyle.BlackTranslucent
        navBar?.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTaskButtonTapped(sender: UIBarButtonItem) {
        // performSegueWithIdentifier("showAddTask", sender: nil)
        

    }
    
    @IBAction func reloadButtonTapped(sender: UIBarButtonItem) {
        println(doneTaskArray.count)
        
        var count = doneTaskArray.count
        for var number = 0; number < count; number++ {
            
            taskArray.append(SafetyModel(task: doneTaskArray[0].task, done: false))
            doneTaskArray.removeAtIndex(0)
        }
        
        myTable.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddTask" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        } else {
            let detailVC: DetailViewController = segue.destinationViewController as DetailViewController
            let indexPath = self.myTable.indexPathForSelectedRow()
            let thisTask: SafetyModel = baseArray[indexPath!.section][indexPath!.row]
            detailVC.task = thisTask
            detailVC.mainVC = self
            detailVC.navigationItem.title = thisTask.task
        }
    }
    
    // Number of sections and rows
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(taskArray.count)
        println(doneTaskArray.count)
        
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? TaskCell
        cell?.taskLabel.text = thisTask.task
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("detailSegue", sender: self)
        
    }

    
    // Swipe to edit
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        if baseArray[indexPath.section][indexPath.row].done == false {
            var doneAction = UITableViewRowAction(style: .Default, title: "Færdig", handler: { (action, indexPath) -> Void in
                tableView.editing = false
                let thisTask = self.baseArray[indexPath.section][indexPath.row]
                
                if indexPath.section == 0 {
                    var newTask = SafetyModel(task: thisTask.task, done: true)
                    self.baseArray[1].append(newTask)
                } else {
                    var newTask = SafetyModel(task: thisTask.task, done: false)
                    self.baseArray[0].append(newTask)
                }
                
                self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
                
                tableView.reloadData()

            })
            doneAction.backgroundColor = UIColor.greenColor()
            
            return [doneAction]
        } else {
            var notDoneAction = UITableViewRowAction(style: .Default, title: "Ikke Færdig", handler: { (action, indexPath) -> Void in
                tableView.editing = false
                let thisTask = self.baseArray[indexPath.section][indexPath.row]
                
                if indexPath.section == 0 {
                    var newTask = SafetyModel(task: thisTask.task, done: true)
                    self.baseArray[1].append(newTask)
                } else {
                    var newTask = SafetyModel(task: thisTask.task, done: false)
                    self.baseArray[0].append(newTask)
                }
                
                self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
                
                tableView.reloadData()

            })
            
            return [notDoneAction]
        }
    }
    
    
    
    // Header Attributes
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ikke Færdige"
        default:
            return "Færdige"
        }
    }
    
    
    
}

