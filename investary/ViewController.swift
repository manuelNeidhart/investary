//
//  ViewController.swift
//  investary
//
//  Created by Reinhart Robin on 11.03.22.
//

import UIKit
import *

class ViewController: UIViewController {

    @IBAction func firstSegueButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    let nextVC = storyboard.instantiateViewController(withIdentifier: "mainPageViewController") as! NextVCClass
    nextVC.modalPresentationStyle = .fullScreen
    self.present(nextVC, animated: true)
    
    
}
    

