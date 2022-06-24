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
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        
            
        }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = "Hello World"
        
        return cell
    }
}
    

