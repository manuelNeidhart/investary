//
//  detailViewController.swift
//  investary
//
//  Created by AHITM16 on 28.06.22.
//

import UIKit

class detailViewController: UIViewController {
    
    var coursePartCounter: Int! = 0
    
    @IBOutlet weak var termLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var wholeDescription = String()

    
    var terms = [course.courseElements]()
    var row = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.termLabel?.text = terms[row.self].wordName
        self.descriptionLabel?.text = terms[row.self].description[0]+" "+terms[row.self].description[1]+" "+terms[row.self].description[2]
    }
    
    func setData(rowV: Int, termsV: [course.courseElements]){
        self.terms = termsV
        self.row = rowV
    }

}
