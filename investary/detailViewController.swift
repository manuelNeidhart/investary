//
//  detailViewController.swift
//  investary
//
//  Created by AHITM16 on 28.06.22.
//

import UIKit

class detailViewController: UIViewController {
    
    var coursePartCounter: Int! = 0
    
    @IBOutlet weak var continueButtonText: RoundedButton!
    @IBOutlet weak var termLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBAction func continueButton(_ sender: Any) {
        if coursePartCounter == 1 {
            continueButtonText.setTitle("finish", for: .normal)
        }else if coursePartCounter >= 2{
            coursePartCounter = 0
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "finishSegue2", sender: self)
            }
            
        }
        coursePartCounter = coursePartCounter + 1
        viewWillAppear(true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    var terms = [course.courseElements]()
    var row = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.termLabel?.text = terms[row.self].wordName
        self.descriptionLabel?.text = terms[row.self].description[coursePartCounter]
    }
    
    func setData(rowV: Int, termsV: [course.courseElements]){
        self.terms = termsV
        self.row = rowV
    }

}
