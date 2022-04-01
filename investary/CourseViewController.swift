//
//  CourseViewController.swift
//  investary
//
//  Created by Reinhart Robin on 01.04.22.
//

import UIKit

class CourseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let line = CAShapeLayer()
         let linePath = UIBezierPath()
         linePath.move(to: CGPoint(x: 130, y: 205))
         linePath.addLine(to: CGPoint(x: 285, y: 205))
         line.path = linePath.cgPath
         line.strokeColor = UIColor.black.cgColor
         self.view.layer.addSublayer(line)
    }
}
