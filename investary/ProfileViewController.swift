//
//  ProfileViewController.swift
//  investary
//
//  Created by AHITM16 on 19.05.22.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var libraryLevelLabel: UILabel!
    @IBOutlet weak var quizLevelLabel: UILabel!
    @IBOutlet weak var courseLevelLabel: UILabel!
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        parseJSON() { (profiles) -> () in
            self.nameLabel.text? = profiles.name!
            self.skillLevelLabel.text? = profiles.skillLevel!
            self.courseLevelLabel.text? = profiles.courses![0].courseProgress!.description + "%"
            self.quizLevelLabel.text? = profiles.quiz!.quizProgress!.description + "%"
            self.libraryLevelLabel.text? = profiles.dictionary!.dictionaryProgress!.description + "%"
        }
        // Do any additional setup after loading the view.
    }
        
    func getUserData(completionHandler: @escaping((_ userData: user)->())){
        guard let url = URL(string: "localhost:8000/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                var userData = try decoder.decode(user.self, from: data)
                completionHandler(userData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func parseJSON(completionHandler: @escaping ((_ profiles: user)->())) {
        guard let path = Bundle.main.path(forResource: "./json/user", ofType: "json") else {
            
            return
        }
        let url = URL(fileURLWithPath: path)
        
        var result: user?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(user.self, from: jsonData)
            print(jsonData)
            print(result)
            if let result = result {
                print(result)
                completionHandler(result)
            }
            else {
                print("Failed to parse")
            }
        }
        catch {
            print("Error: \(error)")
        }
        
    }
}

struct user: Decodable {
    let name: String?
    let skillLevel: String?
    let avatar: String?

    struct courses: Decodable {
        let courseId: Int?
        let courseName: String?
        let courseProgress: Int?
    }
    let courses: [courses]?

    struct dictionary: Decodable {
        let dictionaryProgress: Int?
    }
    let dictionary: dictionary?
    
    struct quiz: Decodable {
        let quizId: Int?
        let quizName: String?
        let quizProgress: Int?
    }
    let quiz: quiz?
}

    
    

