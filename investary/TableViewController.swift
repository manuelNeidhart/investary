//
//  TableViewController.swift
//  investary
//
//  Created by AHITM16 on 28.06.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var terms = [course.courseElements]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEasyTerms { courseData in
            DispatchQueue.main.async {
                for i in 0...courseData.courseElements!.count-1{
                    self.terms.append(courseData.courseElements![i])
                }
               
                
                self.tableView.reloadData()
            }
            
        }
        
        getHardTerms { courseData in
            DispatchQueue.main.async {
                
                for i in 0...courseData.courseElements!.count-1{
                    self.terms.append(courseData.courseElements![i])
                }
                
                self.tableView.reloadData()
                print(self.terms)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
           let destination = segue.destination as? detailViewController,
           let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.setData(rowV: blogIndex, termsV: terms)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return terms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "termCell", for: indexPath)

        
        
        let term = self.terms[indexPath.row].wordName
        
        
        cell.textLabel?.text = term
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TERMS"
    }
    
    
    
    func getEasyTerms(completionHandler: @escaping((_ courseData: course)->())){
        guard let url = URL(string: "http://localhost:8000/course/0") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let courseData = try decoder.decode(course.self, from: data)
                
                completionHandler(courseData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getHardTerms(completionHandler: @escaping((_ courseData: course)->())){
        guard let url = URL(string: "http://localhost:8000/course/1") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let courseData = try decoder.decode(course.self, from: data)
                
                completionHandler(courseData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

