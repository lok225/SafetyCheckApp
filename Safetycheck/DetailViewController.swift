//
//  DetailViewController.swift
//  Safetycheck
//
//  Created by Martin Lok on 06/01/15.
//  Copyright (c) 2015 Martin Lok. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var navigationLabel: UINavigationItem!
    
    var mainVC: ViewController!
    var task: SafetyModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        mainVC.myTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
