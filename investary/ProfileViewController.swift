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
        self.navigationItem.hidesBackButton = true
        resetData()
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData(){
        getUserData() { (profiles) -> () in
            DispatchQueue.main.async {
                self.nameLabel.text? = profiles.name!
                self.skillLevelLabel.text? = profiles.skillLevel!
                self.courseLevelLabel.text? = profiles.courses![0].courseProgress!.description
                self.quizLevelLabel.text? = profiles.quiz!.quizProgress!.description
                self.libraryLevelLabel.text? = profiles.dictionary!.dictionaryProgress!.description
            }
        }
    }
    
    
    func resetData() {
        guard let url = URL(string: "http://localhost:8000/resetCourse/0") else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
            
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        if (httpResponse.statusCode != 200) {
                            return
                        }
                    }
                    
                }
                task.resume()
            }
    
    
    func getUserData(completionHandler: @escaping((_ userData: user)->())){
        guard let url = URL(string: "http://localhost:8000/profile") else {return}
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




