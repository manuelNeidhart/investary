//
//  ViewController.swift
//  investary
//
//  Created by Reinhart Robin on 11.03.22.
//

import UIKit
class ViewController: UIViewController {

    @IBAction func firstSegueButton(_ sender: Any) {
    }
    
    @IBOutlet weak var termLabel: UILabel!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        self.navigationItem.hidesBackButton = true
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isTranslucent = false
    }
}

    

